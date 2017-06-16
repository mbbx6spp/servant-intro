{-# LANGUAGE NoImplicitPrelude #-}

module My.Intro.Api.Health (healthcheck) where

import           My.Intro.Api.Types (Port)
import           Network.Simple.TCP (connect)
import           Protolude

healthcheck :: Port -> IO ()
healthcheck port = do
  connect "127.0.0.1" (show port) $ \(_, _) -> do
    putStrLn $ "Port " ++ show port ++ " is open."
    return ()
  return ()
