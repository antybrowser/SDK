module Antybrowser.Types
  ( Profile(..)
  , CreateProfileRequest(..)
  , Proxy(..)
  , CreateProxyRequest(..)
  , ProxyCheckResult(..)
  , Group(..)
  , CreateGroupRequest(..)
  , Extension(..)
  , Automation(..)
  , RunAutomationRequest(..)
  , RunAutomationResult(..)
  , Settings(..)
  , SyncStatus(..)
  , StatusResponse(..)
  , StartProfileResponse(..)
  , StartProfileData(..)
  , DuplicateProfileRequest(..)
  ) where

import Prelude
import Data.Argonaut.Core (Json, jsonSingletonEmpty)
import Data.Argonaut.Decode (class DecodeJson, decodeJson, getField, getFieldOptional)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Argonaut.Encode.Combinators ((:=), (~>))
import Data.Maybe (Maybe(..))

-- ─── System ────────────────────────────────────────────────────────────────

newtype StatusResponse = StatusResponse
  { success :: Boolean
  , status :: String
  , version :: String
  }

newtype StartProfileResponse = StartProfileResponse
  { success :: Boolean
  , data :: StartProfileData
  }

newtype StartProfileData = StartProfileData
  { debugPort :: Maybe Int
  }

newtype Settings = Settings
  { id :: Maybe Int
  , chromePath :: Maybe String
  , apiKey :: Maybe String
  , language :: Maybe String
  }

newtype SyncStatus = SyncStatus
  { total :: Int
  , completed :: Int
  , isSyncing :: Boolean
  }

-- ─── Profiles ──────────────────────────────────────────────────────────────

newtype Profile = Profile
  { id :: Int
  , name :: String
  , directoryName :: Maybe String
  , groupId :: Maybe Int
  , proxyId :: Maybe Int
  , browserType :: Maybe String
  , browserVersion :: Maybe String
  , osFingerprint :: Maybe String
  , screenResolution :: Maybe String
  , language :: Maybe String
  , acceptLanguage :: Maybe String
  , timezone :: Maybe String
  , useFingerprint :: Maybe Boolean
  , fingerprintId :: Maybe String
  , restoreSession :: Maybe Boolean
  , lowBandwidth :: Maybe Boolean
  , notes :: Maybe String
  , startUrl :: Maybe String
  , customFlags :: Maybe String
  , status :: Maybe String
  , needsSync :: Maybe Boolean
  , lastPid :: Maybe Int
  , debugPort :: Maybe Int
  , createdAt :: Maybe String
  , updatedAt :: Maybe String
  , lastSyncedAt :: Maybe String
  , s3Key :: Maybe String
  , trash :: Maybe Boolean
  , deletedAt :: Maybe String
  , hidden :: Maybe Boolean
  }

newtype CreateProfileRequest = CreateProfileRequest
  { name :: String
  , directoryName :: Maybe String
  , groupId :: Maybe Int
  , proxyId :: Maybe Int
  , browserType :: Maybe String
  , osFingerprint :: Maybe String
  , screenResolution :: Maybe String
  , language :: Maybe String
  , acceptLanguage :: Maybe String
  , timezone :: Maybe String
  , useFingerprint :: Maybe Boolean
  , fingerprintId :: Maybe String
  , restoreSession :: Maybe Boolean
  , lowBandwidth :: Maybe Boolean
  , notes :: Maybe String
  , startUrl :: Maybe String
  , customFlags :: Maybe String
  }

newtype DuplicateProfileRequest = DuplicateProfileRequest
  { name :: Maybe String
  , directoryName :: Maybe String
  }

-- ─── Proxies ───────────────────────────────────────────────────────────────

newtype Proxy = Proxy
  { id :: Int
  , name :: Maybe String
  , proxyType :: Maybe String
  , host :: Maybe String
  , port :: Maybe Int
  , username :: Maybe String
  , password :: Maybe String
  , status :: Maybe String
  , countryCode :: Maybe String
  , ip :: Maybe String
  , country :: Maybe String
  , timezone :: Maybe String
  , asn :: Maybe String
  , isp :: Maybe String
  }

newtype CreateProxyRequest = CreateProxyRequest
  { name :: String
  , host :: String
  , port :: Int
  , proxyType :: String
  , username :: Maybe String
  , password :: Maybe String
  }

newtype ProxyCheckResult = ProxyCheckResult
  { success :: Boolean
  , details :: Maybe Json
  , errorMessage :: Maybe String
  }

-- ─── Groups ────────────────────────────────────────────────────────────────

newtype Group = Group
  { id :: Int
  , name :: String
  , description :: Maybe String
  , color :: Maybe String
  , displayOrder :: Maybe Int
  , createdAt :: Maybe String
  , updatedAt :: Maybe String
  }

newtype CreateGroupRequest = CreateGroupRequest
  { name :: String
  , description :: Maybe String
  , color :: Maybe String
  }

