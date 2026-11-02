module Antybrowser.Types
  ( -- * Profile
    Profile(..)
  , CreateProfileRequest(..)
  , DuplicateProfileRequest(..)
  , StartProfileResponse(..)
    -- * Proxy
  , Proxy(..)
  , CreateProxyRequest(..)
    -- * Group
  , Group(..)
  , CreateGroupRequest(..)
    -- * Extension
  , Extension(..)
    -- * Automation
  , Automation(..)
  , RunAutomationRequest(..)
  , RunAutomationResult(..)
    -- * Generic
  , ApiResponse(..)
  ) where

import           Data.Aeson           (FromJSON (..), Result (..), ToJSON (..),
                                       Value (..), fromJSON, object, withObject,
                                       (.!=), (.:), (.:?), (.=))
import           Data.Aeson.KeyMap    (toMapText)
import           Data.Map.Strict      (Map)
import qualified Data.Map.Strict      as Map
import           Data.Text            (Text)
import           Prelude

-- ─── Profile ─────────────────────────────────────────────────────────────────

data Profile = Profile
  { profileId                  :: Int
  , profileUserId              :: Maybe Int
  , profileUserGuid            :: Maybe Text
  , profileName                :: Text
  , profileDirectoryName       :: Maybe Text
  , profileGroupId             :: Maybe Int
  , profileProxyId             :: Maybe Int
  , profileBrowserType         :: Maybe Text
  , profileBrowserVersion      :: Maybe Text
  , profileOsFingerprint       :: Maybe Text
  , profileScreenResolution    :: Maybe Text
  , profileScreenMaximizable   :: Maybe Bool
  , profileLanguage            :: Maybe Text
  , profileAcceptLanguage      :: Maybe Text
  , profileTimezone            :: Maybe Text
  , profileUseFingerprint      :: Maybe Bool
  -- | Server-owned noise seed. Read-only — never sent on create/update.
  , profileFingerprintId       :: Maybe Text
  , profilePlatformVersion     :: Maybe Text
  , profileBrandVersion        :: Maybe Text
  , profileEngineVersion       :: Maybe Text
  , profileGpuVendor           :: Maybe Text
  , profileGpuModel            :: Maybe Text
  , profileHardwareConcurrency :: Maybe Value
  , profileDeviceMemory        :: Maybe Value
  , profileDeviceScaleFactor   :: Maybe Value
  , profileMobileModel         :: Maybe Text
  , profileMobileVersion       :: Maybe Value
  , profileChPlatform          :: Maybe Text
  , profileChPlatformVersion   :: Maybe Text
  , profileChArch              :: Maybe Text
  , profileChBitness           :: Maybe Text
  , profileChModel             :: Maybe Text
  , profileChMobile            :: Maybe Value
  , profileDisableSpoofing     :: Maybe Text
  , profileLocationMode        :: Maybe Text
  , profileLocationLatitude    :: Maybe Text
  , profileLocationLongitude   :: Maybe Text
  , profileLocationAccuracy    :: Maybe Text
  , profileUserAgent           :: Maybe Text
  , profileRestoreSession      :: Maybe Bool
  , profileLowBandwidth        :: Maybe Bool
  , profileNotes               :: Maybe Text
  , profileStartUrl            :: Maybe Text
  , profileCustomFlags         :: Maybe Text
  , profileStatus              :: Maybe Text
  , profileStatusMachineId     :: Maybe Text
  , profileStatusHeartbeatAt   :: Maybe Text
  , profileNeedsSync           :: Maybe Bool
  , profileLastPid             :: Maybe Int
  , profileDebugPort           :: Maybe Int
  , profileTabsSnapshot        :: Maybe Text
  , profileCreatedAt           :: Maybe Text
  , profileUpdatedAt           :: Maybe Text
  , profileLastSyncedAt        :: Maybe Text
  , profileS3Key               :: Maybe Text
  , profileTrash               :: Maybe Bool
  , profileDeletedAt           :: Maybe Text
  , profileHidden              :: Maybe Bool
  } deriving (Show, Eq)

