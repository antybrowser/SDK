# Publishing to Packagist (Composer)

## Prerequisites

1. **GitHub repo**: `github.com/AntyBrowser/AntyBrowser.SDK`
2. **Packagist account**: https://packagist.org/register/
3. **Composer**: installed locally

## Steps

1. Push the `sdk/php/` directory to GitHub.

2. Go to https://packagist.org/packages/submit and enter:
   - **Repository URL**: `https://github.com/AntyBrowser/AntyBrowser.SDK`
   - **Driver**: GitHub

3. Click **Check** → **Submit**.

4. Enable **Auto-Update** so Packagist pulls new tags automatically.

## Version Bumps

```bash
# Edit composer.json version if needed, then tag:
git tag sdk/php/v1.0.1
git push origin sdk/php/v1.0.1
```

Packagist auto-updates from GitHub tags.

## Users install with

```bash
composer require antybrowser/sdk
```

## Verify

```bash
composer show antybrowser/sdk
```