-- ─── Extensions ────────────────────────────────────────────────────────────

newtype Extension = Extension
  { id :: Int
  , name :: String
  , path :: Maybe String
  , description :: Maybe String
  , icon :: Maybe String
  , iconDataUrl :: Maybe String
  , createdAt :: Maybe String
  }

-- ─── Automations ───────────────────────────────────────────────────────────

newtype Automation = Automation
  { id :: Int
  , name :: String
  , description :: Maybe String
  , status :: Maybe String
  , lastRun :: Maybe String
  , createdAt :: Maybe String
  , updatedAt :: Maybe String
  }

newtype RunAutomationRequest = RunAutomationRequest
  { profileId :: Int
  , deleteCookies :: Maybe Boolean
  , variables :: Maybe Json
  }

newtype RunAutomationResult = RunAutomationResult
  { success :: Boolean
  , message :: String
  , variables :: Maybe Json
  }

-- ─── DecodeJson instances ─────────────────────────────────────────────────

instance decodeStatusResponse :: DecodeJson StatusResponse where
  decodeJson json = do
    obj <- decodeJson json
    success <- getField obj "success"
    status <- getField obj "status"
    version <- getField obj "version"
    pure $ StatusResponse { success, status, version }

instance decodeStartProfileResponse :: DecodeJson StartProfileResponse where
  decodeJson json = do
    obj <- decodeJson json
    s <- getField obj "success"
    d <- getField obj "data"
    pure $ StartProfileResponse { success: s, data: d }

instance decodeStartProfileData :: DecodeJson StartProfileData where
  decodeJson json = do
    obj <- decodeJson json
    debugPort <- getFieldOptional obj "debugPort"
    pure $ StartProfileData { debugPort }

