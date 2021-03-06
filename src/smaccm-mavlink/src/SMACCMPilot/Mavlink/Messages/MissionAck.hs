{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.MissionAck where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

missionAckMsgId :: Uint8
missionAckMsgId = 47

missionAckCrcExtra :: Uint8
missionAckCrcExtra = 153

missionAckModule :: Module
missionAckModule = package "mavlink_mission_ack_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkMissionAckSender
  incl missionAckUnpack
  defStruct (Proxy :: Proxy "mission_ack_msg")
  wrappedPackMod missionAckWrapper

[ivory|
struct mission_ack_msg
  { target_system :: Stored Uint8
  ; target_component :: Stored Uint8
  ; mission_ack_type :: Stored Uint8
  }
|]

mkMissionAckSender ::
  Def ('[ ConstRef s0 (Struct "mission_ack_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkMissionAckSender = makeMavlinkSender "mission_ack_msg" missionAckMsgId missionAckCrcExtra

instance MavlinkUnpackableMsg "mission_ack_msg" where
    unpackMsg = ( missionAckUnpack , missionAckMsgId )

missionAckUnpack :: Def ('[ Ref s1 (Struct "mission_ack_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
missionAckUnpack = proc "mavlink_mission_ack_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

missionAckWrapper :: WrappedPackRep (Struct "mission_ack_msg")
missionAckWrapper = wrapPackRep "mavlink_mission_ack" $ packStruct
  [ packLabel target_system
  , packLabel target_component
  , packLabel mission_ack_type
  ]

instance Packable (Struct "mission_ack_msg") where
  packRep = wrappedPackRep missionAckWrapper
