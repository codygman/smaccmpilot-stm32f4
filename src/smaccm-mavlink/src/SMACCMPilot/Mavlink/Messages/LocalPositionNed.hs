{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.LocalPositionNed where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Send
import SMACCMPilot.Mavlink.Unpack

localPositionNedMsgId :: Uint8
localPositionNedMsgId = 32

localPositionNedCrcExtra :: Uint8
localPositionNedCrcExtra = 185

localPositionNedModule :: Module
localPositionNedModule = package "mavlink_local_position_ned_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkLocalPositionNedSender
  incl localPositionNedUnpack
  defStruct (Proxy :: Proxy "local_position_ned_msg")
  incl localPositionNedPackRef
  incl localPositionNedUnpackRef

[ivory|
struct local_position_ned_msg
  { time_boot_ms :: Stored Uint32
  ; x :: Stored IFloat
  ; y :: Stored IFloat
  ; z :: Stored IFloat
  ; vx :: Stored IFloat
  ; vy :: Stored IFloat
  ; vz :: Stored IFloat
  }
|]

mkLocalPositionNedSender ::
  Def ('[ ConstRef s0 (Struct "local_position_ned_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkLocalPositionNedSender = makeMavlinkSender "local_position_ned_msg" localPositionNedMsgId localPositionNedCrcExtra

instance MavlinkUnpackableMsg "local_position_ned_msg" where
    unpackMsg = ( localPositionNedUnpack , localPositionNedMsgId )

localPositionNedUnpack :: Def ('[ Ref s1 (Struct "local_position_ned_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
localPositionNedUnpack = proc "mavlink_local_position_ned_unpack" $ \ msg buf -> body $ unpackRef buf 0 msg

localPositionNedPackRef :: Def ('[ Ref s1 (CArray (Stored Uint8))
                              , Uint32
                              , ConstRef s2 (Struct "local_position_ned_msg")
                              ] :-> () )
localPositionNedPackRef = proc "mavlink_local_position_ned_pack_ref" $ \ buf off msg -> body $ do
  packRef buf (off + 0) (msg ~> time_boot_ms)
  packRef buf (off + 4) (msg ~> x)
  packRef buf (off + 8) (msg ~> y)
  packRef buf (off + 12) (msg ~> z)
  packRef buf (off + 16) (msg ~> vx)
  packRef buf (off + 20) (msg ~> vy)
  packRef buf (off + 24) (msg ~> vz)

localPositionNedUnpackRef :: Def ('[ ConstRef s1 (CArray (Stored Uint8))
                                , Uint32
                                , Ref s2 (Struct "local_position_ned_msg")
                                ] :-> () )
localPositionNedUnpackRef = proc "mavlink_local_position_ned_unpack_ref" $ \ buf off msg -> body $ do
  unpackRef buf (off + 0) (msg ~> time_boot_ms)
  unpackRef buf (off + 4) (msg ~> x)
  unpackRef buf (off + 8) (msg ~> y)
  unpackRef buf (off + 12) (msg ~> z)
  unpackRef buf (off + 16) (msg ~> vx)
  unpackRef buf (off + 20) (msg ~> vy)
  unpackRef buf (off + 24) (msg ~> vz)

instance SerializableRef (Struct "local_position_ned_msg") where
  packRef = call_ localPositionNedPackRef
  unpackRef = call_ localPositionNedUnpackRef
