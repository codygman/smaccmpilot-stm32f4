{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.CommandLong where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

commandLongMsgId :: Uint8
commandLongMsgId = 76

commandLongCrcExtra :: Uint8
commandLongCrcExtra = 152

commandLongModule :: Module
commandLongModule = package "mavlink_command_long_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkCommandLongSender
  incl commandLongUnpack
  defStruct (Proxy :: Proxy "command_long_msg")
  incl commandLongPackRef
  incl commandLongUnpackRef

[ivory|
struct command_long_msg
  { param1 :: Stored IFloat
  ; param2 :: Stored IFloat
  ; param3 :: Stored IFloat
  ; param4 :: Stored IFloat
  ; param5 :: Stored IFloat
  ; param6 :: Stored IFloat
  ; param7 :: Stored IFloat
  ; command :: Stored Uint16
  ; target_system :: Stored Uint8
  ; target_component :: Stored Uint8
  ; confirmation :: Stored Uint8
  }
|]

mkCommandLongSender ::
  Def ('[ ConstRef s0 (Struct "command_long_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkCommandLongSender = makeMavlinkSender "command_long_msg" commandLongMsgId commandLongCrcExtra

instance MavlinkUnpackableMsg "command_long_msg" where
    unpackMsg = ( commandLongUnpack , commandLongMsgId )

commandLongUnpack :: Def ('[ Ref s1 (Struct "command_long_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
commandLongUnpack = proc "mavlink_command_long_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

commandLongPackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "command_long_msg")
                              ] :-> () )
commandLongPackRef = proc "mavlink_command_long_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> param1)
  packRef buf (off + 4) (msg ~> param2)
  packRef buf (off + 8) (msg ~> param3)
  packRef buf (off + 12) (msg ~> param4)
  packRef buf (off + 16) (msg ~> param5)
  packRef buf (off + 20) (msg ~> param6)
  packRef buf (off + 24) (msg ~> param7)
  packRef buf (off + 28) (msg ~> command)
  packRef buf (off + 30) (msg ~> target_system)
  packRef buf (off + 31) (msg ~> target_component)
  packRef buf (off + 32) (msg ~> confirmation)

commandLongUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "command_long_msg")
                                ] :-> () )
commandLongUnpackRef = proc "mavlink_command_long_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> param1)
  unpackRef buf (off + 4) (msg ~> param2)
  unpackRef buf (off + 8) (msg ~> param3)
  unpackRef buf (off + 12) (msg ~> param4)
  unpackRef buf (off + 16) (msg ~> param5)
  unpackRef buf (off + 20) (msg ~> param6)
  unpackRef buf (off + 24) (msg ~> param7)
  unpackRef buf (off + 28) (msg ~> command)
  unpackRef buf (off + 30) (msg ~> target_system)
  unpackRef buf (off + 31) (msg ~> target_component)
  unpackRef buf (off + 32) (msg ~> confirmation)

instance SerializableRef (Struct "command_long_msg") where
  packRef = call_ commandLongPackRef
  unpackRef = call_ commandLongUnpackRef
