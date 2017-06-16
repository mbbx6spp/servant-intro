{-# LANGUAGE NoImplicitPrelude #-}

module My.Intro.Api.Ruby (generate) where

import qualified Data.Text.IO        as TIO
import           My.Intro.Api.Server (component, organization, product, proxy)
import           Protolude           hiding (product)
import           Servant.Ruby        (NameSpace (..), ruby)

generate :: FilePath -> IO ()
generate out = TIO.writeFile out code
  where
    code = ruby (NameSpace [organization, product] component) proxy
