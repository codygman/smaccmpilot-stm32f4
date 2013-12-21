{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}

module SMACCMPilot.Flight.Control.Attitude.HeadingControl
  ( HeadingController(..)
  , taskHeadingControl
  ) where

import Ivory.Language
import Ivory.Tower

import           SMACCMPilot.Param
import           SMACCMPilot.Flight.Param

import qualified SMACCMPilot.Flight.Types.Sensors()

data HeadingController =
  HeadingController
    { hctl_update :: forall eff s
                   . IFloat
                  -> IFloat
                  -> Ref s (Struct "sensors_result")
                  -> IFloat
                  -> Ivory eff ()
    , hctl_reset :: forall eff . Ivory eff ()
    , hctl_setpoint :: forall eff . Ivory eff IFloat
    , hctl_write_debug :: forall eff s . Ref s (Struct "att_control_dbg")
                     -> Ivory eff ()
    }

taskHeadingControl :: PIDParams ParamReader -> Task p HeadingController
taskHeadingControl _params = do
  uniq <- fresh
  let named n = "head_ctl_" ++ n ++ "_" ++ show uniq
  active_state <- taskLocalInit "active_state" (ival false)
  let proc_update :: Def('[ IFloat -- Heading setpoint
                          , IFloat -- Rate setpoint
                          , Ref s (Struct "sensors_result")
                          , IFloat -- dt
                          ] :-> ())
      proc_update  = proc (named "update") $
        \_h_setpt _r_setpt _sens _dt -> body $ do
          store active_state true

      proc_reset :: Def('[]:->())
      proc_reset = proc (named "reset") $ body $ do
        store active_state false

  taskModuleDef $ do
    incl proc_update
    incl proc_reset
  return HeadingController
    { hctl_update   = call_ proc_update
    , hctl_reset    = call_ proc_reset
    , hctl_setpoint = return 0 -- XXX
    , hctl_write_debug = const (return ()) -- XXX
    }





-- Take an angle in radians which is outside of linear range (-pi, pi] by less
-- than pi, and maps it to an equal angle in that range.
-- angledomain :: IFloat -> IFloat
-- angledomain a =
--   ( a <=? (-pi) ) ? ( a + 2*pi
--   , (a >? pi ) ? ( a - 2*pi
--     , a))


