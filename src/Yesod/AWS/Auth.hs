{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Yesod.AWS.Auth
  ( Credentials(..)
  , AccessKey(..)
  , SecretKey(..)
  ) where

import Data.Aeson
import Data.Text.Encoding (encodeUtf8)
import Network.AWS.Auth (AccessKey(..), Credentials(..), SecretKey(..))

instance FromJSON Credentials where
  parseJSON = withObject "AWS credentials (Amazonka)" $ \o ->
    FromKeys <$> o .: "access-key-id" <*> o .: "secret-access-key"

instance FromJSON AccessKey where
  parseJSON = withText "AWS access key (Amazonka)" $
    pure . AccessKey . encodeUtf8

instance FromJSON SecretKey where
  parseJSON = withText "AWS secret key (Amazonka)" $
    pure . SecretKey . encodeUtf8
