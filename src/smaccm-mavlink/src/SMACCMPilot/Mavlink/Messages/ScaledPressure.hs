{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.ScaledPressure where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

scaledPressureMsgId :: Uint8
scaledPressureMsgId = 29

scaledPressureCrcExtra :: Uint8
scaledPressureCrcExtra = 115

scaledPressureModule :: Module
scaledPressureModule = package "mavlink_scaled_pressure_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkScaledPressureSender
  incl scaledPressureUnpack
  defStruct (Proxy :: Proxy "scaled_pressure_msg")

[ivory|
struct scaled_pressure_msg
  { time_boot_ms :: Stored Uint32
  ; press_abs :: Stored IFloat
  ; press_diff :: Stored IFloat
  ; temperature :: Stored Sint16
  }
|]

mkScaledPressureSender ::
  Def ('[ ConstRef s0 (Struct "scaled_pressure_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkScaledPressureSender =
  proc "mavlink_scaled_pressure_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 14 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 0 =<< deref (msg ~> time_boot_ms)
  pack buf 4 =<< deref (msg ~> press_abs)
  pack buf 8 =<< deref (msg ~> press_diff)
  pack buf 12 =<< deref (msg ~> temperature)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 14 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "scaledPressure payload of length 14 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    scaledPressureMsgId
                    scaledPressureCrcExtra
                    14
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "scaled_pressure_msg" where
    unpackMsg = ( scaledPressureUnpack , scaledPressureMsgId )

scaledPressureUnpack :: Def ('[ Ref s1 (Struct "scaled_pressure_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
scaledPressureUnpack = proc "mavlink_scaled_pressure_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_boot_ms) =<< unpack buf 0
  store (msg ~> press_abs) =<< unpack buf 4
  store (msg ~> press_diff) =<< unpack buf 8
  store (msg ~> temperature) =<< unpack buf 12

