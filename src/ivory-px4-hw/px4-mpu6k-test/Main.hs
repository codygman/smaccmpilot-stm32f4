{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Ivory.Language
import Ivory.Stdlib

import Ivory.Tower
import Ivory.Tower.StateMachine
import Ivory.Tower.Frontend

import Ivory.BSP.STM32F4.RCC (BoardHSE)
import qualified Ivory.HW.SearchDir          as HW
import qualified Ivory.BSP.STM32F4.SearchDir as BSP

import Ivory.BSP.STM32F4.UART.Tower
import Ivory.BSP.STM32F4.SPI
import Ivory.BSP.STM32F4.Signalable

import SMACCMPilot.Hardware.MPU6000

import Platform

main :: IO ()
main = compilePlatforms conf (gpsPlatforms app)
  where
  conf = searchPathConf [ HW.searchDir, BSP.searchDir ]

app :: forall p . (MPU6kPlatform p, BoardHSE p, STM32F4Signal p) => Tower p ()
app = do
  towerModule  rawSensorTypeModule
  towerDepends rawSensorTypeModule

  raw_sensor <- channel

  (_consIn,_consOut) <- uartTower (consoleUart (Proxy :: Proxy p))
                                115200 (Proxy :: Proxy 128)

  (req, res) <- spiTower [mpu6000Device (Proxy :: Proxy p)]

  mpu6kCtl req res (src raw_sensor) (SPIDeviceHandle 0)

  -- XXX hook snk raw_sensor up to console.

mpu6kCtl :: forall p
        . (BoardHSE p, STM32F4Signal p)
       => ChannelSource (Struct "spi_transaction_request")
       -> ChannelSink   (Struct "spi_transaction_result")
       -> ChannelSource (Struct "mpu6000_raw_sensor")
       -> SPIDeviceHandle
       -> Tower p ()
mpu6kCtl toDriver fromDriver sensorSource dh = task "mpu6kCtl" $ do
  spiRequest <- withChannelEmitter toDriver "toDriver"
  spiResult <- withChannelEvent fromDriver "fromDriver"
  sensorEmitter <- withChannelEmitter sensorSource "sensorOutput"

  (initMachine, initError) <- initializerMachine dh spiRequest spiResult

  taskStackSize 2048

  taskInit $ do
    begin initMachine

  p <- withPeriodicEvent (Milliseconds 5) -- 200hz
  handle p "period" $ \_ -> do
    initializing <- active initMachine
    unless initializing $ do
      e <- deref initError
      ifte_ e
        (invalidSensor >>= emit_ sensorEmitter)
        (getSensorsReq dh >>= emit_ spiRequest)

  handle spiResult "spiResult" $ \res -> do
    initializing <- active initMachine
    unless initializing $ do
      t <- getTime
      r <- rawSensorFromResponse res t
      emit_ sensorEmitter r

  where
  invalidSensor :: (GetAlloc eff ~ Scope s)
                => Ivory eff (ConstRef (Stack s) (Struct "mpu6000_raw_sensor"))
  invalidSensor = do
    t <- getTime
    fmap constRef $ local $ istruct
      [ valid .= ival false, time .= ival t ]
