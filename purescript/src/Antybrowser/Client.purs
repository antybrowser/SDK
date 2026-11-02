module Antybrowser.Client
  ( AntybrowserClient(..)
  , mkClient
  , getProfiles
  , createProfile
  , updateProfile
  , deleteProfile
  , startProfile
  , stopProfile
  , duplicateProfile
  , getAutomations
  , runAutomation
  , getGroups
  , createGroup
  , updateGroup
  , deleteGroup
  , getProxies
  , createProxy
  , deleteProxy
  , getExtensions
  , deleteExtension
  ) where

import Prelude

import Aff (Aff, error)
import Affjax (AffjaxResponse)
import Affjax as AX
import Affjax.RequestHeader (RequestHeader(..))
import Affjax.Request as R
import Data.Argonaut.Core (Json, jsonNull, jsonSingletonEmpty)
import Data.Argonaut.Decode (class DecodeJson, decodeJson)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.Argonaut.Encode.Combinators ((:=), (~>))
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Aff (throwException)

import Antybrowser.Error (AntybrowserError(..))
import Antybrowser.Types

-- ─── Client Configuration ──────────────────────────────────────────────────

newtype AntybrowserClient = AntybrowserClient
  { apiKey :: String
  , baseUrl :: String
  , timeout :: Number
  }

mkClient :: String -> AntybrowserClient
mkClient apiKey = AntybrowserClient
  { apiKey
  , baseUrl: "http://127.0.0.1:5173"
  , timeout: 30000.0
  }

-- ─── Profiles ──────────────────────────────────────────────────────────────

getProfiles :: AntybrowserClient -> Aff (Array Profile)
getProfiles client = do
  json <- getJson client "/api/profiles"
  decodeOrThrow json

createProfile :: AntybrowserClient -> CreateProfileRequest -> Aff Profile
createProfile client req = do
  json <- postJson client "/api/profiles" (encodeJson req)
  decodeOrThrow json

updateProfile :: AntybrowserClient -> Int -> Json -> Aff Profile
updateProfile client profileId body = do
  json <- putJson client ("/api/profiles/" <> show profileId) body
  decodeOrThrow json

deleteProfile :: AntybrowserClient -> Int -> Aff Json
deleteProfile client profileId =
  deleteJson client ("/api/profiles/" <> show profileId)

startProfile :: AntybrowserClient -> Int -> Aff StartProfileResponse
startProfile client profileId = do
  json <- postJson client ("/api/profiles/" <> show profileId <> "/start") emptyBody
  decodeOrThrow json

stopProfile :: AntybrowserClient -> Int -> Aff Json
stopProfile client profileId =
  postJson client ("/api/profiles/" <> show profileId <> "/stop") emptyBody

duplicateProfile :: AntybrowserClient -> Int -> Aff Profile
duplicateProfile client profileId = do
  json <- postJson client ("/api/profiles/" <> show profileId <> "/duplicate") emptyBody
  decodeOrThrow json

-- ─── Automations ───────────────────────────────────────────────────────────

getAutomations :: AntybrowserClient -> Aff (Array Automation)
getAutomations client = do
  json <- getJson client "/api/automations"
  decodeOrThrow json

runAutomation :: AntybrowserClient -> Int -> RunAutomationRequest -> Aff RunAutomationResult
runAutomation client automationId req = do
  json <- postJson client ("/api/automations/" <> show automationId <> "/run") (encodeJson req)
  decodeOrThrow json

-- ─── Groups ────────────────────────────────────────────────────────────────

getGroups :: AntybrowserClient -> Aff (Array Group)
getGroups client = do
  json <- getJson client "/api/groups"
  decodeOrThrow json

createGroup :: AntybrowserClient -> CreateGroupRequest -> Aff Group
createGroup client req = do
  json <- postJson client "/api/groups" (encodeJson req)
  decodeOrThrow json

