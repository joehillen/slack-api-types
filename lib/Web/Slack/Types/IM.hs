module Web.Slack.Types.IM where

-- | https://api.slack.com/types/im

import Control.Lens.TH
import Data.Aeson
import Data.Aeson.Types

import Web.Slack.Types.Id
import Web.Slack.Types.Time
import {-# SOURCE #-} Web.Slack.Types.ChannelOpt (ChannelOpt)


data IM = IM
          { _imId      :: IMId
          , _imUser    :: UserId
          , _imCreated :: Time
          , _imIsOpen  :: Bool
          , _imIsIm    :: Bool
          , _imOpt     :: Maybe ChannelOpt
          } deriving (Show)

makeLenses ''IM

instance FromJSON IM where
  parseJSON = withObject "IM" (\o ->
    IM
      <$> o .: "id"
      <*> o .: "user"
      <*> o .: "created"
      <*> o .: "is_open"
      <*> o .: "is_im"
      <*> (pure $ parseMaybe parseJSON (Object o) :: Parser (Maybe ChannelOpt)))
