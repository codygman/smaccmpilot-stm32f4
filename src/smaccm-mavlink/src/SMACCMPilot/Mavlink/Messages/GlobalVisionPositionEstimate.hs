{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.GlobalVisionPositionEstimate where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

globalVisionPositionEstimateMsgId :: Uint8
globalVisionPositionEstimateMsgId = 101

globalVisionPositionEstimateCrcExtra :: Uint8
globalVisionPositionEstimateCrcExtra = 102

globalVisionPositionEstimateModule :: Module
globalVisionPositionEstimateModule = package "mavlink_global_vision_position_estimate_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkGlobalVisionPositionEstimateSender
  incl globalVisionPositionEstimateUnpack
  defStruct (Proxy :: Proxy "global_vision_position_estimate_msg")
  incl globalVisionPositionEstimatePackRef
  incl globalVisionPositionEstimateUnpackRef

[ivory|
struct global_vision_position_estimate_msg
  { usec :: Stored Uint64
  ; x :: Stored IFloat
  ; y :: Stored IFloat
  ; z :: Stored IFloat
  ; roll :: Stored IFloat
  ; pitch :: Stored IFloat
  ; yaw :: Stored IFloat
  }
|]

mkGlobalVisionPositionEstimateSender ::
  Def ('[ ConstRef s0 (Struct "global_vision_position_estimate_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkGlobalVisionPositionEstimateSender = makeMavlinkSender "global_vision_position_estimate_msg" globalVisionPositionEstimateMsgId globalVisionPositionEstimateCrcExtra

instance MavlinkUnpackableMsg "global_vision_position_estimate_msg" where
    unpackMsg = ( globalVisionPositionEstimateUnpack , globalVisionPositionEstimateMsgId )

globalVisionPositionEstimateUnpack :: Def ('[ Ref s1 (Struct "global_vision_position_estimate_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
globalVisionPositionEstimateUnpack = proc "mavlink_global_vision_position_estimate_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

globalVisionPositionEstimatePackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "global_vision_position_estimate_msg")
                              ] :-> () )
globalVisionPositionEstimatePackRef = proc "mavlink_global_vision_position_estimate_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> usec)
  packRef buf (off + 8) (msg ~> x)
  packRef buf (off + 12) (msg ~> y)
  packRef buf (off + 16) (msg ~> z)
  packRef buf (off + 20) (msg ~> roll)
  packRef buf (off + 24) (msg ~> pitch)
  packRef buf (off + 28) (msg ~> yaw)

globalVisionPositionEstimateUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "global_vision_position_estimate_msg")
                                ] :-> () )
globalVisionPositionEstimateUnpackRef = proc "mavlink_global_vision_position_estimate_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> usec)
  unpackRef buf (off + 8) (msg ~> x)
  unpackRef buf (off + 12) (msg ~> y)
  unpackRef buf (off + 16) (msg ~> z)
  unpackRef buf (off + 20) (msg ~> roll)
  unpackRef buf (off + 24) (msg ~> pitch)
  unpackRef buf (off + 28) (msg ~> yaw)

instance SerializableRef (Struct "global_vision_position_estimate_msg") where
  packRef = call_ globalVisionPositionEstimatePackRef
  unpackRef = call_ globalVisionPositionEstimateUnpackRef
