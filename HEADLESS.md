# Headless profiles

The Antybrowser Local API can start any profile **headless** — no visible
window, no taskbar entry, and the same fingerprint surfaces as a headed launch.

```http
POST http://localhost:5173/api/profiles/:id/start
x-api-key: <your local API key>
content-type: application/json

{ "headless": true }
```

The response is unchanged: `{ "success": true, "data": { "debugPort": 52395 } }`.
`debugPort` is the Chrome DevTools Protocol port — attach Puppeteer, Playwright
or Selenium to it.

> Requires Antybrowser Chromium **154.0.8037.57 r16 or newer** (patch 0051).
> Older builds accept `{ "headless": true }` but fall back to a plain
> `--headless=new` launch (no automation-switch filtering, no `HeadlessChrome`
> guarantee).

## Why it is different from a stock headless Chrome

- **The Headless UA token is dropped.** `--fingerprint-headless` appends
  `--headless=new` and removes the `HeadlessChrome` product token even when no
  brand flag is set.
- **No automation-only switches.** A stealth headless launch keeps the same
  launch flags as a headed run: popup blocking, the hang monitor, the repost
  prompt and Chrome's own background-timer throttling all stay on. The
  automation switches remain available for warm-up (`headlessTier: "eco"`), not
  for a session a site will inspect.
- **One identity.** The same engine patches (canvas, WebGL, audio, fonts,
  Client Hints, screen/window metrics, permissions, WebRTC) apply in both
  modes. The headed and headless controls measure the same CreepJS and
  Sannysoft results.

Headless does **not** make the driver invisible. Puppeteer and Playwright still
talk CDP, and some sites detect the protocol (for example the classic
`Runtime.enable` console side effect, or Playwright's injected bindings). For
hard targets use a CDP-minimal client (nodriver, patchright) or the browser's
own automation hooks. See the measured limits in the
[headless page](https://antybrowser.com/undetected-headless-browser).

## Node.js — Puppeteer

```ts
import puppeteer from "puppeteer-core";
import { AntybrowserClient } from "@antybrowser/sdk";

const client = new AntybrowserClient({ apiKey: process.env.ANTY_API_KEY!, port: 5173 });
const { data } = await client.startProfile(123, true);

const browser = await puppeteer.connect({
  browserURL: `http://127.0.0.1:${data.debugPort}`,
  defaultViewport: null,
});

const page = await browser.newPage();
await page.goto("https://example.com");
console.log(await page.title());
await browser.close();          // disconnects Puppeteer; stop the profile with the SDK
await client.stopProfile(123);
```

## Node.js — Playwright

```ts
import { chromium } from "playwright";
import { AntybrowserClient } from "@antybrowser/sdk";

const client = new AntybrowserClient({ apiKey: process.env.ANTY_API_KEY!, port: 5173 });
const { data } = await client.startProfile(123, true);

const browser = await chromium.connectOverCDP(`http://127.0.0.1:${data.debugPort}`);
const context = browser.contexts()[0];
const page = await context.newPage();
await page.goto("https://example.com");
console.log(await page.title());
await browser.close();
await client.stopProfile(123);
```

## Python — Playwright

```python
import asyncio
from antybrowser import AntybrowserClient
from playwright.async_api import async_playwright

async def main():
    async with AntybrowserClient(api_key="your_key") as client:
        result = await client.start_profile(123, headless=True)
        async with async_playwright() as p:
            browser = await p.chromium.connect_over_cdp(
                f"http://127.0.0.1:{result.data.debug_port}"
            )
            page = await browser.new_page()
            await page.goto("https://example.com")
            print(await page.title())
            await browser.close()
        await client.stop_profile(123)

asyncio.run(main())
```

## Python — Selenium

```python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from antybrowser import AntybrowserClient

