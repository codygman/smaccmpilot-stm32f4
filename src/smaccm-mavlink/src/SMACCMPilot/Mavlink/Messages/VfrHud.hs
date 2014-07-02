{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.VfrHud where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

vfrHudMsgId :: Uint8
vfrHudMsgId = 74

vfrHudCrcExtra :: Uint8
vfrHudCrcExtra = 20

vfrHudModule :: Module
vfrHudModule = package "mavlink_vfr_hud_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkVfrHudSender
  incl vfrHudUnpack
  defStruct (Proxy :: Proxy "vfr_hud_msg")

[ivory|
struct vfr_hud_msg
  { airspeed :: Stored IFloat
  ; groundspeed :: Stored IFloat
  ; alt :: Stored IFloat
  ; climb :: Stored IFloat
  ; heading :: Stored Sint16
  ; throttle :: Stored Uint16
  }
|]

mkVfrHudSender ::
  Def ('[ ConstRef s0 (Struct "vfr_hud_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkVfrHudSender =
  proc "mavlink_vfr_hud_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 20 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 0 =<< deref (msg ~> airspeed)
  pack buf 4 =<< deref (msg ~> groundspeed)
  pack buf 8 =<< deref (msg ~> alt)
  pack buf 12 =<< deref (msg ~> climb)
  pack buf 16 =<< deref (msg ~> heading)
  pack buf 18 =<< deref (msg ~> throttle)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 20 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "vfrHud payload of length 20 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    vfrHudMsgId
                    vfrHudCrcExtra
                    20
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "vfr_hud_msg" where
    unpackMsg = ( vfrHudUnpack , vfrHudMsgId )

vfrHudUnpack :: Def ('[ Ref s1 (Struct "vfr_hud_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
vfrHudUnpack = proc "mavlink_vfr_hud_unpack" $ \ msg buf -> body $ do
  store (msg ~> airspeed) =<< unpack buf 0
  store (msg ~> groundspeed) =<< unpack buf 4
  store (msg ~> alt) =<< unpack buf 8
  store (msg ~> climb) =<< unpack buf 12
  store (msg ~> heading) =<< unpack buf 16
  store (msg ~> throttle) =<< unpack buf 18

