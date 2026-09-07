# Publishing Antybrowser SDK

Complete checklist for publishing to all 8 registries.

---

## First-Time Setup

### 1. npm (TypeScript / JavaScript)

```bash
# Create npm account at https://www.npmjs.com
# Create org: https://www.npmjs.com/orgs/create

# Login
npm login --scope=@antybrowser

# Create granular access token at https://www.npmjs.com/settings/tokens
# Select: Granular Access Token → @antybrowser/sdk → Read and Write
# Under "2FA": select "Require 2FA or automation bypass"
```

**GitHub Secret:** `NPM_TOKEN`

### 2. PyPI (Python)

```bash
# Create account at https://pypi.org
# Create API token at https://pypi.org/manage/account/token/
# Scope: "Entire account" or project-scoped

pip install twine build
```

**GitHub Secret:** `PYPI_TOKEN`

### 3. NuGet (.NET)

```bash
# Create account at https://www.nuget.org
# Create API key at https://www.nuget.org/account/apikeys
```

**GitHub Secret:** `NUGET_API_KEY`

### 4. RubyGems (Ruby)

```bash
# Create account at https://rubygems.org
# Get API key: gem signin
# Or create at https://rubygems.org/profile/api_keys
```

**GitHub Secret:** `RUBYGEMS_API_KEY`

### 5. Maven Central (Java)

```bash
# 1. Create Sonatype JIRA account: https://issues.sonatype.org
# 2. Claim groupId: create JIRA ticket for com.antybrowser
# 3. Wait for approval (1-3 days)
# 4. Generate GPG key: gpg --gen-key
# 5. Publish public key: gpg --keyserver keyserver.ubuntu.com --send-keys <KEY_ID>
```

**GitHub Secrets:** `MAVEN_USERNAME`, `MAVEN_PASSWORD`, `MAVEN_GPG_PRIVATE_KEY`, `MAVEN_GPG_PASSPHRASE`

### 6. Go Modules

No token needed — versioned via git tags.

### 8. CPAN / PAUSE (Perl)

```bash
# Create PAUSE account at https://pause.perl.org
# Generate upload token at https://pause.perl.org/pause/authenquery?ACTION=new_token
# The token is shown only once — store it in your password manager
```

**GitHub Secret:** `PAUSE_TOKEN`

### 7. Packagist (PHP)

No token needed — auto-indexes from GitHub tags.

```bash
# Submit repo at https://packagist.org/packages/submit
# URL: https://github.com/antybrowser/SDK
# Enable auto-update webhook
```

---

## Version Bumps

All SDKs share the same version. Update all files, then tag:

```bash
# 1. Update version in all package files:
#    - npm/package.json → "version"
#    - py/pyproject.toml → "version"
#    - py/antybrowser/__init__.py → "__version__"
#    - ruby/lib/antybrowser/version.rb → VERSION
#    - java/pom.xml → <version>
#    - nuget/Antybrowser.SDK/Antybrowser.SDK.csproj → <Version>
#    - php/composer.json → "version" (optional, Packagist uses tags)
#    - perl/lib/Antybrowser.pm → "$VERSION" (VERSION_FROM)

# 2. Commit
git add -A
git commit -m "release: v1.0.2"

# 3. Tag (triggers CI/CD)
git tag sdk-npm/v1.0.2
git tag sdk-py/v1.0.2
git tag sdk-nuget/v1.0.2
git tag sdk-ruby/v1.0.2
git tag sdk-java/v1.0.2
git tag sdk-go/v1.0.2
git tag sdk-php/v1.0.2
git tag sdk-perl/v1.0.2

# 4. Push
git push origin main --tags
```

---

## CI/CD Tag Convention

Each tag triggers the corresponding GitHub Action:

| Tag Pattern | Registry | Workflow |
|-------------|----------|----------|
| `sdk-npm/v*` | npm | `.github/workflows/publish-npm.yml` |
| `sdk-py/v*` | PyPI | `.github/workflows/publish-pypi.yml` |
| `sdk-nuget/v*` | NuGet | `.github/workflows/publish-nuget.yml` |
| `sdk-ruby/v*` | RubyGems | `.github/workflows/publish-ruby.yml` |
| `sdk-java/v*` | Maven Central | `.github/workflows/publish-java.yml` |
| `sdk-go/v*` | Go Modules | _(auto — no workflow needed)_ |
| `sdk-php/v*` | Packagist | _(auto — no workflow needed)_ |
| `sdk-perl/v*` | CPAN / PAUSE | `.github/workflows/publish-perl.yml` |

---

## Manual Publishing (if needed)

### npm
```bash
cd npm && npm run build && npm publish --access public
```

### PyPI
```bash
cd py && python -m build && twine upload dist/*
```

### NuGet
```bash
cd nuget/Antybrowser.SDK && dotnet pack -c Release && dotnet nuget push bin/Release/*.nupkg
```

### RubyGems
```bash
cd ruby && gem build antybrowser.gemspec && gem push antybrowser-*.gem
```

### Maven Central
```bash
cd java && mvn clean deploy -P release
```

### CPAN / PAUSE
```bash
cd perl && perl Makefile.PL && make manifest && make dist
```
Upload `perl/Antybrowser-<version>.tar.gz` via the CI workflow
(`git push origin main --tags` with an `sdk-perl/v*` tag) or the PAUSE
upload form at pause.perl.org.

---

## Verification After Publish

```bash
# npm
npm info @antybrowser/sdk

# PyPI
pip install antybrowser --dry-run

# NuGet
dotnet package search Antybrowser.SDK

# RubyGems
gem search antybrowser --remote

# Maven
# https://search.maven.org/search?q=g:com.antybrowser

# Go
go list -m github.com/antybrowser/SDK/go@latest

# Packagist
# https://packagist.org/packages/antybrowser/sdk

# CPAN
cpan Antybrowser::SDK
# https://metacpan.org/pod/Antybrowser::SDK
```
