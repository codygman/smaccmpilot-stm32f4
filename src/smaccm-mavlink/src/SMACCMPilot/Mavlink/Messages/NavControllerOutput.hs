{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.NavControllerOutput where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

navControllerOutputMsgId :: Uint8
navControllerOutputMsgId = 62

navControllerOutputCrcExtra :: Uint8
navControllerOutputCrcExtra = 183

navControllerOutputModule :: Module
navControllerOutputModule = package "mavlink_nav_controller_output_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkNavControllerOutputSender
  incl navControllerOutputUnpack
  defStruct (Proxy :: Proxy "nav_controller_output_msg")
  incl navControllerOutputPackRef
  incl navControllerOutputUnpackRef

[ivory|
struct nav_controller_output_msg
  { nav_roll :: Stored IFloat
  ; nav_pitch :: Stored IFloat
  ; alt_error :: Stored IFloat
  ; aspd_error :: Stored IFloat
  ; xtrack_error :: Stored IFloat
  ; nav_bearing :: Stored Sint16
  ; target_bearing :: Stored Sint16
  ; wp_dist :: Stored Uint16
  }
|]

mkNavControllerOutputSender ::
  Def ('[ ConstRef s0 (Struct "nav_controller_output_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkNavControllerOutputSender = makeMavlinkSender "nav_controller_output_msg" navControllerOutputMsgId navControllerOutputCrcExtra

instance MavlinkUnpackableMsg "nav_controller_output_msg" where
    unpackMsg = ( navControllerOutputUnpack , navControllerOutputMsgId )

navControllerOutputUnpack :: Def ('[ Ref s1 (Struct "nav_controller_output_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
navControllerOutputUnpack = proc "mavlink_nav_controller_output_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

navControllerOutputPackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "nav_controller_output_msg")
                              ] :-> () )
navControllerOutputPackRef = proc "mavlink_nav_controller_output_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> nav_roll)
  packRef buf (off + 4) (msg ~> nav_pitch)
  packRef buf (off + 8) (msg ~> alt_error)
  packRef buf (off + 12) (msg ~> aspd_error)
  packRef buf (off + 16) (msg ~> xtrack_error)
  packRef buf (off + 20) (msg ~> nav_bearing)
  packRef buf (off + 22) (msg ~> target_bearing)
  packRef buf (off + 24) (msg ~> wp_dist)

navControllerOutputUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "nav_controller_output_msg")
                                ] :-> () )
navControllerOutputUnpackRef = proc "mavlink_nav_controller_output_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> nav_roll)
  unpackRef buf (off + 4) (msg ~> nav_pitch)
  unpackRef buf (off + 8) (msg ~> alt_error)
  unpackRef buf (off + 12) (msg ~> aspd_error)
  unpackRef buf (off + 16) (msg ~> xtrack_error)
  unpackRef buf (off + 20) (msg ~> nav_bearing)
  unpackRef buf (off + 22) (msg ~> target_bearing)
  unpackRef buf (off + 24) (msg ~> wp_dist)

instance SerializableRef (Struct "nav_controller_output_msg") where
  packRef = call_ navControllerOutputPackRef
  unpackRef = call_ navControllerOutputUnpackRef
