{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeOperators      #-}

module Main where

import qualified My.Intro.Api.Health      as Health
import qualified My.Intro.Api.Ruby        as Ruby
import           My.Intro.Api.Server      (app)
import           My.Intro.Api.Types       (Port)

import           Network.Wai.Handler.Warp (defaultSettings, runSettings,
                                           setLogger, setPort)
import           Network.Wai.Logger       (withStdoutLogger)
import           Options.Generic
import           Protolude

data Command a
  = Server { port :: a ::: Port     <?> "Port to bind to" }
  | Ruby   { dest :: a ::: FilePath <?> "File path to output generated code" }
  | Health { port :: a ::: Port     <?> "Port to bind to" }
  deriving (Generic)

instance ParseRecord (Command Wrapped)
deriving instance Show (Command Unwrapped)

run :: Command Unwrapped -> IO ()
run (Server port) = runServer port
run (Ruby out)    = Ruby.generate out
run (Health port) = Health.healthcheck port

runServer :: Port -> IO ()
runServer port = withStdoutLogger $ \logger ->
  runSettings (setPort port $ setLogger logger defaultSettings) app

main :: IO ()
main = do
  x <- unwrapRecord "API command-line interface"
  () <- run x
  print (x :: Command Unwrapped)
