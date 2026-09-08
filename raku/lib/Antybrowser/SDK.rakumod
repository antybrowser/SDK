unit module Antybrowser::SDK;

use Antybrowser::SDK::Error;
use Antybrowser::SDK::Types;
use Antybrowser::SDK::Client;

our class AntybrowserClient is Antybrowser::SDK::Client::AntybrowserClient {}

our class AntybrowserError is Antybrowser::SDK::Error::AntybrowserError {}

our class StatusResponse is Antybrowser::SDK::Types::StatusResponse {}
our class StartProfileData is Antybrowser::SDK::Types::StartProfileData {}
our class StartProfileResponse is Antybrowser::SDK::Types::StartProfileResponse {}
our class Profile is Antybrowser::SDK::Types::Profile {}
our class CreateProfileRequest is Antybrowser::SDK::Types::CreateProfileRequest {}
our class Proxy is Antybrowser::SDK::Types::Proxy {}
our class CreateProxyRequest is Antybrowser::SDK::Types::CreateProxyRequest {}
our class ProxyCheckResult is Antybrowser::SDK::Types::ProxyCheckResult {}
our class Group is Antybrowser::SDK::Types::Group {}
our class CreateGroupRequest is Antybrowser::SDK::Types::CreateGroupRequest {}
our class Extension is Antybrowser::SDK::Types::Extension {}
our class Automation is Antybrowser::SDK::Types::Automation {}
our class RunAutomationRequest is Antybrowser::SDK::Types::RunAutomationRequest {}
our class RunAutomationResult is Antybrowser::SDK::Types::RunAutomationResult {}
our class Settings is Antybrowser::SDK::Types::Settings {}
our class SyncStatus is Antybrowser::SDK::Types::SyncStatus {}
our class ApiResponse is Antybrowser::SDK::Types::ApiResponse {}
our class DuplicateProfileRequest is Antybrowser::SDK::Types::DuplicateProfileRequest {}
