{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.SetMode where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

setModeMsgId :: Uint8
setModeMsgId = 11

setModeCrcExtra :: Uint8
setModeCrcExtra = 89

setModeModule :: Module
setModeModule = package "mavlink_set_mode_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkSetModeSender
  incl setModeUnpack
  defStruct (Proxy :: Proxy "set_mode_msg")
  wrappedPackMod setModeWrapper

[ivory|
struct set_mode_msg
  { custom_mode :: Stored Uint32
  ; target_system :: Stored Uint8
  ; base_mode :: Stored Uint8
  }
|]

mkSetModeSender ::
  Def ('[ ConstRef s0 (Struct "set_mode_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkSetModeSender = makeMavlinkSender "set_mode_msg" setModeMsgId setModeCrcExtra

instance MavlinkUnpackableMsg "set_mode_msg" where
    unpackMsg = ( setModeUnpack , setModeMsgId )

setModeUnpack :: Def ('[ Ref s1 (Struct "set_mode_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setModeUnpack = proc "mavlink_set_mode_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

setModeWrapper :: WrappedPackRep (Struct "set_mode_msg")
setModeWrapper = wrapPackRep "mavlink_set_mode" $ packStruct
  [ packLabel custom_mode
  , packLabel target_system
  , packLabel base_mode
  ]

instance Packable (Struct "set_mode_msg") where
  packRep = wrappedPackRep setModeWrapper
