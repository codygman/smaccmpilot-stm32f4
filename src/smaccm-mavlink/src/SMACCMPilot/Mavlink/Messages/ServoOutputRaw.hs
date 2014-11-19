{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.ServoOutputRaw where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

servoOutputRawMsgId :: Uint8
servoOutputRawMsgId = 36

servoOutputRawCrcExtra :: Uint8
servoOutputRawCrcExtra = 222

servoOutputRawModule :: Module
servoOutputRawModule = package "mavlink_servo_output_raw_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkServoOutputRawSender
  incl servoOutputRawUnpack
  defStruct (Proxy :: Proxy "servo_output_raw_msg")
  incl servoOutputRawPackRef
  incl servoOutputRawUnpackRef

[ivory|
struct servo_output_raw_msg
  { time_usec :: Stored Uint32
  ; servo1_raw :: Stored Uint16
  ; servo2_raw :: Stored Uint16
  ; servo3_raw :: Stored Uint16
  ; servo4_raw :: Stored Uint16
  ; servo5_raw :: Stored Uint16
  ; servo6_raw :: Stored Uint16
  ; servo7_raw :: Stored Uint16
  ; servo8_raw :: Stored Uint16
  ; port :: Stored Uint8
  }
|]

mkServoOutputRawSender ::
  Def ('[ ConstRef s0 (Struct "servo_output_raw_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkServoOutputRawSender = makeMavlinkSender "servo_output_raw_msg" servoOutputRawMsgId servoOutputRawCrcExtra

instance MavlinkUnpackableMsg "servo_output_raw_msg" where
    unpackMsg = ( servoOutputRawUnpack , servoOutputRawMsgId )

servoOutputRawUnpack :: Def ('[ Ref s1 (Struct "servo_output_raw_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
servoOutputRawUnpack = proc "mavlink_servo_output_raw_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

servoOutputRawPackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "servo_output_raw_msg")
                              ] :-> () )
servoOutputRawPackRef = proc "mavlink_servo_output_raw_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> time_usec)
  packRef buf (off + 4) (msg ~> servo1_raw)
  packRef buf (off + 6) (msg ~> servo2_raw)
  packRef buf (off + 8) (msg ~> servo3_raw)
  packRef buf (off + 10) (msg ~> servo4_raw)
  packRef buf (off + 12) (msg ~> servo5_raw)
  packRef buf (off + 14) (msg ~> servo6_raw)
  packRef buf (off + 16) (msg ~> servo7_raw)
  packRef buf (off + 18) (msg ~> servo8_raw)
  packRef buf (off + 20) (msg ~> port)

servoOutputRawUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "servo_output_raw_msg")
                                ] :-> () )
servoOutputRawUnpackRef = proc "mavlink_servo_output_raw_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> time_usec)
  unpackRef buf (off + 4) (msg ~> servo1_raw)
  unpackRef buf (off + 6) (msg ~> servo2_raw)
  unpackRef buf (off + 8) (msg ~> servo3_raw)
  unpackRef buf (off + 10) (msg ~> servo4_raw)
  unpackRef buf (off + 12) (msg ~> servo5_raw)
  unpackRef buf (off + 14) (msg ~> servo6_raw)
  unpackRef buf (off + 16) (msg ~> servo7_raw)
  unpackRef buf (off + 18) (msg ~> servo8_raw)
  unpackRef buf (off + 20) (msg ~> port)

instance SerializableRef (Struct "servo_output_raw_msg") where
  packRef = call_ servoOutputRawPackRef
  unpackRef = call_ servoOutputRawUnpackRef
