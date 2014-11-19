{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.Setpoint6dof where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

setpoint6dofMsgId :: Uint8
setpoint6dofMsgId = 149

setpoint6dofCrcExtra :: Uint8
setpoint6dofCrcExtra = 15

setpoint6dofModule :: Module
setpoint6dofModule = package "mavlink_setpoint_6dof_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkSetpoint6dofSender
  incl setpoint6dofUnpack
  defStruct (Proxy :: Proxy "setpoint_6dof_msg")
  incl setpoint6dofPackRef
  incl setpoint6dofUnpackRef

[ivory|
struct setpoint_6dof_msg
  { trans_x :: Stored IFloat
  ; trans_y :: Stored IFloat
  ; trans_z :: Stored IFloat
  ; rot_x :: Stored IFloat
  ; rot_y :: Stored IFloat
  ; rot_z :: Stored IFloat
  ; target_system :: Stored Uint8
  }
|]

mkSetpoint6dofSender ::
  Def ('[ ConstRef s0 (Struct "setpoint_6dof_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkSetpoint6dofSender = makeMavlinkSender "setpoint_6dof_msg" setpoint6dofMsgId setpoint6dofCrcExtra

instance MavlinkUnpackableMsg "setpoint_6dof_msg" where
    unpackMsg = ( setpoint6dofUnpack , setpoint6dofMsgId )

setpoint6dofUnpack :: Def ('[ Ref s1 (Struct "setpoint_6dof_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setpoint6dofUnpack = proc "mavlink_setpoint_6dof_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

setpoint6dofPackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "setpoint_6dof_msg")
                              ] :-> () )
setpoint6dofPackRef = proc "mavlink_setpoint_6dof_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> trans_x)
  packRef buf (off + 4) (msg ~> trans_y)
  packRef buf (off + 8) (msg ~> trans_z)
  packRef buf (off + 12) (msg ~> rot_x)
  packRef buf (off + 16) (msg ~> rot_y)
  packRef buf (off + 20) (msg ~> rot_z)
  packRef buf (off + 24) (msg ~> target_system)

setpoint6dofUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "setpoint_6dof_msg")
                                ] :-> () )
setpoint6dofUnpackRef = proc "mavlink_setpoint_6dof_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> trans_x)
  unpackRef buf (off + 4) (msg ~> trans_y)
  unpackRef buf (off + 8) (msg ~> trans_z)
  unpackRef buf (off + 12) (msg ~> rot_x)
  unpackRef buf (off + 16) (msg ~> rot_y)
  unpackRef buf (off + 20) (msg ~> rot_z)
  unpackRef buf (off + 24) (msg ~> target_system)

instance SerializableRef (Struct "setpoint_6dof_msg") where
  packRef = call_ setpoint6dofPackRef
  unpackRef = call_ setpoint6dofUnpackRef
