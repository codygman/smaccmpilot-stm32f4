{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.NamedValueFloat where

import Ivory.Serialize
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

namedValueFloatMsgId :: Uint8
namedValueFloatMsgId = 251

namedValueFloatCrcExtra :: Uint8
namedValueFloatCrcExtra = 170

namedValueFloatModule :: Module
namedValueFloatModule = package "mavlink_named_value_float_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkNamedValueFloatSender
  incl namedValueFloatUnpack
  defStruct (Proxy :: Proxy "named_value_float_msg")

[ivory|
struct named_value_float_msg
  { time_boot_ms :: Stored Uint32
  ; value :: Stored IFloat
  ; name :: Array 10 (Stored Uint8)
  }
|]

mkNamedValueFloatSender ::
  Def ('[ ConstRef s0 (Struct "named_value_float_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkNamedValueFloatSender =
  proc "mavlink_named_value_float_msg_send"
  $ \msg seqNum sendStruct -> body
  $ do
  arr <- local (iarray [] :: Init (Array 18 (Stored Uint8)))
  let buf = toCArray arr
  pack buf 0 =<< deref (msg ~> time_boot_ms)
  pack buf 4 =<< deref (msg ~> value)
  arrayPack buf 8 (msg ~> name)
  -- 6: header len, 2: CRC len
  let usedLen    = 6 + 18 + 2 :: Integer
  let sendArr    = sendStruct ~> mav_array
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "namedValueFloat payload of length 18 is too large!"
    else do -- Copy, leaving room for the payload
            arrayCopy sendArr arr 6 (arrayLen arr)
            call_ mavlinkSendWithWriter
                    namedValueFloatMsgId
                    namedValueFloatCrcExtra
                    18
                    seqNum
                    sendStruct

instance MavlinkUnpackableMsg "named_value_float_msg" where
    unpackMsg = ( namedValueFloatUnpack , namedValueFloatMsgId )

namedValueFloatUnpack :: Def ('[ Ref s1 (Struct "named_value_float_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
namedValueFloatUnpack = proc "mavlink_named_value_float_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_boot_ms) =<< unpack buf 0
  store (msg ~> value) =<< unpack buf 4
  arrayUnpack buf 8 (msg ~> name)

