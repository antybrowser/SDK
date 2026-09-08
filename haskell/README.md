<p align="center">
  <img src="https://antybrowser.com/favicon.ico" alt="Antybrowser Logo" width="64">
</p>

<h1 align="center">Antybrowser SDK — Haskell</h1>

<p align="center">
  Official Haskell client for the Antybrowser Local API. Manage browser profiles, proxies, automations, groups, and extensions programmatically.
</p>

<p align="center">
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## Prerequisites

- **GHC >= 8.10** with **Cabal >= 3.4**
- **Antybrowser** desktop app running with the Local API enabled

## Installation

```bash
cabal install antybrowser-sdk
```

Or add to your `.cabal` file:

```cabal
build-depends:
    antybrowser-sdk >= 1.0.3
```

## Quick Start

```haskell
import Antybrowser

main :: IO ()
main = do
  client <- newClient "your_api_key_here"

  -- List all profiles
  profiles <- getProfiles client
  print profiles

  -- Start a profile and get the debug port
  result <- startProfile client 123
  putStrLn $ "Debug port: " ++ show (sprDebugPort result)
```

## Configuration

```haskell
-- Simple — API key only (uses default port 5173)
client <- newClient "my_api_key"

-- Custom port
client <- newClientWithOptions "my_api_key"
  defaultOptions { coPort = Just 5174 }

-- Full options
client <- newClientWithOptions "my_api_key"
  defaultOptions
    { coPort    = Just 5174
    , coBaseUrl = Just "http://192.168.1.100:5173"
    , coTimeout = Just 60000
    }
```

## API Reference

### System

| Method | Description |
|--------|-------------|
| `getStatus` | Check API connection status |
| `getSettings` | Get current settings |
| `getSyncStatus` | Get sync queue status |
| `refreshSync` | Trigger a sync refresh |

### Profiles

| Method | Description |
|--------|-------------|
| `getProfiles` | List all profiles |
| `createProfile` | Create a new profile |
| `updateProfile` | Update a profile |
| `deleteProfile` | Delete a profile |
| `startProfile` | Start a profile (returns debug port) |
| `stopProfile` | Stop a running profile |
| `duplicateProfile` | Duplicate a profile |

### Automations

| Method | Description |
|--------|-------------|
| `getAutomations` | List all automations |
| `runAutomation` | Run an automation on a profile |

### Groups

| Method | Description |
|--------|-------------|
| `getGroups` | List all groups |
| `createGroup` | Create a group |
| `updateGroup` | Update a group |
| `deleteGroup` | Delete a group |

### Proxies

| Method | Description |
|--------|-------------|
| `getProxies` | List all proxies |
| `createProxy` | Add a proxy |
| `checkProxy` | Check a single proxy |
| `checkProxiesBulk` | Check multiple proxies |
| `deleteProxy` | Delete a proxy |

### Extensions

| Method | Description |
|--------|-------------|
| `getExtensions` | List all extensions |
| `deleteExtension` | Delete an extension |
| `getProfileExtensions` | Get extensions for a profile |
| `setProfileExtensions` | Set extensions for a profile |

## Examples

### Create and launch a profile

```haskell
import Antybrowser

main :: IO ()
main = do
  client <- newClient "your_api_key"
  let req = CreateProfileRequest
        { cprName             = "My Profile"
        , cprDirectoryName    = Nothing
        , cprGroupId          = Nothing
        , cprProxyId          = Nothing
        , cprBrowserType      = Just "Chrome"
        , cprBrowserVersion   = Nothing
        , cprOsFingerprint    = Just "Windows"
        , cprScreenResolution = Nothing
        , cprLanguage         = Just "en-US"
        , cprAcceptLanguage   = Nothing
        , cprTimezone         = Nothing
        , cprUseFingerprint   = Just True
        , cprFingerprintId    = Nothing
        , cprRestoreSession   = Nothing
        , cprLowBandwidth     = Nothing
        , cprNotes            = Nothing
        , cprStartUrl         = Nothing
        , cprCustomFlags      = Nothing
        }

  profile <- createProfile client req
  putStrLn $ "Created profile: " ++ show (profileName profile)

  result <- startProfile client (profileId profile)
  putStrLn $ "Debug port: " ++ show (sprDebugPort result)
```

### Bulk proxy check

```haskell
import Antybrowser

main :: IO ()
main = do
  client <- newClient "your_api_key"
  results <- checkProxiesBulk client
    [ Left "user:pass:1.2.3.4:8080"
    , Right ("5.6.7.8", 3128, Nothing, Nothing, Just "socks5")
    ]

  mapM_ (\(i, r) -> putStrLn $ "Proxy " ++ show i ++ ": " ++
    if pcrSuccess r
      then maybe "unknown" show (pcrDetails r >>= pcdCountry)
      else maybe "error" show (pcrErrorMessage r)
    ) (zip [1 :: Int ..] results)
```

### Run an automation

```haskell
import Antybrowser
import qualified Data.Map.Strict as Map

main :: IO ()
main = do
  client <- newClient "your_api_key"
  let req = RunAutomationRequest
        { rarProfileId     = 123
        , rarDeleteCookies = Nothing
        , rarVariables     = Just (Map.singleton "TARGET_URL" "https://example.com")
        }
  result <- runAutomation client 42 req
  putStrLn (T.unpack (rarMessage result))
```

## Error Handling

```haskell
import Antybrowser
import Control.Exception (try)

main :: IO ()
main = do
  client <- newClient "your_api_key"
  result <- try (getProfiles client) :: IO (Either AntybrowserError [Profile])
  case result of
    Left err -> do
      putStrLn $ "Error: " ++ errorMessage err
      putStrLn $ "Status: " ++ show (errorStatusCode err)
    Right profiles -> print profiles
```

## Links

- [Antybrowser Website](https://antybrowser.com)
- [Documentation](https://docs.antybrowser.com)
- [GitHub Repository](https://github.com/antybrowser/SDK)
- [npm Package](https://www.npmjs.com/package/@antybrowser/sdk)
- [PyPI Package](https://pypi.org/project/antybrowser/)

## License

MIT

---
*Antybrowser - The ultimate solution for secure and undetectable multi-accounting.*
