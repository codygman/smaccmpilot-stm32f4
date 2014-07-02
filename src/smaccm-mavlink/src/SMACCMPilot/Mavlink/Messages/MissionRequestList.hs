{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.MissionRequestList where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

missionRequestListMsgId :: Uint8
missionRequestListMsgId = 43

missionRequestListCrcExtra :: Uint8
missionRequestListCrcExtra = 132

missionRequestListModule :: Module
missionRequestListModule = package "mavlink_mission_request_list_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkMissionRequestListSender
  incl missionRequestListUnpack
  defStruct (Proxy :: Proxy "mission_request_list_msg")

[ivory|
struct mission_request_list_msg
  { target_system :: Stored Uint8
  ; target_component :: Stored Uint8
  }
|]

mkMissionRequestListSender ::
  Def ('[ ConstRef s0 (Struct "mission_request_list_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkMissionRequestListSender =
  proc "mavlink_mission_request_list_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 2 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 0 =<< deref (msg ~> target_system)
  pack buf 1 =<< deref (msg ~> target_component)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 2 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "missionRequestList payload of length 2 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    missionRequestListMsgId
                    missionRequestListCrcExtra
                    2
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "mission_request_list_msg" where
    unpackMsg = ( missionRequestListUnpack , missionRequestListMsgId )

missionRequestListUnpack :: Def ('[ Ref s1 (Struct "mission_request_list_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
missionRequestListUnpack = proc "mavlink_mission_request_list_unpack" $ \ msg buf -> body $ do
  store (msg ~> target_system) =<< unpack buf 0
  store (msg ~> target_component) =<< unpack buf 1

