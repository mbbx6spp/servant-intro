{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module My.Intro.Api.Server
  ( organization
  , product
  , component
  , proxy
  , app
  , server
  , Api) where

import           Data.Text          (Text)
import           Data.Time.Clock
import           My.Intro.Api.Types
import           Protolude          hiding (product)
import           Servant

type UserId = Int

type UsersList        = "api" :> "users" :> Get '[JSON] [User]
type UserGet          = "api" :> "users" :> Capture "id" UserId :> Get '[JSON] User
type UserPost         = "api" :> "users" :> ReqBody '[JSON] User :> Post '[JSON] User
type UsersResource    = UsersList :<|> UserGet :<|> UserPost

type StoriesResource  = "api" :> "posts" :> Get '[JSON] [Story]
type Api = (UsersResource :<|> StoriesResource)

organization :: Text
organization = "My"

product :: Text
product = "Intro"

component :: Text
component = "Api"

proxy :: Proxy Api
proxy = Proxy

server :: Server Api
server = (usersList :<|> userGet :<|> userPost) :<|> storiesList

app :: Application
app = serve proxy server

--- handlers
usersList :: Handler [User]
usersList = return $ [
    (User "realDonaldTrump" "N/A")
  ]

userGet :: UserId -> Handler User
userGet uid = return $ User (show uid) "some bio"

userPost :: User -> Handler User
userPost user = return user

storiesList :: Handler [Story]
storiesList = do
  currTime <- liftIO getCurrentTime
  return $ [ (Story "some title" "intro" "body text here woot woot" currTime) ]