instance FromJSON Profile where
  parseJSON = withObject "Profile" $ \o -> Profile
    <$> o .:  "id"
    <*> o .:? "userId"
    <*> o .:? "userGuid"
    <*> o .:  "name"
    <*> o .:? "directoryName"
    <*> o .:? "groupId"
    <*> o .:? "proxyId"
    <*> o .:? "browserType"
    <*> o .:? "browserVersion"
    <*> o .:? "osFingerprint"
    <*> o .:? "screenResolution"
    <*> o .:? "screenMaximizable"
    <*> o .:? "language"
    <*> o .:? "acceptLanguage"
    <*> o .:? "timezone"
    <*> o .:? "useFingerprint"
    <*> o .:? "fingerprintId"
    <*> o .:? "platformVersion"
    <*> o .:? "brandVersion"
    <*> o .:? "engineVersion"
    <*> o .:? "gpuVendor"
    <*> o .:? "gpuModel"
    <*> o .:? "hardwareConcurrency"
    <*> o .:? "deviceMemory"
    <*> o .:? "deviceScaleFactor"
    <*> o .:? "mobileModel"
    <*> o .:? "mobileVersion"
    <*> o .:? "chPlatform"
    <*> o .:? "chPlatformVersion"
    <*> o .:? "chArch"
    <*> o .:? "chBitness"
    <*> o .:? "chModel"
    <*> o .:? "chMobile"
    <*> o .:? "disableSpoofing"
    <*> o .:? "locationMode"
    <*> o .:? "locationLatitude"
    <*> o .:? "locationLongitude"
    <*> o .:? "locationAccuracy"
    <*> o .:? "userAgent"
    <*> o .:? "restoreSession"
    <*> o .:? "lowBandwidth"
    <*> o .:? "notes"
    <*> o .:? "startUrl"
    <*> o .:? "customFlags"
    <*> o .:? "status"
    <*> o .:? "statusMachineId"
    <*> o .:? "statusHeartbeatAt"
    <*> o .:? "needsSync"
    <*> o .:? "lastPid"
    <*> o .:? "debugPort"
    <*> o .:? "tabsSnapshot"
    <*> o .:? "createdAt"
    <*> o .:? "updatedAt"
    <*> o .:? "lastSyncedAt"
    <*> o .:? "s3Key"
    <*> o .:? "trash"
    <*> o .:? "deletedAt"
    <*> o .:? "hidden"

instance ToJSON Profile where
  toJSON p = object
    [ "id"                  .= profileId p
    , "userId"              .= profileUserId p
    , "userGuid"            .= profileUserGuid p
    , "name"                .= profileName p
    , "directoryName"       .= profileDirectoryName p
    , "groupId"             .= profileGroupId p
    , "proxyId"             .= profileProxyId p
    , "browserType"         .= profileBrowserType p
    , "browserVersion"      .= profileBrowserVersion p
    , "osFingerprint"       .= profileOsFingerprint p
    , "screenResolution"    .= profileScreenResolution p
    , "screenMaximizable"   .= profileScreenMaximizable p
    , "language"            .= profileLanguage p
    , "acceptLanguage"      .= profileAcceptLanguage p
    , "timezone"            .= profileTimezone p
    , "useFingerprint"      .= profileUseFingerprint p
    , "fingerprintId"       .= profileFingerprintId p
    , "platformVersion"     .= profilePlatformVersion p
    , "brandVersion"        .= profileBrandVersion p
    , "engineVersion"       .= profileEngineVersion p
    , "gpuVendor"           .= profileGpuVendor p
    , "gpuModel"            .= profileGpuModel p
    , "hardwareConcurrency" .= profileHardwareConcurrency p
    , "deviceMemory"        .= profileDeviceMemory p
    , "deviceScaleFactor"   .= profileDeviceScaleFactor p
    , "mobileModel"         .= profileMobileModel p
    , "mobileVersion"       .= profileMobileVersion p
    , "chPlatform"          .= profileChPlatform p
    , "chPlatformVersion"   .= profileChPlatformVersion p
    , "chArch"              .= profileChArch p
    , "chBitness"           .= profileChBitness p
    , "chModel"             .= profileChModel p
    , "chMobile"            .= profileChMobile p
    , "disableSpoofing"     .= profileDisableSpoofing p
    , "locationMode"        .= profileLocationMode p
    , "locationLatitude"    .= profileLocationLatitude p
    , "locationLongitude"   .= profileLocationLongitude p
    , "locationAccuracy"    .= profileLocationAccuracy p
    , "userAgent"           .= profileUserAgent p
    , "restoreSession"      .= profileRestoreSession p
    , "lowBandwidth"        .= profileLowBandwidth p
    , "notes"               .= profileNotes p
    , "startUrl"            .= profileStartUrl p
    , "customFlags"         .= profileCustomFlags p
    , "status"              .= profileStatus p
    , "statusMachineId"     .= profileStatusMachineId p
    , "statusHeartbeatAt"   .= profileStatusHeartbeatAt p
    , "needsSync"           .= profileNeedsSync p
    , "lastPid"             .= profileLastPid p
    , "debugPort"           .= profileDebugPort p
    , "tabsSnapshot"        .= profileTabsSnapshot p
    , "createdAt"           .= profileCreatedAt p
    , "updatedAt"           .= profileUpdatedAt p
    , "lastSyncedAt"        .= profileLastSyncedAt p
    , "s3Key"               .= profileS3Key p
    , "trash"               .= profileTrash p
    , "deletedAt"           .= profileDeletedAt p
    , "hidden"              .= profileHidden p
    ]

