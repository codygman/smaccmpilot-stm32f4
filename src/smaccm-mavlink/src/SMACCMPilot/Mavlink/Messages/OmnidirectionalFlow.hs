{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.OmnidirectionalFlow where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send
import qualified SMACCMPilot.Communications as Comm

import Ivory.Language
import Ivory.Stdlib

omnidirectionalFlowMsgId :: Uint8
omnidirectionalFlowMsgId = 106

omnidirectionalFlowCrcExtra :: Uint8
omnidirectionalFlowCrcExtra = 211

omnidirectionalFlowModule :: Module
omnidirectionalFlowModule = package "mavlink_omnidirectional_flow_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkOmnidirectionalFlowSender
  incl omnidirectionalFlowUnpack
  defStruct (Proxy :: Proxy "omnidirectional_flow_msg")

[ivory|
struct omnidirectional_flow_msg
  { time_usec :: Stored Uint64
  ; front_distance_m :: Stored IFloat
  ; sensor_id :: Stored Uint8
  ; quality :: Stored Uint8
  ; left :: Array 10 (Stored Sint16)
  ; right :: Array 10 (Stored Sint16)
  }
|]

mkOmnidirectionalFlowSender ::
  Def ('[ ConstRef s0 (Struct "omnidirectional_flow_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 Comm.MAVLinkArray -- tx buffer
        ] :-> ())
mkOmnidirectionalFlowSender =
  proc "mavlink_omnidirectional_flow_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 54 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_usec)
  call_ pack buf 8 =<< deref (msg ~> front_distance_m)
  call_ pack buf 52 =<< deref (msg ~> sensor_id)
  call_ pack buf 53 =<< deref (msg ~> quality)
  arrayPack buf 12 (msg ~> left)
  arrayPack buf 32 (msg ~> right)
  -- 6: header len, 2: CRC len
  let usedLen = 6 + 54 + 2 :: Integer
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "omnidirectionalFlow payload of length 54 is too large!"
    else do -- Copy, leaving room for the payload
            arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    omnidirectionalFlowMsgId
                    omnidirectionalFlowCrcExtra
                    54
                    seqNum
                    sendArr
            let usedLenIx = fromInteger usedLen
            -- Zero out the unused portion of the array.
            for (fromInteger sendArrLen - usedLenIx) $ \ix ->
              store (sendArr ! (ix + usedLenIx)) 0
            retVoid

instance MavlinkUnpackableMsg "omnidirectional_flow_msg" where
    unpackMsg = ( omnidirectionalFlowUnpack , omnidirectionalFlowMsgId )

omnidirectionalFlowUnpack :: Def ('[ Ref s1 (Struct "omnidirectional_flow_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
omnidirectionalFlowUnpack = proc "mavlink_omnidirectional_flow_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_usec) =<< call unpack buf 0
  store (msg ~> front_distance_m) =<< call unpack buf 8
  store (msg ~> sensor_id) =<< call unpack buf 52
  store (msg ~> quality) =<< call unpack buf 53
  arrayUnpack buf 12 (msg ~> left)
  arrayUnpack buf 32 (msg ~> right)
