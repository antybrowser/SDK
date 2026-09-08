module Antybrowser.Error
  ( AntybrowserError(..)
  , mkError
  , mkHttpError
  ) where

import Prelude

newtype AntybrowserError = AntybrowserError
  { message :: String
  , statusCode :: Maybe Int
  , responseBody :: Maybe String
  }

mkError :: String -> AntybrowserError
mkError message = AntybrowserError
  { message
  , statusCode: Nothing
  , responseBody: Nothing
  }

mkHttpError :: Int -> String -> String -> AntybrowserError
mkHttpError code msg body = AntybrowserError
  { message: msg
  , statusCode: Just code
  , responseBody: Just body
  }

instance showAntybrowserError :: Show AntybrowserError where
  show (AntybrowserError e) = "(AntybrowserError " <> e.message <> ")"