-- ─── CreateProfileRequest ────────────────────────────────────────────────────

data CreateProfileRequest = CreateProfileRequest
  { cprName                  :: Text
  , cprDirectoryName         :: Maybe Text
  , cprGroupId               :: Maybe Int
  , cprProxyId               :: Maybe Int
  , cprBrowserType           :: Maybe Text
  , cprBrowserVersion        :: Maybe Text
  , cprOsFingerprint         :: Maybe Text
  , cprScreenResolution      :: Maybe Text
  , cprScreenMaximizable     :: Maybe Bool
  , cprLanguage              :: Maybe Text
  , cprAcceptLanguage        :: Maybe Text
  , cprTimezone              :: Maybe Text
  , cprUseFingerprint        :: Maybe Bool
  , cprPlatformVersion       :: Maybe Text
  , cprBrandVersion          :: Maybe Text
  , cprEngineVersion         :: Maybe Text
  , cprGpuVendor             :: Maybe Text
  , cprGpuModel              :: Maybe Text
  , cprHardwareConcurrency   :: Maybe Value
  , cprDeviceMemory          :: Maybe Value
  , cprDeviceScaleFactor     :: Maybe Value
  , cprMobileModel           :: Maybe Text
  , cprMobileVersion         :: Maybe Value
  , cprChPlatform            :: Maybe Text
  , cprChPlatformVersion     :: Maybe Text
  , cprChArch                :: Maybe Text
  , cprChBitness             :: Maybe Text
  , cprChModel               :: Maybe Text
  , cprChMobile              :: Maybe Value
  , cprDisableSpoofing       :: Maybe Text
  , cprLocationMode          :: Maybe Text
  , cprLocationLatitude      :: Maybe Text
  , cprLocationLongitude     :: Maybe Text
  , cprLocationAccuracy      :: Maybe Text
  , cprRestoreSession        :: Maybe Bool
  , cprLowBandwidth          :: Maybe Bool
  , cprNotes                 :: Maybe Text
  , cprStartUrl              :: Maybe Text
  , cprCustomFlags           :: Maybe Text
  , cprStatus                :: Maybe Text
  , cprHidden                :: Maybe Bool
  } deriving (Show, Eq)