with AntybrowserClient(api_key="your_key") as client:
    result = client.start_profile(123, headless=True)  # sync client in antybrowser.sync
    options = Options()
    options.debugger_address = f"127.0.0.1:{result.data.debug_port}"
    driver = webdriver.Chrome(options=options)
    driver.get("https://example.com")
    print(driver.title)
    driver.quit()
    client.stop_profile(123)
```

## C# / .NET

```csharp
using Antybrowser.SDK;
using PuppeteerSharp;

using var client = new AntybrowserClient("your_api_key");
var started = await client.StartProfileAsync(123, headless: true);

var browser = await Puppeteer.ConnectAsync(new ConnectOptions
{
    BrowserURL = $"http://127.0.0.1:{started.Data.DebugPort}",
});
var page = await browser.NewPageAsync();
await page.GoToAsync("https://example.com");
await browser.CloseAsync();
await client.StopProfileAsync(123);
```

## Go

```go
import (
    antybrowser "github.com/antybrowser/SDK/go"
    "github.com/chromedp/chromedp"
)

client := antybrowser.NewClient("your_key", antybrowser.WithPort(5173))
result, _ := client.StartProfile(123, true)

allocCtx, cancel := chromedp.NewRemoteAllocator(context.Background(),
    fmt.Sprintf("http://127.0.0.1:%d", result.Data.DebugPort))
defer cancel()
ctx, cancelCtx := chromedp.NewContext(allocCtx)
defer cancelCtx()
_ = chromedp.Run(ctx, chromedp.Navigate("https://example.com"))
_ = client.StopProfile(123)
```

## PHP

```php
use Antybrowser\SDK\AntybrowserClient;

$client = new AntybrowserClient('your_key');
$result = $client->startProfile(123, headless: true);
$ws = 'http://127.0.0.1:' . $result['data']['debugPort'];
// Point a CDP client (e.g. chrome-php/chrome) at $ws.
$client->stopProfile(123);
```

## Ruby

```ruby
require "antybrowser"

client = Antybrowser::Client.new(api_key: "your_key")
result = client.start_profile(123, headless: true)
# Ferrum: browser = Ferrum::Browser.new(url: "http://127.0.0.1:#{result['data']['debugPort']}")
client.stop_profile(123)
```

## Java

```java
var client = new AntyBrowserClient("your_key");
var result = client.startProfile(123, true);
// Selenium: options.setExperimentalOption("debuggerAddress", "127.0.0.1:" + result.getData().getDebugPort());
client.stopProfile(123);
```

## Kotlin

```kotlin
val client = AntybrowserClient("your_key")
val result = client.startProfile(123, headless = true)
// Selenium/Playwright: connect to http://127.0.0.1:${result.data["debugPort"]}
client.stopProfile(123)
```

## Rust

```rust
let client = AntybrowserClient::new("your_key", None);
let result = client.start_profile_headless(123).await?;
// chromiumoxide: Browser::connect(format!("http://127.0.0.1:{}", result.data.debug_port)).await?;
client.stop_profile(123).await?;
```

## Dart / Flutter

```dart
final client = AntybrowserClient(apiKey: 'your_key');
final result = await client.startProfile(123, headless: true);
// webdriver / puppeteer: connect to http://127.0.0.1:${result['data']['debugPort']}
await client.stopProfile(123);
```

## Swift

```swift
let client = AntybrowserClient(apiKey: "your_key")
let result = try await client.startProfile(id: 123, headless: true)
// Connect a CDP client to http://127.0.0.1:\(result.data.debugPort)
try await client.stopProfile(id: 123)
```

## Everything else

Any language can use the REST call directly: `POST /api/profiles/:id/start`
with `{"headless": true}` and the `x-api-key` header. The SDKs that expose a
dedicated method are listed above; the rest expose the generic profile and
request helpers.

## Stopping a headless profile

`browser.close()` only disconnects the automation client. The profile keeps
running (and keeps its session) until you stop it:

```http
POST /api/profiles/:id/stop
x-api-key: <your local API key>
```
