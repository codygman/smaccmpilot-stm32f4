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
  wrappedPackMod setpoint6dofWrapper

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
setpoint6dofUnpack = proc "mavlink_setpoint_6dof_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

setpoint6dofWrapper :: WrappedPackRep (Struct "setpoint_6dof_msg")
setpoint6dofWrapper = wrapPackRep "mavlink_setpoint_6dof" $ packStruct
  [ packLabel trans_x
  , packLabel trans_y
  , packLabel trans_z
  , packLabel rot_x
  , packLabel rot_y
  , packLabel rot_z
  , packLabel target_system
  ]

instance Packable (Struct "setpoint_6dof_msg") where
  packRep = wrappedPackRep setpoint6dofWrapper
