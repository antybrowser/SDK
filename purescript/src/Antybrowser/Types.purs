module Antybrowser.Types
  ( Profile(..)
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

newtype StartProfileResponse = StartProfileResponse
  { success :: Boolean
  , data :: StartProfileData
  }

newtype StartProfileData = StartProfileData
  { debugPort :: Maybe Int
  }

-- ─── Profiles ──────────────────────────────────────────────────────────────

newtype Profile = Profile
  { id :: Int
  , userId :: Maybe Int
  , userGuid :: Maybe String
  , name :: String
  , directoryName :: Maybe String
  , groupId :: Maybe Int
  , proxyId :: Maybe Int
  , browserType :: Maybe String
  , browserVersion :: Maybe String
  , osFingerprint :: Maybe String
  , screenResolution :: Maybe String
  , screenMaximizable :: Maybe Boolean
  , language :: Maybe String
  , acceptLanguage :: Maybe String
  , timezone :: Maybe String
  , useFingerprint :: Maybe Boolean
  -- | Server-owned noise seed. Read-only — never sent on create/update.
  , fingerprintId :: Maybe String
  , platformVersion :: Maybe String
  , brandVersion :: Maybe String
  , engineVersion :: Maybe String
  , gpuVendor :: Maybe String
  , gpuModel :: Maybe String
  , hardwareConcurrency :: Maybe Json
  , deviceMemory :: Maybe Json
  , deviceScaleFactor :: Maybe Json
  , mobileModel :: Maybe String
  , mobileVersion :: Maybe Json
  , chPlatform :: Maybe String
  , chPlatformVersion :: Maybe String
  , chArch :: Maybe String
  , chBitness :: Maybe String
  , chModel :: Maybe String
  , chMobile :: Maybe Json
  , disableSpoofing :: Maybe String
  , locationMode :: Maybe String
  , locationLatitude :: Maybe String
  , locationLongitude :: Maybe String
  , locationAccuracy :: Maybe String
  , userAgent :: Maybe String
  , restoreSession :: Maybe Boolean
  , lowBandwidth :: Maybe Boolean
  , notes :: Maybe String
  , startUrl :: Maybe String
  , customFlags :: Maybe String
  , status :: Maybe String
  , statusMachineId :: Maybe String
  , statusHeartbeatAt :: Maybe String
  , needsSync :: Maybe Boolean
  , lastPid :: Maybe Int
  , debugPort :: Maybe Int
  , tabsSnapshot :: Maybe String
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
  , browserVersion :: Maybe String
  , osFingerprint :: Maybe String
  , screenResolution :: Maybe String
  , screenMaximizable :: Maybe Boolean
  , language :: Maybe String
  , acceptLanguage :: Maybe String
  , timezone :: Maybe String
  , useFingerprint :: Maybe Boolean
  , platformVersion :: Maybe String
  , brandVersion :: Maybe String
  , engineVersion :: Maybe String
  , gpuVendor :: Maybe String
  , gpuModel :: Maybe String
  , hardwareConcurrency :: Maybe Json
  , deviceMemory :: Maybe Json
  , deviceScaleFactor :: Maybe Json
  , mobileModel :: Maybe String
  , mobileVersion :: Maybe Json
  , chPlatform :: Maybe String
  , chPlatformVersion :: Maybe String
  , chArch :: Maybe String
  , chBitness :: Maybe String
  , chModel :: Maybe String
  , chMobile :: Maybe Json
  , disableSpoofing :: Maybe String
  , locationMode :: Maybe String
  , locationLatitude :: Maybe String
  , locationLongitude :: Maybe String
  , locationAccuracy :: Maybe String
  , restoreSession :: Maybe Boolean
  , lowBandwidth :: Maybe Boolean
  , notes :: Maybe String
  , startUrl :: Maybe String
  , customFlags :: Maybe String
  , status :: Maybe String
  , hidden :: Maybe Boolean
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

instance decodeProfile :: DecodeJson Profile where
  decodeJson json = do
    obj <- decodeJson json
    id' <- getField obj "id"
    userId <- getFieldOptional obj "userId"
    userGuid <- getFieldOptional obj "userGuid"
    name <- getField obj "name"
    directoryName <- getFieldOptional obj "directoryName"
    groupId <- getFieldOptional obj "groupId"
    proxyId <- getFieldOptional obj "proxyId"
    browserType <- getFieldOptional obj "browserType"
    browserVersion <- getFieldOptional obj "browserVersion"
    osFingerprint <- getFieldOptional obj "osFingerprint"
    screenResolution <- getFieldOptional obj "screenResolution"
    screenMaximizable <- getFieldOptional obj "screenMaximizable"
    language <- getFieldOptional obj "language"
    acceptLanguage <- getFieldOptional obj "acceptLanguage"
    timezone <- getFieldOptional obj "timezone"
    useFingerprint <- getFieldOptional obj "useFingerprint"
    fingerprintId <- getFieldOptional obj "fingerprintId"
    platformVersion <- getFieldOptional obj "platformVersion"
    brandVersion <- getFieldOptional obj "brandVersion"
    engineVersion <- getFieldOptional obj "engineVersion"
    gpuVendor <- getFieldOptional obj "gpuVendor"
    gpuModel <- getFieldOptional obj "gpuModel"
    hardwareConcurrency <- getFieldOptional obj "hardwareConcurrency"
    deviceMemory <- getFieldOptional obj "deviceMemory"
    deviceScaleFactor <- getFieldOptional obj "deviceScaleFactor"
    mobileModel <- getFieldOptional obj "mobileModel"
    mobileVersion <- getFieldOptional obj "mobileVersion"
    chPlatform <- getFieldOptional obj "chPlatform"
    chPlatformVersion <- getFieldOptional obj "chPlatformVersion"
    chArch <- getFieldOptional obj "chArch"
    chBitness <- getFieldOptional obj "chBitness"
    chModel <- getFieldOptional obj "chModel"
    chMobile <- getFieldOptional obj "chMobile"
    disableSpoofing <- getFieldOptional obj "disableSpoofing"
    locationMode <- getFieldOptional obj "locationMode"
    locationLatitude <- getFieldOptional obj "locationLatitude"
    locationLongitude <- getFieldOptional obj "locationLongitude"
    locationAccuracy <- getFieldOptional obj "locationAccuracy"
    userAgent <- getFieldOptional obj "userAgent"
    restoreSession <- getFieldOptional obj "restoreSession"
    lowBandwidth <- getFieldOptional obj "lowBandwidth"
    notes <- getFieldOptional obj "notes"
    startUrl <- getFieldOptional obj "startUrl"
    customFlags <- getFieldOptional obj "customFlags"
    status <- getFieldOptional obj "status"
    statusMachineId <- getFieldOptional obj "statusMachineId"
    statusHeartbeatAt <- getFieldOptional obj "statusHeartbeatAt"
    needsSync <- getFieldOptional obj "needsSync"
    lastPid <- getFieldOptional obj "lastPid"
    debugPort <- getFieldOptional obj "debugPort"
    tabsSnapshot <- getFieldOptional obj "tabsSnapshot"
    createdAt <- getFieldOptional obj "createdAt"
    updatedAt <- getFieldOptional obj "updatedAt"
    lastSyncedAt <- getFieldOptional obj "lastSyncedAt"
    s3Key <- getFieldOptional obj "s3Key"
    trash <- getFieldOptional obj "trash"
    deletedAt <- getFieldOptional obj "deletedAt"
    hidden <- getFieldOptional obj "hidden"
    pure $ Profile
      { id: id', userId, userGuid, name, directoryName, groupId, proxyId
      , browserType, browserVersion, osFingerprint, screenResolution
      , screenMaximizable, language, acceptLanguage, timezone, useFingerprint
      , fingerprintId, platformVersion, brandVersion, engineVersion, gpuVendor
      , gpuModel, hardwareConcurrency, deviceMemory, deviceScaleFactor
      , mobileModel, mobileVersion, chPlatform, chPlatformVersion, chArch
      , chBitness, chModel, chMobile, disableSpoofing, locationMode
      , locationLatitude, locationLongitude, locationAccuracy, userAgent
      , restoreSession, lowBandwidth, notes, startUrl, customFlags, status
      , statusMachineId, statusHeartbeatAt, needsSync, lastPid, debugPort
      , tabsSnapshot, createdAt, updatedAt, lastSyncedAt, s3Key, trash
      , deletedAt, hidden
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
    optEnc "browserVersion" r.browserVersion ~>
    optEnc "osFingerprint" r.osFingerprint ~>
    optEnc "screenResolution" r.screenResolution ~>
    optEnc "screenMaximizable" r.screenMaximizable ~>
    optEnc "language" r.language ~>
    optEnc "acceptLanguage" r.acceptLanguage ~>
    optEnc "timezone" r.timezone ~>
    optEnc "useFingerprint" r.useFingerprint ~>
    optEnc "platformVersion" r.platformVersion ~>
    optEnc "brandVersion" r.brandVersion ~>
    optEnc "engineVersion" r.engineVersion ~>
    optEnc "gpuVendor" r.gpuVendor ~>
    optEnc "gpuModel" r.gpuModel ~>
    optEnc "hardwareConcurrency" r.hardwareConcurrency ~>
    optEnc "deviceMemory" r.deviceMemory ~>
    optEnc "deviceScaleFactor" r.deviceScaleFactor ~>
    optEnc "mobileModel" r.mobileModel ~>
    optEnc "mobileVersion" r.mobileVersion ~>
    optEnc "chPlatform" r.chPlatform ~>
    optEnc "chPlatformVersion" r.chPlatformVersion ~>
    optEnc "chArch" r.chArch ~>
    optEnc "chBitness" r.chBitness ~>
    optEnc "chModel" r.chModel ~>
    optEnc "chMobile" r.chMobile ~>
    optEnc "disableSpoofing" r.disableSpoofing ~>
    optEnc "locationMode" r.locationMode ~>
    optEnc "locationLatitude" r.locationLatitude ~>
    optEnc "locationLongitude" r.locationLongitude ~>
    optEnc "locationAccuracy" r.locationAccuracy ~>
    optEnc "restoreSession" r.restoreSession ~>
    optEnc "lowBandwidth" r.lowBandwidth ~>
    optEnc "notes" r.notes ~>
    optEnc "startUrl" r.startUrl ~>
    optEnc "customFlags" r.customFlags ~>
    optEnc "status" r.status ~>
    optEnc "hidden" r.hidden ~>
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
