{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Ivory.Language
import Ivory.Stdlib

import Ivory.Tower
import Ivory.Tower.Config
import Ivory.Tower.Compile
import Ivory.OS.FreeRTOS.Tower.STM32

import Ivory.BSP.STM32.Driver.UART
import Ivory.BSP.STM32.Driver.RingBuffer

import qualified BSP.Tests.Platforms as BSP

import SMACCMPilot.Commsec.Sizes
import SMACCMPilot.Datalink.HXStream.Tower
import SMACCMPilot.Datalink.HXStream.Ivory (hxstreamModule)

main :: IO ()
main = towerCompile p (app id)
  where
  p topts = do
    cfg <- getConfig topts BSP.testPlatformParser
    return $ stm32FreeRTOS BSP.testplatform_stm32 cfg

app :: (e -> BSP.TestPlatform)
    -> Tower e ()
app totp = do
  tp <- fmap totp getEnv
  let cu = BSP.testplatform_uart tp
  (o,i) <- uartTower tocc (BSP.testUARTPeriph cu) (BSP.testUARTPins cu)
                     115200 (Proxy :: Proxy 256)
  frame_loopback i o
  where
  tocc = BSP.testplatform_clockconfig . totp

frame_loopback :: ChanInput (Stored Uint8)
               -> ChanOutput (Stored Uint8)
               -> Tower p ()
frame_loopback o i = do
  ctin <- channel
  ctout <- channel
  hxstreamDecodeTower "test" i (fst ctin)
  hxstreamEncodeTower "test" (snd ctout) o

  p <- period (Milliseconds 10)

  monitor "buffered_ctloopback" $ do
    (rb :: RingBuffer 4 CyphertextArray) <- monitorRingBuffer "loopback"
    handler (snd ctin) "ct_in" $ do
      callback $ \v -> do
        _ <- ringbuffer_push rb v
        return ()
    handler p "periodic_pop" $ do
      e <- emitter (fst ctout) 1
      callback $ \_ -> do
        v <- local (iarray [])
        got <- ringbuffer_pop rb v
        when got $ do
          emit e (constRef v)

  towerModule $ hxstreamModule

