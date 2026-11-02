module Antybrowser.Client
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
  ) where

import           Antybrowser.Error    (AntybrowserError (..))
import           Antybrowser.Types

import           Control.Exception    (throwIO)
import           Data.Aeson           (FromJSON (..), ToJSON (..), decode, encode)
import qualified Data.ByteString.Lazy as LBS
import           Data.Maybe           (fromMaybe)
import           Data.Text            (Text)
import qualified Data.Text            as T
import qualified Data.Text.Encoding   as TE
import           Network.HTTP.Client  (Manager, Request (..), RequestBody (..),
                                       Response (..), ResponseTimeout (..),
                                       httpLbs, newManager, parseRequest,
                                       responseStatus)
import           Network.HTTP.Client.TLS (tlsManagerSettings)
import           Network.HTTP.Types   (hContentType, hUserAgent,
                                       statusIsSuccessful)
import           Prelude

-- ─── Client ──────────────────────────────────────────────────────────────────

data AntybrowserClient = AntybrowserClient
  { acApiKey  :: Text
  , acBaseUrl :: Text
  , acManager :: Manager
  , acTimeout :: Int
  }

data ClientOptions = ClientOptions
  { coPort    :: Maybe Int
  , coBaseUrl :: Maybe Text
  , coTimeout :: Maybe Int
  } deriving (Show, Eq)

newClient :: Text -> IO AntybrowserClient
newClient apiKey = newClientWithOptions apiKey defaultOptions

newClientWithOptions :: Text -> ClientOptions -> IO AntybrowserClient
newClientWithOptions apiKey opts = do
  let port    = fromMaybe 5173 (coPort opts)
      base    = fromMaybe ("http://127.0.0.1:" <> T.pack (show port)) (coBaseUrl opts)
      timeout = fromMaybe 30000 (coTimeout opts)
  mgr <- newManager tlsManagerSettings
  return AntybrowserClient
    { acApiKey  = apiKey
    , acBaseUrl = base
    , acManager = mgr
    , acTimeout = timeout
    }

defaultOptions :: ClientOptions
defaultOptions = ClientOptions Nothing Nothing Nothing

-- ─── Profiles ────────────────────────────────────────────────────────────────

getProfiles :: AntybrowserClient -> IO [Profile]
getProfiles = get "/api/profiles"

createProfile :: AntybrowserClient -> CreateProfileRequest -> IO Profile
createProfile client req = post client "/api/profiles" req

updateProfile :: AntybrowserClient -> Int -> CreateProfileRequest -> IO Profile
updateProfile client pid req = put client ("/api/profiles/" <> T.pack (show pid)) req

deleteProfile :: AntybrowserClient -> Int -> IO ApiResponse
deleteProfile client pid = delete client ("/api/profiles/" <> T.pack (show pid))

startProfile :: AntybrowserClient -> Int -> IO StartProfileResponse
startProfile client pid = post client ("/api/profiles/" <> T.pack (show pid) <> "/start") NoContent

stopProfile :: AntybrowserClient -> Int -> IO ApiResponse
stopProfile client pid = post client ("/api/profiles/" <> T.pack (show pid) <> "/stop") NoContent

duplicateProfile :: AntybrowserClient -> Int -> Maybe DuplicateProfileRequest -> IO Profile
duplicateProfile client pid opts = post client ("/api/profiles/" <> T.pack (show pid) <> "/duplicate") $
  fromMaybe NoContent opts

-- ─── Automations ─────────────────────────────────────────────────────────────

getAutomations :: AntybrowserClient -> IO [Automation]
getAutomations = get "/api/automations"

runAutomation :: AntybrowserClient -> Int -> RunAutomationRequest -> IO RunAutomationResult
runAutomation client aid req =
  post client ("/api/automations/" <> T.pack (show aid) <> "/run") req

-- ─── Groups ──────────────────────────────────────────────────────────────────

getGroups :: AntybrowserClient -> IO [Group]
getGroups = get "/api/groups"

createGroup :: AntybrowserClient -> CreateGroupRequest -> IO Group
createGroup client req = post client "/api/groups" req

updateGroup :: AntybrowserClient -> Int -> CreateGroupRequest -> IO Group
updateGroup client gid req = put client ("/api/groups/" <> T.pack (show gid)) req

deleteGroup :: AntybrowserClient -> Int -> IO ()
deleteGroup client gid = delete client ("/api/groups/" <> T.pack (show gid)) >> return ()

-- ─── Proxies ─────────────────────────────────────────────────────────────────

getProxies :: AntybrowserClient -> IO [Proxy]
getProxies = get "/api/proxies"

createProxy :: AntybrowserClient -> CreateProxyRequest -> IO Proxy
createProxy client req = post client "/api/proxies" req

deleteProxy :: AntybrowserClient -> Int -> IO ()
deleteProxy client pid = delete client ("/api/proxies/" <> T.pack (show pid)) >> return ()

-- ─── Extensions ──────────────────────────────────────────────────────────────

getExtensions :: AntybrowserClient -> IO [Extension]
getExtensions = get "/api/extensions"

deleteExtension :: AntybrowserClient -> Int -> IO ()
deleteExtension client eid = delete client ("/api/extensions/" <> T.pack (show eid)) >> return ()

-- ─── HTTP Helpers ────────────────────────────────────────────────────────────

get :: (FromJSON a) => AntybrowserClient -> Text -> IO a
get client path = do
  resp <- request client "GET" path Nothing
  handleResponse resp

post :: (FromJSON a, ToJSON body) => AntybrowserClient -> Text -> body -> IO a
post client path body = do
  resp <- request client "POST" path (Just (encode body))
  handleResponse resp

put :: (FromJSON a, ToJSON body) => AntybrowserClient -> Text -> body -> IO a
put client path body = do
  resp <- request client "PUT" path (Just (encode body))
  handleResponse resp

delete :: (FromJSON a) => AntybrowserClient -> Text -> IO a
delete client path = do
  resp <- request client "DELETE" path Nothing
  handleResponse resp

request :: AntybrowserClient -> Text -> Text -> Maybe LBS.ByteString -> IO (Response LBS.ByteString)
request client method path mBody = do
  let url = T.unpack (acBaseUrl client <> path)
  initReq <- parseRequest url
  let req = initReq
        { method         = TE.encodeUtf8 method
        , requestHeaders =
            [ ("x-api-key", TE.encodeUtf8 (acApiKey client))
            , (hContentType, "application/json")
            , (hUserAgent, "antybrowser-haskell-sdk/1.0.3")
            ]
        , requestBody = maybe NoContent RequestBodyLBS mBody
        , responseTimeout = responseTimeoutMicros (acTimeout client * 1000)
        }
  httpLbs req (acManager client)

handleResponse :: (FromJSON a) => Response LBS.ByteString -> IO a
handleResponse resp = do
  let status = responseStatus resp
      body   = responseBody resp
  if statusIsSuccessful status
    then do
      if LBS.null body
        then throwIO $ AntybrowserError "Empty response body" (Just 200) Nothing
        else case decode body of
          Nothing -> throwIO $ AntybrowserError
            "Invalid JSON response from API"
            (Just (fromEnum status))
            (Just (T.unpack (TE.decodeUtf8 (LBS.toStrict body))))
          Just val -> return val
    else throwIO $ AntybrowserError
      ("API request failed with status " ++ show (fromEnum status))
      (Just (fromEnum status))
      (Just (T.unpack (TE.decodeUtf8 (LBS.toStrict body))))