instance ToJSON CreateProfileRequest where
  toJSON r = object
    [ "name"                .= cprName r
    , "directoryName"       .= cprDirectoryName r
    , "groupId"             .= cprGroupId r
    , "proxyId"             .= cprProxyId r
    , "browserType"         .= cprBrowserType r
    , "browserVersion"      .= cprBrowserVersion r
    , "osFingerprint"       .= cprOsFingerprint r
    , "screenResolution"    .= cprScreenResolution r
    , "screenMaximizable"   .= cprScreenMaximizable r
    , "language"            .= cprLanguage r
    , "acceptLanguage"      .= cprAcceptLanguage r
    , "timezone"            .= cprTimezone r
    , "useFingerprint"      .= cprUseFingerprint r
    , "platformVersion"     .= cprPlatformVersion r
    , "brandVersion"        .= cprBrandVersion r
    , "engineVersion"       .= cprEngineVersion r
    , "gpuVendor"           .= cprGpuVendor r
    , "gpuModel"            .= cprGpuModel r
    , "hardwareConcurrency" .= cprHardwareConcurrency r
    , "deviceMemory"        .= cprDeviceMemory r
    , "deviceScaleFactor"   .= cprDeviceScaleFactor r
    , "mobileModel"         .= cprMobileModel r
    , "mobileVersion"       .= cprMobileVersion r
    , "chPlatform"          .= cprChPlatform r
    , "chPlatformVersion"   .= cprChPlatformVersion r
    , "chArch"              .= cprChArch r
    , "chBitness"           .= cprChBitness r
    , "chModel"             .= cprChModel r
    , "chMobile"            .= cprChMobile r
    , "disableSpoofing"     .= cprDisableSpoofing r
    , "locationMode"        .= cprLocationMode r
    , "locationLatitude"    .= cprLocationLatitude r
    , "locationLongitude"   .= cprLocationLongitude r
    , "locationAccuracy"    .= cprLocationAccuracy r
    , "restoreSession"      .= cprRestoreSession r
    , "lowBandwidth"        .= cprLowBandwidth r
    , "notes"               .= cprNotes r
    , "startUrl"            .= cprStartUrl r
    , "customFlags"         .= cprCustomFlags r
    , "status"              .= cprStatus r
    , "hidden"              .= cprHidden r
    ]

instance FromJSON CreateProfileRequest where
  parseJSON = withObject "CreateProfileRequest" $ \o -> CreateProfileRequest
    <$> o .:  "name"
    <*> o .:? "directoryName"
    <*> o .:? "groupId"
    <*> o .:? "proxyId"
    <*> o .:? "browserType"
    <*> o .:? "browserVersion"
    <*> o .:? "osFingerprint"
    <*> o .:? "screenResolution"
    <*> o .:? "screenMaximizable"
    <*> o .:? "language"
    <*> o .:? "acceptLanguage"
    <*> o .:? "timezone"
    <*> o .:? "useFingerprint"
    <*> o .:? "platformVersion"
    <*> o .:? "brandVersion"
    <*> o .:? "engineVersion"
    <*> o .:? "gpuVendor"
    <*> o .:? "gpuModel"
    <*> o .:? "hardwareConcurrency"
    <*> o .:? "deviceMemory"
    <*> o .:? "deviceScaleFactor"
    <*> o .:? "mobileModel"
    <*> o .:? "mobileVersion"
    <*> o .:? "chPlatform"
    <*> o .:? "chPlatformVersion"
    <*> o .:? "chArch"
    <*> o .:? "chBitness"
    <*> o .:? "chModel"
    <*> o .:? "chMobile"
    <*> o .:? "disableSpoofing"
    <*> o .:? "locationMode"
    <*> o .:? "locationLatitude"
    <*> o .:? "locationLongitude"
    <*> o .:? "locationAccuracy"
    <*> o .:? "restoreSession"
    <*> o .:? "lowBandwidth"
    <*> o .:? "notes"
    <*> o .:? "startUrl"
    <*> o .:? "customFlags"
    <*> o .:? "status"
    <*> o .:? "hidden"

-- ─── DuplicateProfileRequest ─────────────────────────────────────────────────

data DuplicateProfileRequest = DuplicateProfileRequest
  { dprName          :: Maybe Text
  , dprDirectoryName :: Maybe Text
  } deriving (Show, Eq)

instance ToJSON DuplicateProfileRequest where
  toJSON r = object
    [ "name"          .= dprName r
    , "directoryName" .= dprDirectoryName r
    ]

-- ─── StartProfileResponse ────────────────────────────────────────────────────

data StartProfileResponse = StartProfileResponse
  { sprSuccess   :: Bool
  , sprDebugPort :: Maybe Int
  , sprExtra     :: Map Text Value
  } deriving (Show, Eq)

