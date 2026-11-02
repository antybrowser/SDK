module Antybrowser
  ( -- * Client
    AntybrowserClient(..)
  , ClientOptions(..)
  , newClient
  , newClientWithOptions
    -- * Profiles
  , getProfiles
  , createProfile
  , updateProfile
  , deleteProfile
  , startProfile
  , stopProfile
  , duplicateProfile
    -- * Automations
  , getAutomations
  , runAutomation
    -- * Groups
  , getGroups
  , createGroup
  , updateGroup
  , deleteGroup
    -- * Proxies
  , getProxies
  , createProxy
  , deleteProxy
    -- * Extensions
  , getExtensions
  , deleteExtension
    -- * Types
  , Profile(..)
  , CreateProfileRequest(..)
  , Proxy(..)
  , CreateProxyRequest(..)
  , Group(..)
  , CreateGroupRequest(..)
  , Extension(..)
  , Automation(..)
  , RunAutomationRequest(..)
  , RunAutomationResult(..)
  , StartProfileResponse(..)
  , ApiResponse(..)
  , DuplicateProfileRequest(..)
    -- * Errors
  , AntybrowserError(..)
  ) where

import           Antybrowser.Client
import           Antybrowser.Error
import           Antybrowser.Types
