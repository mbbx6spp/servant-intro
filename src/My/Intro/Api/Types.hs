{-# LANGUAGE DeriveGeneric #-}

module My.Intro.Api.Types
  ( Port
  , User (..)
  , Story (..)
  ) where

import           Data.Aeson      (FromJSON, ToJSON)
import           Data.Text       (Text)
import           Data.Time.Clock (UTCTime)
import           GHC.Generics    (Generic)

-- Config types
type Port = Int

-- API types
data User = User
  { userScreenname :: Text
  , userBio        :: Text
  } deriving Generic

instance ToJSON User
instance FromJSON User

data Story = Story
  { storyTitle :: Text
  , storyIntro :: Text
  , storyBody  :: Text
  , storyDate  :: UTCTime
  } deriving Generic

instance ToJSON Story
instance FromJSON Story

