{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.LocalPositionNedSystemGlobalOffset where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

localPositionNedSystemGlobalOffsetMsgId :: Uint8
localPositionNedSystemGlobalOffsetMsgId = 89

localPositionNedSystemGlobalOffsetCrcExtra :: Uint8
localPositionNedSystemGlobalOffsetCrcExtra = 231

localPositionNedSystemGlobalOffsetModule :: Module
localPositionNedSystemGlobalOffsetModule = package "mavlink_local_position_ned_system_global_offset_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkLocalPositionNedSystemGlobalOffsetSender
  incl localPositionNedSystemGlobalOffsetUnpack
  defStruct (Proxy :: Proxy "local_position_ned_system_global_offset_msg")

[ivory|
struct local_position_ned_system_global_offset_msg
  { time_boot_ms :: Stored Uint32
  ; x :: Stored IFloat
  ; y :: Stored IFloat
  ; z :: Stored IFloat
  ; roll :: Stored IFloat
  ; pitch :: Stored IFloat
  ; yaw :: Stored IFloat
  }
|]

mkLocalPositionNedSystemGlobalOffsetSender ::
  Def ('[ ConstRef s0 (Struct "local_position_ned_system_global_offset_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkLocalPositionNedSystemGlobalOffsetSender =
  proc "mavlink_local_position_ned_system_global_offset_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 28 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 0 =<< deref (msg ~> time_boot_ms)
  pack buf 4 =<< deref (msg ~> x)
  pack buf 8 =<< deref (msg ~> y)
  pack buf 12 =<< deref (msg ~> z)
  pack buf 16 =<< deref (msg ~> roll)
  pack buf 20 =<< deref (msg ~> pitch)
  pack buf 24 =<< deref (msg ~> yaw)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 28 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "localPositionNedSystemGlobalOffset payload of length 28 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    localPositionNedSystemGlobalOffsetMsgId
                    localPositionNedSystemGlobalOffsetCrcExtra
                    28
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "local_position_ned_system_global_offset_msg" where
    unpackMsg = ( localPositionNedSystemGlobalOffsetUnpack , localPositionNedSystemGlobalOffsetMsgId )

localPositionNedSystemGlobalOffsetUnpack :: Def ('[ Ref s1 (Struct "local_position_ned_system_global_offset_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
localPositionNedSystemGlobalOffsetUnpack = proc "mavlink_local_position_ned_system_global_offset_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_boot_ms) =<< unpack buf 0
  store (msg ~> x) =<< unpack buf 4
  store (msg ~> y) =<< unpack buf 8
  store (msg ~> z) =<< unpack buf 12
  store (msg ~> roll) =<< unpack buf 16
  store (msg ~> pitch) =<< unpack buf 20
  store (msg ~> yaw) =<< unpack buf 24

