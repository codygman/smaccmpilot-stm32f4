
module SMACCMPilot.Datalink.Client.Console
  ( Console
  , consoleLog
  , consoleError
  , consoleDebug
  , newConsole
  , getConsoleOutput
  , annotate
  , consoleWithLogLevel
  ) where

import           Control.Concurrent.STM.TVar
import           Control.Monad
import           Control.Monad.STM

import SMACCMPilot.Datalink.Client.Opts

data MsgTag = ErrorMsg
            | LogMsg
            | DebugMsg

type Impl = TVar [(MsgTag, String)]

data Console = RealConsole Options Impl
             | AnnotatedConsole String Console

consoleImpl :: Console -> Impl
consoleImpl (RealConsole _ i) = i
consoleImpl (AnnotatedConsole _ q) = consoleImpl q

consoleOpts :: Console -> Options
consoleOpts (RealConsole o _) = o
consoleOpts (AnnotatedConsole _ q) = consoleOpts q

consoleWithOpts :: Console -> Options -> Console
consoleWithOpts (RealConsole _ i) o' = RealConsole o' i
consoleWithOpts (AnnotatedConsole s c) o' = AnnotatedConsole s (consoleWithOpts c o')

consoleWithLogLevel :: Console -> Integer -> Console
consoleWithLogLevel c l = consoleWithOpts c (consoleOpts c) { logLevel = l }

annotate :: Console -> String -> Console
annotate c s = AnnotatedConsole (s ++ ": ") c

consoleLog :: Console -> String -> IO ()
consoleLog console s = writeConsole console LogMsg s

consoleError :: Console -> String -> IO ()
consoleError console s = writeConsole console ErrorMsg s

consoleDebug :: Console -> String -> IO ()
consoleDebug console s = writeConsole console DebugMsg s

writeConsole :: Console -> MsgTag -> String -> IO ()
writeConsole (RealConsole _ q) t m = void $ atomically $ modifyTVar' q (\l -> (t,m):l)
writeConsole (AnnotatedConsole s c) t m = writeConsole c t (s++m)

newConsole :: Options -> IO Console
newConsole opts = do
  q <- newTVarIO []
  return $ RealConsole opts q

getConsoleOutput :: Console -> IO String
getConsoleOutput c = do
  ls <- atomically $ do
          l <- readTVar q
          writeTVar q []
          return l
  return (unlines (map showLog (filter p (reverse ls))))
  where
  q = consoleImpl c

  llevel = logLevel (consoleOpts c)
  p (ErrorMsg,_) = llevel > 0
  p (LogMsg,_)   = llevel > 1
  p (DebugMsg,_) = llevel > 2

  showLog (t,msg) = case t of
    ErrorMsg -> "ERR: " ++ msg
    LogMsg ->  "LOG: " ++ msg
    DebugMsg -> "DBG: " ++ msg