instance FromJSON StartProfileResponse where
  parseJSON = withObject "StartProfileResponse" $ \o -> do
    s <- o .: "success"
    mData <- o .:? "data" .!= Map.empty
    let dp = case Map.lookup ("debugPort" :: Text) mData of
          Nothing  -> Nothing
          Just val -> case fromJSON val of
            Success i  -> Just i
            Error   _  -> Nothing
        extra = Map.delete "debugPort" mData
    return $ StartProfileResponse s dp extra

instance ToJSON StartProfileResponse where
  toJSON r = object
    [ "success" .= sprSuccess r
    , "data"    .= (object $
        [ "debugPort" .= sprDebugPort r ] ++ Map.toList (fmap toJSON (sprExtra r)))
    ]

-- ─── Proxy ───────────────────────────────────────────────────────────────────

data Proxy = Proxy
  { proxyId            :: Int
  , proxyName          :: Maybe Text
  , proxyType          :: Maybe Text
  , proxyHost          :: Maybe Text
  , proxyPort          :: Maybe Int
  , proxyUsername      :: Maybe Text
  , proxyPassword      :: Maybe Text
  , proxyStatus        :: Maybe Text
  , proxyCountryCode   :: Maybe Text
  , proxyCity          :: Maybe Text
  , proxyRegion        :: Maybe Text
  , proxyIsp           :: Maybe Text
  , proxyIsResidential :: Maybe Bool
  , proxyCheckDetails  :: Maybe Value
  , proxyLastChecked   :: Maybe Text
  , proxyLastCheckAt   :: Maybe Text
  , proxyIp            :: Maybe Text
  , proxyCountry       :: Maybe Text
  , proxyTimezone      :: Maybe Text
  , proxyAsn           :: Maybe Text
  , proxyAsnType       :: Maybe Text
  , proxyUsageType     :: Maybe Text
  , proxyDomain        :: Maybe Text
  , proxyOrg           :: Maybe Text
  , proxyPrivacy       :: Maybe Value
  , proxyHostnames     :: Maybe [Text]
  , proxyErrorMessage  :: Maybe Text
  , proxyIpChangeCount :: Maybe Int
  , proxyCreatedAt     :: Maybe Text
  , proxyUpdatedAt     :: Maybe Text
  } deriving (Show, Eq)

instance FromJSON Proxy where
  parseJSON = withObject "Proxy" $ \o -> Proxy
    <$> o .:  "id"
    <*> o .:? "name"
    <*> o .:? "type"
    <*> o .:? "host"
    <*> o .:? "port"
    <*> o .:? "username"
    <*> o .:? "password"
    <*> o .:? "status"
    <*> o .:? "countryCode"
    <*> o .:? "city"
    <*> o .:? "region"
    <*> o .:? "isp"
    <*> o .:? "isResidential"
    <*> o .:? "checkDetails"
    <*> o .:? "lastChecked"
    <*> o .:? "lastCheckAt"
    <*> o .:? "ip"
    <*> o .:? "country"
    <*> o .:? "timezone"
    <*> o .:? "asn"
    <*> o .:? "asnType"
    <*> o .:? "usageType"
    <*> o .:? "domain"
    <*> o .:? "org"
    <*> o .:? "privacy"
    <*> o .:? "hostnames"
    <*> o .:? "errorMessage"
    <*> o .:? "ipChangeCount"
    <*> o .:? "createdAt"
    <*> o .:? "updatedAt"

instance ToJSON Proxy where
  toJSON p = object
    [ "id"            .= proxyId p
    , "name"          .= proxyName p
    , "type"          .= proxyType p
    , "host"          .= proxyHost p
    , "port"          .= proxyPort p
    , "username"      .= proxyUsername p
    , "password"      .= proxyPassword p
    , "status"        .= proxyStatus p
    , "countryCode"   .= proxyCountryCode p
    , "city"          .= proxyCity p
    , "region"        .= proxyRegion p
    , "isp"           .= proxyIsp p
    , "isResidential" .= proxyIsResidential p
    , "checkDetails"  .= proxyCheckDetails p
    , "lastChecked"   .= proxyLastChecked p
    , "lastCheckAt"   .= proxyLastCheckAt p
    , "ip"            .= proxyIp p
    , "country"       .= proxyCountry p
    , "timezone"      .= proxyTimezone p
    , "asn"           .= proxyAsn p
    , "asnType"       .= proxyAsnType p
    , "usageType"     .= proxyUsageType p
    , "domain"        .= proxyDomain p
    , "org"           .= proxyOrg p
    , "privacy"       .= proxyPrivacy p
    , "hostnames"     .= proxyHostnames p
    , "errorMessage"  .= proxyErrorMessage p
    , "ipChangeCount" .= proxyIpChangeCount p
    , "createdAt"     .= proxyCreatedAt p
    , "updatedAt"     .= proxyUpdatedAt p
    ]

