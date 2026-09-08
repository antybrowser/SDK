module Antybrowser.Types
  ( -- * Profile
    Profile(..)
  , CreateProfileRequest(..)
  , DuplicateProfileRequest(..)
  , StartProfileResponse(..)
    -- * Proxy
  , Proxy(..)
  , CreateProxyRequest(..)
  , ProxyCheckResult(..)
  , ProxyCheckDetails(..)
    -- * Group
  , Group(..)
  , CreateGroupRequest(..)
    -- * Extension
  , Extension(..)
    -- * Automation
  , Automation(..)
  , RunAutomationRequest(..)
  , RunAutomationResult(..)
    -- * Settings & Status
  , Settings(..)
  , SyncStatus(..)
  , StatusResponse(..)
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
  { profileId                :: Int
  , profileName              :: Text
  , profileDirectoryName     :: Maybe Text
  , profileGroupId           :: Maybe Int
  , profileProxyId           :: Maybe Int
  , profileBrowserType       :: Maybe Text
  , profileBrowserVersion    :: Maybe Text
  , profileOsFingerprint     :: Maybe Text
  , profileScreenResolution  :: Maybe Text
  , profileLanguage          :: Maybe Text
  , profileAcceptLanguage    :: Maybe Text
  , profileTimezone          :: Maybe Text
  , profileUseFingerprint    :: Maybe Bool
  , profileFingerprintId     :: Maybe Text
  , profileRestoreSession    :: Maybe Bool
  , profileLowBandwidth      :: Maybe Bool
  , profileNotes             :: Maybe Text
  , profileStartUrl          :: Maybe Text
  , profileCustomFlags       :: Maybe Text
  , profileStatus            :: Maybe Text
  , profileNeedsSync         :: Maybe Bool
  , profileLastPid           :: Maybe Int
  , profileDebugPort         :: Maybe Int
  , profileCreatedAt         :: Maybe Text
  , profileUpdatedAt         :: Maybe Text
  , profileLastSyncedAt      :: Maybe Text
  , profileS3Key             :: Maybe Text
  , profileTrash             :: Maybe Bool
  , profileDeletedAt         :: Maybe Text
  , profileHidden            :: Maybe Bool
  } deriving (Show, Eq)

instance FromJSON Profile where
  parseJSON = withObject "Profile" $ \o -> Profile
    <$> o .:  "id"
    <*> o .:  "name"
    <*> o .:? "directoryName"
    <*> o .:? "groupId"
    <*> o .:? "proxyId"
    <*> o .:? "browserType"
    <*> o .:? "browserVersion"
    <*> o .:? "osFingerprint"
    <*> o .:? "screenResolution"
    <*> o .:? "language"
    <*> o .:? "acceptLanguage"
    <*> o .:? "timezone"
    <*> o .:? "useFingerprint"
    <*> o .:? "fingerprintId"
    <*> o .:? "restoreSession"
    <*> o .:? "lowBandwidth"
    <*> o .:? "notes"
    <*> o .:? "startUrl"
    <*> o .:? "customFlags"
    <*> o .:? "status"
    <*> o .:? "needsSync"
    <*> o .:? "lastPid"
    <*> o .:? "debugPort"
    <*> o .:? "createdAt"
    <*> o .:? "updatedAt"
    <*> o .:? "lastSyncedAt"
    <*> o .:? "s3Key"
    <*> o .:? "trash"
    <*> o .:? "deletedAt"
    <*> o .:? "hidden"

instance ToJSON Profile where
  toJSON p = object
    [ "id"                .= profileId p
    , "name"              .= profileName p
    , "directoryName"     .= profileDirectoryName p
    , "groupId"           .= profileGroupId p
    , "proxyId"           .= profileProxyId p
    , "browserType"       .= profileBrowserType p
    , "browserVersion"    .= profileBrowserVersion p
    , "osFingerprint"     .= profileOsFingerprint p
    , "screenResolution"  .= profileScreenResolution p
    , "language"          .= profileLanguage p
    , "acceptLanguage"    .= profileAcceptLanguage p
    , "timezone"          .= profileTimezone p
    , "useFingerprint"    .= profileUseFingerprint p
    , "fingerprintId"     .= profileFingerprintId p
    , "restoreSession"    .= profileRestoreSession p
    , "lowBandwidth"      .= profileLowBandwidth p
    , "notes"             .= profileNotes p
    , "startUrl"          .= profileStartUrl p
    , "customFlags"       .= profileCustomFlags p
    , "status"            .= profileStatus p
    , "needsSync"         .= profileNeedsSync p
    , "lastPid"           .= profileLastPid p
    , "debugPort"         .= profileDebugPort p
    , "createdAt"         .= profileCreatedAt p
    , "updatedAt"         .= profileUpdatedAt p
    , "lastSyncedAt"      .= profileLastSyncedAt p
    , "s3Key"             .= profileS3Key p
    , "trash"             .= profileTrash p
    , "deletedAt"         .= profileDeletedAt p
    , "hidden"            .= profileHidden p
    ]

-- ─── CreateProfileRequest ────────────────────────────────────────────────────

data CreateProfileRequest = CreateProfileRequest
  { cprName              :: Text
  , cprDirectoryName     :: Maybe Text
  , cprGroupId           :: Maybe Int
  , cprProxyId           :: Maybe Int
  , cprBrowserType       :: Maybe Text
  , cprBrowserVersion    :: Maybe Text
  , cprOsFingerprint     :: Maybe Text
  , cprScreenResolution  :: Maybe Text
  , cprLanguage          :: Maybe Text
  , cprAcceptLanguage    :: Maybe Text
  , cprTimezone          :: Maybe Text
  , cprUseFingerprint    :: Maybe Bool
  , cprFingerprintId     :: Maybe Text
  , cprRestoreSession    :: Maybe Bool
  , cprLowBandwidth      :: Maybe Bool
  , cprNotes             :: Maybe Text
  , cprStartUrl          :: Maybe Text
  , cprCustomFlags       :: Maybe Text
  } deriving (Show, Eq)

instance ToJSON CreateProfileRequest where
  toJSON r = object
    [ "name"              .= cprName r
    , "directoryName"     .= cprDirectoryName r
    , "groupId"           .= cprGroupId r
    , "proxyId"           .= cprProxyId r
    , "browserType"       .= cprBrowserType r
    , "browserVersion"    .= cprBrowserVersion r
    , "osFingerprint"     .= cprOsFingerprint r
    , "screenResolution"  .= cprScreenResolution r
    , "language"          .= cprLanguage r
    , "acceptLanguage"    .= cprAcceptLanguage r
    , "timezone"          .= cprTimezone r
    , "useFingerprint"    .= cprUseFingerprint r
    , "fingerprintId"     .= cprFingerprintId r
    , "restoreSession"    .= cprRestoreSession r
    , "lowBandwidth"      .= cprLowBandwidth r
    , "notes"             .= cprNotes r
    , "startUrl"          .= cprStartUrl r
    , "customFlags"       .= cprCustomFlags r
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
    <*> o .:? "language"
    <*> o .:? "acceptLanguage"
    <*> o .:? "timezone"
    <*> o .:? "useFingerprint"
    <*> o .:? "fingerprintId"
    <*> o .:? "restoreSession"
    <*> o .:? "lowBandwidth"
    <*> o .:? "notes"
    <*> o .:? "startUrl"
    <*> o .:? "customFlags"

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

-- ─── ProxyCheckResult ────────────────────────────────────────────────────────

data ProxyCheckResult = ProxyCheckResult
  { pcrSuccess      :: Bool
  , pcrDetails      :: Maybe ProxyCheckDetails
  , pcrErrorMessage :: Maybe Text
  } deriving (Show, Eq)

instance FromJSON ProxyCheckResult where
  parseJSON = withObject "ProxyCheckResult" $ \o -> ProxyCheckResult
    <$> o .:  "success"
    <*> o .:? "details"
    <*> o .:? "errorMessage"

instance ToJSON ProxyCheckResult where
  toJSON r = object
    [ "success"      .= pcrSuccess r
    , "details"      .= pcrDetails r
    , "errorMessage" .= pcrErrorMessage r
    ]

-- ─── ProxyCheckDetails ───────────────────────────────────────────────────────

data ProxyCheckDetails = ProxyCheckDetails
  { pcdIp             :: Maybe Text
  , pcdCountry        :: Maybe Text
  , pcdCountryCode    :: Maybe Text
  , pcdCity           :: Maybe Text
  , pcdRegion         :: Maybe Text
  , pcdTimezone       :: Maybe Text
  , pcdIsp            :: Maybe Text
  , pcdAsn            :: Maybe Text
  , pcdAsnType        :: Maybe Text
  , pcdOrg            :: Maybe Text
  , pcdUsageType      :: Maybe Text
  , pcdDomain         :: Maybe Text
  , pcdIsResidential  :: Maybe Bool
  , pcdPrivacy        :: Maybe Value
  , pcdHostnames      :: Maybe [Text]
  , pcdRiskAssessment :: Maybe Value
  } deriving (Show, Eq)

instance FromJSON ProxyCheckDetails where
  parseJSON = withObject "ProxyCheckDetails" $ \o -> ProxyCheckDetails
    <$> o .:? "ip"
    <*> o .:? "country"
    <*> o .:? "countryCode"
    <*> o .:? "city"
    <*> o .:? "region"
    <*> o .:? "timezone"
    <*> o .:? "isp"
    <*> o .:? "asn"
    <*> o .:? "asnType"
    <*> o .:? "org"
    <*> o .:? "usageType"
    <*> o .:? "domain"
    <*> o .:? "isResidential"
    <*> o .:? "privacy"
    <*> o .:? "hostnames"
    <*> o .:? "riskAssessment"

instance ToJSON ProxyCheckDetails where
  toJSON d = object
    [ "ip"            .= pcdIp d
    , "country"       .= pcdCountry d
    , "countryCode"   .= pcdCountryCode d
    , "city"          .= pcdCity d
    , "region"        .= pcdRegion d
    , "timezone"      .= pcdTimezone d
    , "isp"           .= pcdIsp d
    , "asn"           .= pcdAsn d
    , "asnType"       .= pcdAsnType d
    , "org"           .= pcdOrg d
    , "usageType"     .= pcdUsageType d
    , "domain"        .= pcdDomain d
    , "isResidential" .= pcdIsResidential d
    , "privacy"       .= pcdPrivacy d
    , "hostnames"     .= pcdHostnames d
    , "riskAssessment" .= pcdRiskAssessment d
    ]

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

-- ─── Settings ────────────────────────────────────────────────────────────────

data Settings = Settings
  { settingsId                        :: Maybe Int
  , settingsChromePath                :: Maybe Text
  , settingsLicenseKey                :: Maybe Text
  , settingsDefaultBrowserType        :: Maybe Text
  , settingsDefaultOsFingerprint      :: Maybe Text
  , settingsDefaultScreenResolution   :: Maybe Text
  , settingsDefaultLanguage           :: Maybe Text
  , settingsDefaultAcceptLanguage     :: Maybe Text
  , settingsDefaultTimezone           :: Maybe Text
  , settingsDefaultLowBandwidth       :: Maybe Bool
  , settingsApiEnabled                :: Maybe Bool
  , settingsApiKey                    :: Maybe Text
  , settingsLanguage                  :: Maybe Text
  , settingsOnCloseAction             :: Maybe Text
  , settingsLaunchOnStartup           :: Maybe Bool
  , settingsLaunchMinimizedOnStartup  :: Maybe Bool
  , settingsIpQualityScoreApiKey      :: Maybe Text
  , settingsUseIpQualityScore         :: Maybe Bool
  , settingsBrowserFlags              :: Maybe Text
  , settingsFontSizeScale             :: Maybe Text
  , settingsExtra                     :: Map Text Value
  } deriving (Show, Eq)

instance FromJSON Settings where
  parseJSON = withObject "Settings" $ \o -> do
    i   <- o .:? "id"
    cp  <- o .:? "chromePath"
    lk  <- o .:? "licenseKey"
    db  <- o .:? "defaultBrowserType"
    df  <- o .:? "defaultOsFingerprint"
    dr  <- o .:? "defaultScreenResolution"
    dl  <- o .:? "defaultLanguage"
    da  <- o .:? "defaultAcceptLanguage"
    dt  <- o .:? "defaultTimezone"
    dlw <- o .:? "defaultLowBandwidth"
    ae  <- o .:? "apiEnabled"
    ak  <- o .:? "apiKey"
    la  <- o .:? "language"
    oa  <- o .:? "onCloseAction"
    los <- o .:? "launchOnStartup"
    lms <- o .:? "launchMinimizedOnStartup"
    iqk <- o .:? "ipQualityScoreApiKey"
    uiq <- o .:? "useIpQualityScore"
    bf  <- o .:? "browserFlags"
    fs  <- o .:? "fontSizeScale"
    let knownKeys = [ "id" :: Text, "chromePath", "licenseKey"
                    , "defaultBrowserType", "defaultOsFingerprint"
                    , "defaultScreenResolution", "defaultLanguage"
                    , "defaultAcceptLanguage", "defaultTimezone"
                    , "defaultLowBandwidth", "apiEnabled", "apiKey"
                    , "language", "onCloseAction", "launchOnStartup"
                    , "launchMinimizedOnStartup", "ipQualityScoreApiKey"
                    , "useIpQualityScore", "browserFlags", "fontSizeScale"
                    ]
        extra = Map.filterWithKey (\k _ -> k `notElem` knownKeys) (toMapText o)
    return $ Settings i cp lk db df dr dl da dt dlw ae ak la oa los lms iqk uiq bf fs extra

instance ToJSON Settings where
  toJSON s = object $
    [ "id"                       .= settingsId s
    , "chromePath"               .= settingsChromePath s
    , "licenseKey"               .= settingsLicenseKey s
    , "defaultBrowserType"       .= settingsDefaultBrowserType s
    , "defaultOsFingerprint"     .= settingsDefaultOsFingerprint s
    , "defaultScreenResolution"  .= settingsDefaultScreenResolution s
    , "defaultLanguage"          .= settingsDefaultLanguage s
    , "defaultAcceptLanguage"    .= settingsDefaultAcceptLanguage s
    , "defaultTimezone"          .= settingsDefaultTimezone s
    , "defaultLowBandwidth"      .= settingsDefaultLowBandwidth s
    , "apiEnabled"               .= settingsApiEnabled s
    , "apiKey"                   .= settingsApiKey s
    , "language"                 .= settingsLanguage s
    , "onCloseAction"            .= settingsOnCloseAction s
    , "launchOnStartup"          .= settingsLaunchOnStartup s
    , "launchMinimizedOnStartup" .= settingsLaunchMinimizedOnStartup s
    , "ipQualityScoreApiKey"     .= settingsIpQualityScoreApiKey s
    , "useIpQualityScore"        .= settingsUseIpQualityScore s
    , "browserFlags"             .= settingsBrowserFlags s
    , "fontSizeScale"            .= settingsFontSizeScale s
    ] ++ map (\(k, v) -> k .= v) (Map.toList (settingsExtra s))

-- ─── SyncStatus ──────────────────────────────────────────────────────────────

data SyncStatus = SyncStatus
  { ssActive           :: [Value]
  , ssActiveExtensions :: [Value]
  , ssTotal            :: Int
  , ssCompleted        :: Int
  , ssErrors           :: Map Text Value
  , ssProgress         :: Map Text Value
  , ssIsSyncing        :: Bool
  } deriving (Show, Eq)

instance FromJSON SyncStatus where
  parseJSON = withObject "SyncStatus" $ \o -> SyncStatus
    <$> o .:? "active"           .!= []
    <*> o .:? "activeExtensions" .!= []
    <*> o .:  "total"
    <*> o .:  "completed"
    <*> o .:? "errors"           .!= Map.empty
    <*> o .:? "progress"         .!= Map.empty
    <*> o .:  "isSyncing"

instance ToJSON SyncStatus where
  toJSON s = object
    [ "active"           .= ssActive s
    , "activeExtensions" .= ssActiveExtensions s
    , "total"            .= ssTotal s
    , "completed"        .= ssCompleted s
    , "errors"           .= ssErrors s
    , "progress"         .= ssProgress s
    , "isSyncing"        .= ssIsSyncing s
    ]

-- ─── StatusResponse ──────────────────────────────────────────────────────────

data StatusResponse = StatusResponse
  { srSuccess :: Bool
  , srStatus  :: Text
  , srVersion :: Text
  } deriving (Show, Eq)

instance FromJSON StatusResponse where
  parseJSON = withObject "StatusResponse" $ \o -> StatusResponse
    <$> o .: "success"
    <*> o .: "status"
    <*> o .: "version"

instance ToJSON StatusResponse where
  toJSON r = object
    [ "success" .= srSuccess r
    , "status"  .= srStatus r
    , "version" .= srVersion r
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
