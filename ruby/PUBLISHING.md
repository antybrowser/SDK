# Publishing to RubyGems

## Prerequisites

1. **RubyGems account**: https://rubygems.org/signup
2. **API key**: `gem signin`
3. **Rake**: installed with Ruby

## Build

```bash
cd sdk/ruby
gem build antybrowser.gemspec
```

## Publish

```bash
gem push antybrowser-1.0.1.gem
```

## Version Bumps

1. Edit `lib/antybrowser/version.rb`
2. Rebuild and publish:
   ```bash
   gem build antybrowser.gemspec
   gem push antybrowser-1.0.2.gem
   ```

## Verify

```bash
gem install antybrowser
ruby -e "require 'antybrowser'; puts AntyBrowser::VERSION"
```
