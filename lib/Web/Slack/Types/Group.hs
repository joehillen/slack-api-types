module Web.Slack.Types.Group where

-- | https://api.slack.com/types/group

import Control.Lens.TH
import Data.Aeson
import Data.Aeson.Types
import Data.Text (Text)

import Web.Slack.Types.Id
import Web.Slack.Types.Time
import Web.Slack.Types.Topic
import {-# SOURCE #-} Web.Slack.Types.ChannelOpt (ChannelOpt)


data Group = Group
             { _groupId         :: GroupId
             , _groupName       :: Text
             , _groupCreated    :: Time
             , _groupCreator    :: UserId
             , _groupIsArchived :: Bool
             , _groupIsOpen     :: Bool
             , _groupMembers    :: [UserId]
             , _groupTopic      :: Topic
             , _groupPurpose    :: Purpose
             , _groupOpt        :: Maybe ChannelOpt
             , _groupIsGroup    :: Bool
             } deriving (Show)

makeLenses ''Group

instance FromJSON Group where
  parseJSON = withObject "Group" (\o ->
    Group
      <$> o .: "id"
      <*> o .: "name"
      <*> o .: "created"
      <*> o .: "creator"
      <*> o .: "is_archived"
      <*> o .: "is_open"
      <*> o .: "members"
      <*> o .: "topic"
      <*> o .: "purpose"
      <*> (pure $ parseMaybe parseJSON (Object o) :: Parser (Maybe ChannelOpt))
      <*> o .: "is_group")