instance decodeSettings :: DecodeJson Settings where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getFieldOptional obj "id"
    chromePath <- getFieldOptional obj "chromePath"
    apiKey <- getFieldOptional obj "apiKey"
    language <- getFieldOptional obj "language"
    pure $ Settings { id: id', chromePath, apiKey, language }

instance decodeSyncStatus :: DecodeJson SyncStatus where
  decodeJson json = do
    obj <- decodeJson json
    total <- getField obj "total"
    completed <- getField obj "completed"
    isSyncing <- getField obj "isSyncing"
    pure $ SyncStatus { total, completed, isSyncing }

instance decodeProfile :: DecodeJson Profile where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    name <- getField obj "name"
    directoryName <- getFieldOptional obj "directoryName"
    groupId <- getFieldOptional obj "groupId"
    proxyId <- getFieldOptional obj "proxyId"
    browserType <- getFieldOptional obj "browserType"
    browserVersion <- getFieldOptional obj "browserVersion"
    osFingerprint <- getFieldOptional obj "osFingerprint"
    screenResolution <- getFieldOptional obj "screenResolution"
    language <- getFieldOptional obj "language"
    acceptLanguage <- getFieldOptional obj "acceptLanguage"
    timezone <- getFieldOptional obj "timezone"
    useFingerprint <- getFieldOptional obj "useFingerprint"
    fingerprintId <- getFieldOptional obj "fingerprintId"
    restoreSession <- getFieldOptional obj "restoreSession"
    lowBandwidth <- getFieldOptional obj "lowBandwidth"
    notes <- getFieldOptional obj "notes"
    startUrl <- getFieldOptional obj "startUrl"
    customFlags <- getFieldOptional obj "customFlags"
    status <- getFieldOptional obj "status"
    needsSync <- getFieldOptional obj "needsSync"
    lastPid <- getFieldOptional obj "lastPid"
    debugPort <- getFieldOptional obj "debugPort"
    createdAt <- getFieldOptional obj "createdAt"
    updatedAt <- getFieldOptional obj "updatedAt"
    lastSyncedAt <- getFieldOptional obj "lastSyncedAt"
    s3Key <- getFieldOptional obj "s3Key"
    trash <- getFieldOptional obj "trash"
    deletedAt <- getFieldOptional obj "deletedAt"
    hidden <- getFieldOptional obj "hidden"
    pure $ Profile
      { id: id', name, directoryName, groupId, proxyId, browserType, browserVersion
      , osFingerprint, screenResolution, language, acceptLanguage, timezone
      , useFingerprint, fingerprintId, restoreSession, lowBandwidth, notes
      , startUrl, customFlags, status, needsSync, lastPid, debugPort
      , createdAt, updatedAt, lastSyncedAt, s3Key, trash, deletedAt, hidden
      }

instance decodeProxy :: DecodeJson Proxy where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    name <- getFieldOptional obj "name"
    proxyType <- getFieldOptional obj "type"
    host <- getFieldOptional obj "host"
    port' <- getFieldOptional obj "port"
    username <- getFieldOptional obj "username"
    password <- getFieldOptional obj "password"
    status <- getFieldOptional obj "status"
    countryCode <- getFieldOptional obj "countryCode"
    ip <- getFieldOptional obj "ip"
    country <- getFieldOptional obj "country"
    timezone <- getFieldOptional obj "timezone"
    asn <- getFieldOptional obj "asn"
    isp <- getFieldOptional obj "isp"
    pure $ Proxy
      { id: id', name, proxyType, host, port: port', username, password
      , status, countryCode, ip, country, timezone, asn, isp
      }

instance decodeProxyCheckResult :: DecodeJson ProxyCheckResult where
  decodeJson json = do
    obj <- decodeJson json
    success <- getField obj "success"
    details <- getFieldOptional obj "details"
    errorMessage <- getFieldOptional obj "errorMessage"
    pure $ ProxyCheckResult { success, details, errorMessage }

instance decodeGroup :: DecodeJson Group where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    name <- getField obj "name"
    description <- getFieldOptional obj "description"
    color <- getFieldOptional obj "color"
    displayOrder <- getFieldOptional obj "displayOrder"
    createdAt <- getFieldOptional obj "createdAt"
    updatedAt <- getFieldOptional obj "updatedAt"
    pure $ Group { id: id', name, description, color, displayOrder, createdAt, updatedAt }

instance decodeExtension :: DecodeJson Extension where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    name <- getField obj "name"
    path <- getFieldOptional obj "path"
    description <- getFieldOptional obj "description"
    icon <- getFieldOptional obj "icon"
    iconDataUrl <- getFieldOptional obj "iconDataUrl"
    createdAt <- getFieldOptional obj "createdAt"
    pure $ Extension { id: id', name, path, description, icon, iconDataUrl, createdAt }

instance decodeAutomation :: DecodeJson Automation where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    name <- getField obj "name"
    description <- getFieldOptional obj "description"
    status <- getFieldOptional obj "status"
    lastRun <- getFieldOptional obj "lastRun"
    createdAt <- getFieldOptional obj "createdAt"
    updatedAt <- getFieldOptional obj "updatedAt"
    pure $ Automation { id: id', name, description, status, lastRun, createdAt, updatedAt }

instance decodeRunAutomationResult :: DecodeJson RunAutomationResult where
  decodeJson json = do
    obj <- decodeJson json
    success <- getField obj "success"
    message <- getField obj "message"
    variables <- getFieldOptional obj "variables"
    pure $ RunAutomationResult { success, message, variables }

-- ─── EncodeJson instances ──────────────────────────────────────────────────

instance encodeCreateProfileRequest :: EncodeJson CreateProfileRequest where
  encodeJson (CreateProfileRequest r) =
    "name" := r.name ~>
    optEnc "directoryName" r.directoryName ~>
    optEnc "groupId" r.groupId ~>
    optEnc "proxyId" r.proxyId ~>
    optEnc "browserType" r.browserType ~>
    optEnc "osFingerprint" r.osFingerprint ~>
    optEnc "screenResolution" r.screenResolution ~>
    optEnc "language" r.language ~>
    optEnc "acceptLanguage" r.acceptLanguage ~>
    optEnc "timezone" r.timezone ~>
    optEnc "useFingerprint" r.useFingerprint ~>
    optEnc "fingerprintId" r.fingerprintId ~>
    optEnc "restoreSession" r.restoreSession ~>
    optEnc "lowBandwidth" r.lowBandwidth ~>
    optEnc "notes" r.notes ~>
    optEnc "startUrl" r.startUrl ~>
    optEnc "customFlags" r.customFlags ~>
    jsonSingletonEmpty

instance encodeCreateProxyRequest :: EncodeJson CreateProxyRequest where
  encodeJson (CreateProxyRequest r) =
    "name" := r.name ~>
    "host" := r.host ~>
    "port" := r.port ~>
    "type" := r.proxyType ~>
    optEnc "username" r.username ~>
    optEnc "password" r.password ~>
    jsonSingletonEmpty

instance encodeCreateGroupRequest :: EncodeJson CreateGroupRequest where
  encodeJson (CreateGroupRequest r) =
    "name" := r.name ~>
    optEnc "description" r.description ~>
    optEnc "color" r.color ~>
    jsonSingletonEmpty

instance encodeRunAutomationRequest :: EncodeJson RunAutomationRequest where
  encodeJson (RunAutomationRequest r) =
    "profileId" := r.profileId ~>
    optEnc "deleteCookies" r.deleteCookies ~>
    optEnc "variables" r.variables ~>
    jsonSingletonEmpty

instance encodeDuplicateProfileRequest :: EncodeJson DuplicateProfileRequest where
  encodeJson (DuplicateProfileRequest r) =
    optEnc "name" r.name ~>
    optEnc "directoryName" r.directoryName ~>
    jsonSingletonEmpty

-- ─── Helpers ───────────────────────────────────────────────────────────────

optEnc :: forall a. EncodeJson a => String -> Maybe a -> Json -> Json
optEnc _ Nothing json = json
optEnc key (Just val) json = (key := val) json
