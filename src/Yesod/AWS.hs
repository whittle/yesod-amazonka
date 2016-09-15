module Yesod.AWS
       ( mkAWSLogger
       ) where

import qualified Blaze.ByteString.Builder as B
import           Control.Monad
import qualified Control.Monad.Trans.AWS as AWS
import qualified System.Log.FastLogger as FL
import qualified Yesod.Core.Types as Y

mkAWSLogger :: Y.Logger -> Bool -> AWS.LogLevel -> B.Builder -> IO ()
mkAWSLogger logger logDebug level =
  when (doLog logDebug level) . Y.loggerPutStr logger . FL.toLogStr . B.toLazyByteString

doLog :: Bool -> AWS.LogLevel -> Bool
doLog logAWSDebug level = level <= limit
  where limit = if logAWSDebug then AWS.Debug else AWS.Error
