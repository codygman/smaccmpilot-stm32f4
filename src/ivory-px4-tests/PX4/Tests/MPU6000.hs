{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}

module PX4.Tests.MPU6000
  ( mpu6000SensorManager
  , mpu6000Sender
  , app
  ) where

import Ivory.Language
import Ivory.Serialize
import qualified SMACCMPilot.Datalink.HXStream.Ivory as HX

import Ivory.Tower

import Ivory.BSP.STM32.Driver.SPI

import SMACCMPilot.Hardware.MPU6000

import PX4.Tests.Platforms

app :: (e -> PX4Platform) -> Tower e ()
app topx4 = do
  sample <- channel
  px4platform <- fmap topx4 getEnv
  let mpu6000  = px4platform_mpu6000 px4platform
  (req, res, ready) <- spiTower (px4platform_clockconfig . topx4)
                                [mpu6000_spi_device mpu6000]
                                (mpu6000_spi_pins mpu6000)
  mpu6000SensorManager req res ready (fst sample) (SPIDeviceHandle 0)

  (_uarti, uarto) <- px4ConsoleTower topx4
  monitor "mpu6000sender" $ do
    mpu6000Sender (snd sample) uarto

  towerDepends serializeModule
  towerModule  serializeModule
  mapM_ towerArtifact serializeArtifacts

mpu6000Sender :: ChanOutput (Struct "mpu6000_sample")
              -> ChanInput (Stored Uint8)
              -> Monitor e ()
mpu6000Sender meas out = do
  (buf :: Ref Global (Array 38 (Stored Uint8))) <- state "mpu6000_ser_buf"
  handler meas "measurement" $ do
    e <- emitter out (38*2 + 3)
    callback $ \s -> noReturn $ do
      packInto buf 0 s
      HX.encode tag (constRef buf) (emitV e)
  where
  tag = 103 -- 'g' for gyro