-- ─── CreateProxyRequest ──────────────────────────────────────────────────────

data CreateProxyRequest = CreateProxyRequest
  { cpxName     :: Text
  , cpxHost     :: Text
  , cpxPort     :: Int
  , cpxUsername :: Maybe Text
  , cpxPassword :: Maybe Text
  , cpxType     :: Text
  } deriving (Show, Eq)

instance ToJSON CreateProxyRequest where
  toJSON r = object
    [ "name"     .= cpxName r
    , "host"     .= cpxHost r
    , "port"     .= cpxPort r
    , "username" .= cpxUsername r
    , "password" .= cpxPassword r
    , "type"     .= cpxType r
    ]

instance FromJSON CreateProxyRequest where
  parseJSON = withObject "CreateProxyRequest" $ \o -> CreateProxyRequest
    <$> o .:  "name"
    <*> o .:  "host"
    <*> o .:  "port"
    <*> o .:? "username"
    <*> o .:? "password"
    <*> o .:  "type"

-- ─── Group ───────────────────────────────────────────────────────────────────

data Group = Group
  { groupId          :: Int
  , groupName        :: Text
  , groupDescription :: Maybe Text
  , groupColor       :: Maybe Text
  , groupDisplayOrder :: Maybe Int
  , groupCreatedAt   :: Maybe Text
  , groupUpdatedAt   :: Maybe Text
  } deriving (Show, Eq)

instance FromJSON Group where
  parseJSON = withObject "Group" $ \o -> Group
    <$> o .:  "id"
    <*> o .:  "name"
    <*> o .:? "description"
    <*> o .:? "color"
    <*> o .:? "displayOrder"
    <*> o .:? "createdAt"
    <*> o .:? "updatedAt"

instance ToJSON Group where
  toJSON g = object
    [ "id"           .= groupId g
    , "name"         .= groupName g
    , "description"  .= groupDescription g
    , "color"        .= groupColor g
    , "displayOrder" .= groupDisplayOrder g
    , "createdAt"    .= groupCreatedAt g
    , "updatedAt"    .= groupUpdatedAt g
    ]

-- ─── CreateGroupRequest ──────────────────────────────────────────────────────

data CreateGroupRequest = CreateGroupRequest
  { cgrName        :: Text
  , cgrDescription :: Maybe Text
  , cgrColor       :: Maybe Text
  } deriving (Show, Eq)

instance ToJSON CreateGroupRequest where
  toJSON r = object
    [ "name"        .= cgrName r
    , "description" .= cgrDescription r
    , "color"       .= cgrColor r
    ]

instance FromJSON CreateGroupRequest where
  parseJSON = withObject "CreateGroupRequest" $ \o -> CreateGroupRequest
    <$> o .:  "name"
    <*> o .:? "description"
    <*> o .:? "color"

-- ─── Extension ───────────────────────────────────────────────────────────────

data Extension = Extension
  { extensionId          :: Int
  , extensionName        :: Text
  , extensionPath        :: Maybe Text
  , extensionDescription :: Maybe Text
  , extensionIcon        :: Maybe Text
  , extensionIconDataUrl :: Maybe Text
  , extensionCreatedAt   :: Maybe Text
  } deriving (Show, Eq)

instance FromJSON Extension where
  parseJSON = withObject "Extension" $ \o -> Extension
    <$> o .:  "id"
    <*> o .:  "name"
    <*> o .:? "path"
    <*> o .:? "description"
    <*> o .:? "icon"
    <*> o .:? "iconDataUrl"
    <*> o .:? "createdAt"

