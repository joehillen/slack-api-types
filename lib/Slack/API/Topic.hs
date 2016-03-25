module Slack.API.Topic where

import Data.Aeson
import Data.Text (Text)
import Control.Lens.TH


type Purpose = Topic

data Topic = Topic
           { _topicValue   :: Text
           , _topicCreator :: Text
           , _topicLastSet :: Int
           } deriving (Show)

makeLenses ''Topic

instance FromJSON Topic where
  parseJSON = withObject "topic" (\o ->
    Topic
      <$> o .: "value"
      <*> o .: "creator"
      <*> o .: "last_set")
