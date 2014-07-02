{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.SetQuadSwarmRollPitchYawThrust where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

setQuadSwarmRollPitchYawThrustMsgId :: Uint8
setQuadSwarmRollPitchYawThrustMsgId = 61

setQuadSwarmRollPitchYawThrustCrcExtra :: Uint8
setQuadSwarmRollPitchYawThrustCrcExtra = 240

setQuadSwarmRollPitchYawThrustModule :: Module
setQuadSwarmRollPitchYawThrustModule = package "mavlink_set_quad_swarm_roll_pitch_yaw_thrust_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkSetQuadSwarmRollPitchYawThrustSender
  incl setQuadSwarmRollPitchYawThrustUnpack
  defStruct (Proxy :: Proxy "set_quad_swarm_roll_pitch_yaw_thrust_msg")

[ivory|
struct set_quad_swarm_roll_pitch_yaw_thrust_msg
  { group :: Stored Uint8
  ; mode :: Stored Uint8
  ; roll :: Array 4 (Stored Sint16)
  ; pitch :: Array 4 (Stored Sint16)
  ; yaw :: Array 4 (Stored Sint16)
  ; thrust :: Array 4 (Stored Uint16)
  }
|]

mkSetQuadSwarmRollPitchYawThrustSender ::
  Def ('[ ConstRef s0 (Struct "set_quad_swarm_roll_pitch_yaw_thrust_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkSetQuadSwarmRollPitchYawThrustSender =
  proc "mavlink_set_quad_swarm_roll_pitch_yaw_thrust_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 34 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 32 =<< deref (msg ~> group)
  pack buf 33 =<< deref (msg ~> mode)
  arrayPack buf 0 (msg ~> roll)
  arrayPack buf 8 (msg ~> pitch)
  arrayPack buf 16 (msg ~> yaw)
  arrayPack buf 24 (msg ~> thrust)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 34 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "setQuadSwarmRollPitchYawThrust payload of length 34 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    setQuadSwarmRollPitchYawThrustMsgId
                    setQuadSwarmRollPitchYawThrustCrcExtra
                    34
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "set_quad_swarm_roll_pitch_yaw_thrust_msg" where
    unpackMsg = ( setQuadSwarmRollPitchYawThrustUnpack , setQuadSwarmRollPitchYawThrustMsgId )

setQuadSwarmRollPitchYawThrustUnpack :: Def ('[ Ref s1 (Struct "set_quad_swarm_roll_pitch_yaw_thrust_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setQuadSwarmRollPitchYawThrustUnpack = proc "mavlink_set_quad_swarm_roll_pitch_yaw_thrust_unpack" $ \ msg buf -> body $ do
  store (msg ~> group) =<< unpack buf 32
  store (msg ~> mode) =<< unpack buf 33
  arrayUnpack buf 0 (msg ~> roll)
  arrayUnpack buf 8 (msg ~> pitch)
  arrayUnpack buf 16 (msg ~> yaw)
  arrayUnpack buf 24 (msg ~> thrust)