updateGroup :: AntybrowserClient -> Int -> Json -> Aff Group
updateGroup client groupId body = do
  json <- putJson client ("/api/groups/" <> show groupId) body
  decodeOrThrow json

deleteGroup :: AntybrowserClient -> Int -> Aff Json
deleteGroup client groupId =
  deleteJson client ("/api/groups/" <> show groupId)

-- ─── Proxies ───────────────────────────────────────────────────────────────

getProxies :: AntybrowserClient -> Aff (Array Proxy)
getProxies client = do
  json <- getJson client "/api/proxies"
  decodeOrThrow json

createProxy :: AntybrowserClient -> CreateProxyRequest -> Aff Proxy
createProxy client req = do
  json <- postJson client "/api/proxies" (encodeJson req)
  decodeOrThrow json

deleteProxy :: AntybrowserClient -> Int -> Aff Json
deleteProxy client proxyId =
  deleteJson client ("/api/proxies/" <> show proxyId)

-- ─── Extensions ────────────────────────────────────────────────────────────

getExtensions :: AntybrowserClient -> Aff (Array Extension)
getExtensions client = do
  json <- getJson client "/api/extensions"
  decodeOrThrow json

deleteExtension :: AntybrowserClient -> Int -> Aff Json
deleteExtension client extensionId =
  deleteJson client ("/api/extensions/" <> show extensionId)

-- ─── HTTP Helpers ──────────────────────────────────────────────────────────

getJson :: AntybrowserClient -> String -> Aff Json
getJson (AntybrowserClient c) path = do
  let url = c.baseUrl <> path
      req = R.defaultRequest
        { url = url
        , method = Left GET
        , headers = [ RequestHeader "x-api-key" c.apiKey ]
        }
  response <- AX.request req
  handleResponse response

postJson :: AntybrowserClient -> String -> Json -> Aff Json
postJson (AntybrowserClient c) path body = do
  let url = c.baseUrl <> path
      req = R.defaultRequest
        { url = url
        , method = Left POST
        , headers = [ RequestHeader "x-api-key" c.apiKey, RequestHeader "Content-Type" "application/json" ]
        , content = Just body
        }
  response <- AX.request req
  handleResponse response

putJson :: AntybrowserClient -> String -> Json -> Aff Json
putJson (AntybrowserClient c) path body = do
  let url = c.baseUrl <> path
      req = R.defaultRequest
        { url = url
        , method = Left PUT
        , headers = [ RequestHeader "x-api-key" c.apiKey, RequestHeader "Content-Type" "application/json" ]
        , content = Just body
        }
  response <- AX.request req
  handleResponse response

deleteJson :: AntybrowserClient -> String -> Aff Json
deleteJson (AntybrowserClient c) path = do
  let url = c.baseUrl <> path
      req = R.defaultRequest
        { url = url
        , method = Left DELETE
        , headers = [ RequestHeader "x-api-key" c.apiKey ]
        }
  response <- AX.request req
  handleResponse response

handleResponse :: AffjaxResponse Json -> Aff Json
handleResponse response =
  case response of
    Left err -> throwException $ error $ "HTTP request failed: " <> show err
    Right resp ->
      if resp.status >= 200 && resp.status < 300 then
        case resp.body of
          Left _ -> throwException $ error "Invalid JSON response from API"
          Right json -> pure json
      else
        throwException $ error $ "API request failed with status " <> show resp.status

-- ─── Decode Helpers ────────────────────────────────────────────────────────

decodeOrThrow :: forall a. DecodeJson a => Json -> Aff a
decodeOrThrow json =
  case decodeJson json of
    Left err -> throwException $ error $ "Failed to decode response: " <> show err
    Right val -> pure val

-- ─── Encoding Helpers ─────────────────────────────────────────────────────

emptyBody :: Json
emptyBody = jsonSingletonEmpty jsonNull

optEnc :: forall a. EncodeJson a => String -> Maybe a -> Json -> Json
optEnc _ Nothing json = json
optEnc key (Just val) json = (key := val) json
