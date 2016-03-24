module Web.Slack.Types.Self where

import Control.Lens.TH
import Data.Aeson
import Data.Text (Text)

import Web.Slack.Types.Id
import Web.Slack.Types.Preferences
import Web.Slack.Types.Presence
import Web.Slack.Types.Time


data Self = Self
            { _selfUserId         :: UserId
            , _selfName           :: Text
            , _selfPreferences    :: Preferences
            , _selfCreated        :: Time
            , _selfManualPresence :: Presence
            } deriving Show

makeLenses ''Self

instance FromJSON Self where
  parseJSON = withObject "self" (\o ->
    Self
      <$> o .: "id"
      <*> o .: "name"
      <*> o .: "prefs"
      <*> o .: "created"
      <*> o .: "manual_presence")
