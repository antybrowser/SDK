# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "antybrowser"
  spec.version       = AntyBrowser::VERSION
  spec.authors       = ["AntyBrowser Team"]
  spec.email         = ["support@antybrowser.com"]

  spec.summary       = "Official AntyBrowser SDK — Ruby client for the Local API"
  spec.description   = "Manage browser profiles, proxies, automations, groups, and extensions via the AntyBrowser Local API."
  spec.homepage      = "https://antybrowser.com"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/AntyBrowser/AntyBrowser.SDK"
  spec.metadata["changelog_uri"]   = "https://github.com/AntyBrowser/AntyBrowser.SDK/blob/main/ruby/CHANGELOG.md"

  spec.files = Dir["lib/**/*.rb"] + ["antybrowser.gemspec", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
