module Antybrowser.Error
  ( AntybrowserError(..)
  ) where

import           Control.Exception (Exception (..))
import           Data.Typeable     (Typeable)
import           Prelude

data AntybrowserError = AntybrowserError
  { errorMessage     :: String
  , errorStatusCode  :: Maybe Int
  , errorRequestBody :: Maybe String
  } deriving (Show, Typeable)

instance Exception AntybrowserError where
  displayException = errorMessage