instance ToJSON Extension where
  toJSON e = object
    [ "id"          .= extensionId e
    , "name"        .= extensionName e
    , "path"        .= extensionPath e
    , "description" .= extensionDescription e
    , "icon"        .= extensionIcon e
    , "iconDataUrl" .= extensionIconDataUrl e
    , "createdAt"   .= extensionCreatedAt e
    ]

-- ─── Automation ──────────────────────────────────────────────────────────────

data Automation = Automation
  { automationId                :: Int
  , automationName              :: Text
  , automationDescription       :: Maybe Text
  , automationDetectedVariables :: Maybe Value
  , automationCustomVariables   :: Maybe Value
  , automationLastRun           :: Maybe Text
  , automationStatus            :: Maybe Text
  , automationCreatedAt         :: Maybe Text
  , automationUpdatedAt         :: Maybe Text
  } deriving (Show, Eq)

instance FromJSON Automation where
  parseJSON = withObject "Automation" $ \o -> Automation
    <$> o .:  "id"
    <*> o .:  "name"
    <*> o .:? "description"
    <*> o .:? "detectedVariables"
    <*> o .:? "customVariables"
    <*> o .:? "lastRun"
    <*> o .:? "status"
    <*> o .:? "createdAt"
    <*> o .:? "updatedAt"

instance ToJSON Automation where
  toJSON a = object
    [ "id"                .= automationId a
    , "name"              .= automationName a
    , "description"       .= automationDescription a
    , "detectedVariables" .= automationDetectedVariables a
    , "customVariables"   .= automationCustomVariables a
    , "lastRun"           .= automationLastRun a
    , "status"            .= automationStatus a
    , "createdAt"         .= automationCreatedAt a
    , "updatedAt"         .= automationUpdatedAt a
    ]

-- ─── RunAutomationRequest ────────────────────────────────────────────────────

data RunAutomationRequest = RunAutomationRequest
  { rarProfileId     :: Int
  , rarDeleteCookies :: Maybe Bool
  , rarVariables     :: Maybe (Map Text Text)
  } deriving (Show, Eq)

instance ToJSON RunAutomationRequest where
  toJSON r = object
    [ "profileId"     .= rarProfileId r
    , "deleteCookies" .= rarDeleteCookies r
    , "variables"     .= rarVariables r
    ]

instance FromJSON RunAutomationRequest where
  parseJSON = withObject "RunAutomationRequest" $ \o -> RunAutomationRequest
    <$> o .:  "profileId"
    <*> o .:? "deleteCookies"
    <*> o .:? "variables"

-- ─── RunAutomationResult ─────────────────────────────────────────────────────

data RunAutomationResult = RunAutomationResult
  { rarSuccess   :: Bool
  , rarMessage   :: Text
  , rarVariables :: Maybe (Map Text Value)
  } deriving (Show, Eq)

instance FromJSON RunAutomationResult where
  parseJSON = withObject "RunAutomationResult" $ \o -> RunAutomationResult
    <$> o .:  "success"
    <*> o .:  "message"
    <*> o .:? "variables"

instance ToJSON RunAutomationResult where
  toJSON r = object
    [ "success"   .= rarSuccess r
    , "message"   .= rarMessage r
    , "variables" .= rarVariables r
    ]

-- ─── ApiResponse ─────────────────────────────────────────────────────────────

data ApiResponse = ApiResponse
  { arSuccess :: Maybe Bool
  , arMessage :: Maybe Text
  , arData    :: Maybe Value
  , arExtra   :: Map Text Value
  } deriving (Show, Eq)

instance FromJSON ApiResponse where
  parseJSON = withObject "ApiResponse" $ \o -> do
    s <- o .:? "success"
    m <- o .:? "message"
    d <- o .:? "data"
    let knownKeys = ["success" :: Text, "message", "data"]
        extra = Map.filterWithKey (\k _ -> k `notElem` knownKeys) (toMapText o)
    return $ ApiResponse s m d extra

instance ToJSON ApiResponse where
  toJSON r = object $
    [ "success" .= arSuccess r
    , "message" .= arMessage r
    , "data"    .= arData r
    ] ++ map (\(k, v) -> k .= v) (Map.toList (arExtra r))
