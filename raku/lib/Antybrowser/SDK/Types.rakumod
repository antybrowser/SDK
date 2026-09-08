unit module Antybrowser::SDK::Types;

use JSON::Fast;

# ─── StatusResponse ────────────────────────────────────────────────────────

class StatusResponse is export {
    has Bool $.success;
    has Str $.status;
    has Str $.version;

    method from-json($json) {
        self.bless(
            success => $json<success>.Bool,
            status  => $json<status> // '',
            version => $json<version> // '',
        );
    }

    method to-json() {
        { success => $!success, status => $!status, version => $!version };
    }
}

# ─── StartProfileResponse ──────────────────────────────────────────────────

class StartProfileData is export {
    has Int $.debug-port;
    has %.extra;

    method debug-port() { $!debug-port }

    method AT-KEY($key) {
        $key eq 'debugPort' ?? $!debug-port !! %!extra{$key};
    }
}

class StartProfileResponse is export {
    has Bool $.success;
    has StartProfileData $.data;

    method from-json($json) {
        my $d = $json<data> // {};
        self.bless(
            success => $json<success>.Bool,
            data    => StartProfileData.new(
                debug-port => $d<debugPort>,
                extra      => $d.grep({ .key ne 'debugPort' }).hash,
            ),
        );
    }

    method to-json() {
        my %d = $!data.extra;
        %d<debugPort> = $!data.debug-port if $!data.debug-port.defined;
        { success => $!success, data => %d };
    }
}

# ─── Profile ───────────────────────────────────────────────────────────────

class Profile is export {
    has Int $.id;
    has Str $.name;
    has Str $.directory-name;
    has Int $.group-id;
    has Int $.proxy-id;
    has Str $.browser-type;
    has Str $.browser-version;
    has Str $.os-fingerprint;
    has Str $.screen-resolution;
    has Str $.language;
    has Str $.accept-language;
    has Str $.timezone;
    has Bool $.use-fingerprint;
    has Str $.fingerprint-id;
    has Bool $.restore-session;
    has Bool $.low-bandwidth;
    has Str $.notes;
    has Str $.start-url;
    has Str $.custom-flags;
    has Str $.status;
    has Bool $.needs-sync;
    has Int $.last-pid;
    has Int $.debug-port;
    has Str $.created-at;
    has Str $.updated-at;
    has Str $.last-synced-at;
    has Str $.s3-key;
    has Bool $.trash;
    has Str $.deleted-at;
    has Bool $.hidden;

    method from-json($json) {
        self.bless(
            id                => $json<id>.Int,
            name              => $json<name> // '',
            directory-name    => $json<directoryName>,
            group-id          => $json<groupId>,
            proxy-id          => $json<proxyId>,
            browser-type      => $json<browserType>,
            browser-version   => $json<browserVersion>,
            os-fingerprint    => $json<osFingerprint>,
            screen-resolution => $json<screenResolution>,
            language          => $json<language>,
            accept-language   => $json<acceptLanguage>,
            timezone          => $json<timezone>,
            use-fingerprint   => $json<useFingerprint>,
            fingerprint-id    => $json<fingerprintId>,
            restore-session   => $json<restoreSession>,
            low-bandwidth     => $json<lowBandwidth>,
            notes             => $json<notes>,
            start-url         => $json<startUrl>,
            custom-flags      => $json<customFlags>,
            status            => $json<status>,
            needs-sync        => $json<needsSync>,
            last-pid          => $json<lastPid>,
            debug-port        => $json<debugPort>,
            created-at        => $json<createdAt>,
            updated-at        => $json<updatedAt>,
            last-synced-at    => $json<lastSyncedAt>,
            s3-key            => $json<s3Key>,
            trash             => $json<trash>,
            deleted-at        => $json<deletedAt>,
            hidden            => $json<hidden>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<name> = $!name;
        %h<directoryName> = $_ with $!directory-name;
        %h<groupId> = $_ with $!group-id;
        %h<proxyId> = $_ with $!proxy-id;
        %h<browserType> = $_ with $!browser-type;
        %h<browserVersion> = $_ with $!browser-version;
        %h<osFingerprint> = $_ with $!os-fingerprint;
        %h<screenResolution> = $_ with $!screen-resolution;
        %h<language> = $_ with $!language;
        %h<acceptLanguage> = $_ with $!accept-language;
        %h<timezone> = $_ with $!timezone;
        %h<useFingerprint> = $_ with $!use-fingerprint;
        %h<fingerprintId> = $_ with $!fingerprint-id;
        %h<restoreSession> = $_ with $!restore-session;
        %h<lowBandwidth> = $_ with $!low-bandwidth;
        %h<notes> = $_ with $!notes;
        %h<startUrl> = $_ with $!start-url;
        %h<customFlags> = $_ with $!custom-flags;
        %h<status> = $_ with $!status;
        %h<needsSync> = $_ with $!needs-sync;
        %h<lastPid> = $_ with $!last-pid;
        %h<debugPort> = $_ with $!debug-port;
        %h<createdAt> = $_ with $!created-at;
        %h<updatedAt> = $_ with $!updated-at;
        %h<lastSyncedAt> = $_ with $!last-synced-at;
        %h<s3Key> = $_ with $!s3-key;
        %h<trash> = $_ with $!trash;
        %h<deletedAt> = $_ with $!deleted-at;
        %h<hidden> = $_ with $!hidden;
        %h;
    }
}

# ─── CreateProfileRequest ──────────────────────────────────────────────────

class CreateProfileRequest is export {
    has Str $.name;
    has Str $.directory-name;
    has Int $.group-id;
    has Int $.proxy-id;
    has Str $.browser-type;
    has Str $.browser-version;
    has Str $.os-fingerprint;
    has Str $.screen-resolution;
    has Str $.language;
    has Str $.accept-language;
    has Str $.timezone;
    has Bool $.use-fingerprint;
    has Str $.fingerprint-id;
    has Bool $.restore-session;
    has Bool $.low-bandwidth;
    has Str $.notes;
    has Str $.start-url;
    has Str $.custom-flags;

    method to-json() {
        my %h;
        %h<name> = $!name;
        %h<directoryName> = $_ with $!directory-name;
        %h<groupId> = $_ with $!group-id;
        %h<proxyId> = $_ with $!proxy-id;
        %h<browserType> = $_ with $!browser-type;
        %h<browserVersion> = $_ with $!browser-version;
        %h<osFingerprint> = $_ with $!os-fingerprint;
        %h<screenResolution> = $_ with $!screen-resolution;
        %h<language> = $_ with $!language;
        %h<acceptLanguage> = $_ with $!accept-language;
        %h<timezone> = $_ with $!timezone;
        %h<useFingerprint> = $_ with $!use-fingerprint;
        %h<fingerprintId> = $_ with $!fingerprint-id;
        %h<restoreSession> = $_ with $!restore-session;
        %h<lowBandwidth> = $_ with $!low-bandwidth;
        %h<notes> = $_ with $!notes;
        %h<startUrl> = $_ with $!start-url;
        %h<customFlags> = $_ with $!custom-flags;
        %h;
    }
}

# ─── Proxy ─────────────────────────────────────────────────────────────────

class Proxy is export {
    has Int $.id;
    has Str $.name;
    has Str $.type;
    has Str $.host;
    has Int $.port;
    has Str $.username;
    has Str $.password;
    has Str $.status;
    has Str $.country-code;
    has Str $.city;
    has Str $.region;
    has Str $.isp;
    has Bool $.is-residential;
    has $.check-details;
    has Str $.last-checked;
    has Str $.last-check-at;
    has Str $.ip;
    has Str $.country;
    has Str $.timezone;
    has Str $.asn;
    has Str $.asn-type;
    has Str $.usage-type;
    has Str $.domain;
    has Str $.org;
    has $.privacy;
    has @.hostnames;
    has Str $.error-message;
    has Int $.ip-change-count;
    has Str $.created-at;
    has Str $.updated-at;

    method from-json($json) {
        self.bless(
            id              => $json<id>.Int,
            name            => $json<name>,
            type            => $json<type>,
            host            => $json<host>,
            port            => $json<port>,
            username        => $json<username>,
            password        => $json<password>,
            status          => $json<status>,
            country-code    => $json<countryCode>,
            city            => $json<city>,
            region          => $json<region>,
            isp             => $json<isp>,
            is-residential  => $json<isResidential>,
            check-details   => $json<checkDetails>,
            last-checked    => $json<lastChecked>,
            last-check-at   => $json<lastCheckAt>,
            ip              => $json<ip>,
            country         => $json<country>,
            timezone        => $json<timezone>,
            asn             => $json<asn>,
            asn-type        => $json<asnType>,
            usage-type      => $json<usageType>,
            domain          => $json<domain>,
            org             => $json<org>,
            privacy         => $json<privacy>,
            hostnames       => ($json<hostnames> // []).list,
            error-message   => $json<errorMessage>,
            ip-change-count => $json<ipChangeCount>,
            created-at      => $json<createdAt>,
            updated-at      => $json<updatedAt>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<name> = $_ with $!name;
        %h<type> = $_ with $!type;
        %h<host> = $_ with $!host;
        %h<port> = $_ with $!port;
        %h<username> = $_ with $!username;
        %h<password> = $_ with $!password;
        %h<status> = $_ with $!status;
        %h<countryCode> = $_ with $!country-code;
        %h<city> = $_ with $!city;
        %h<region> = $_ with $!region;
        %h<isp> = $_ with $!isp;
        %h<isResidential> = $_ with $!is-residential;
        %h<checkDetails> = $_ with $!check-details;
        %h<lastChecked> = $_ with $!last-checked;
        %h<lastCheckAt> = $_ with $!last-check-at;
        %h<ip> = $_ with $!ip;
        %h<country> = $_ with $!country;
        %h<timezone> = $_ with $!timezone;
        %h<asn> = $_ with $!asn;
        %h<asnType> = $_ with $!asn-type;
        %h<usageType> = $_ with $!usage-type;
        %h<domain> = $_ with $!domain;
        %h<org> = $_ with $!org;
        %h<privacy> = $_ with $!privacy;
        %h<hostnames> = @!hostnames if @!hostnames.elems;
        %h<errorMessage> = $_ with $!error-message;
        %h<ipChangeCount> = $_ with $!ip-change-count;
        %h<createdAt> = $_ with $!created-at;
        %h<updatedAt> = $_ with $!updated-at;
        %h;
    }
}

# ─── CreateProxyRequest ────────────────────────────────────────────────────

class CreateProxyRequest is export {
    has Str $.name;
    has Str $.host;
    has Int $.port;
    has Str $.type where 'http' | 'socks4' | 'socks5';
    has Str $.username;
    has Str $.password;

    method to-json() {
        my %h;
        %h<name> = $!name;
        %h<host> = $!host;
        %h<port> = $!port;
        %h<type> = $!type;
        %h<username> = $_ with $!username;
        %h<password> = $_ with $!password;
        %h;
    }
}

# ─── ProxyCheckResult ──────────────────────────────────────────────────────

class ProxyCheckResult is export {
    has Bool $.success;
    has $.details;
    has Str $.error-message;

    method from-json($json) {
        self.bless(
            success      => $json<success>.Bool,
            details      => $json<details>,
            error-message => $json<errorMessage>,
        );
    }

    method to-json() {
        my %h;
        %h<success> = $!success;
        %h<details> = $_ with $!details;
        %h<errorMessage> = $_ with $!error-message;
        %h;
    }
}

# ─── Group ─────────────────────────────────────────────────────────────────

class Group is export {
    has Int $.id;
    has Str $.name;
    has Str $.description;
    has Str $.color;
    has Int $.display-order;
    has Str $.created-at;
    has Str $.updated-at;

    method from-json($json) {
        self.bless(
            id            => $json<id>.Int,
            name          => $json<name> // '',
            description   => $json<description>,
            color         => $json<color>,
            display-order => $json<displayOrder>,
            created-at    => $json<createdAt>,
            updated-at    => $json<updatedAt>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<name> = $!name;
        %h<description> = $_ with $!description;
        %h<color> = $_ with $!color;
        %h<displayOrder> = $_ with $!display-order;
        %h<createdAt> = $_ with $!created-at;
        %h<updatedAt> = $_ with $!updated-at;
        %h;
    }
}

# ─── CreateGroupRequest ────────────────────────────────────────────────────

class CreateGroupRequest is export {
    has Str $.name;
    has Str $.description;
    has Str $.color;

    method to-json() {
        my %h;
        %h<name> = $!name;
        %h<description> = $_ with $!description;
        %h<color> = $_ with $!color;
        %h;
    }
}

# ─── Extension ─────────────────────────────────────────────────────────────

class Extension is export {
    has Int $.id;
    has Str $.name;
    has Str $.path;
    has Str $.description;
    has Str $.icon;
    has Str $.icon-data-url;
    has Str $.created-at;

    method from-json($json) {
        self.bless(
            id            => $json<id>.Int,
            name          => $json<name> // '',
            path          => $json<path>,
            description   => $json<description>,
            icon          => $json<icon>,
            icon-data-url => $json<iconDataUrl>,
            created-at    => $json<createdAt>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<name> = $!name;
        %h<path> = $_ with $!path;
        %h<description> = $_ with $!description;
        %h<icon> = $_ with $!icon;
        %h<iconDataUrl> = $_ with $!icon-data-url;
        %h<createdAt> = $_ with $!created-at;
        %h;
    }
}

# ─── Automation ────────────────────────────────────────────────────────────

class Automation is export {
    has Int $.id;
    has Str $.name;
    has Str $.description;
    has $.detected-variables;
    has $.custom-variables;
    has Str $.last-run;
    has Str $.status;
    has Str $.created-at;
    has Str $.updated-at;

    method from-json($json) {
        self.bless(
            id                 => $json<id>.Int,
            name               => $json<name> // '',
            description        => $json<description>,
            detected-variables => $json<detectedVariables>,
            custom-variables   => $json<customVariables>,
            last-run           => $json<lastRun>,
            status             => $json<status>,
            created-at         => $json<createdAt>,
            updated-at         => $json<updatedAt>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<name> = $!name;
        %h<description> = $_ with $!description;
        %h<detectedVariables> = $_ with $!detected-variables;
        %h<customVariables> = $_ with $!custom-variables;
        %h<lastRun> = $_ with $!last-run;
        %h<status> = $_ with $!status;
        %h<createdAt> = $_ with $!created-at;
        %h<updatedAt> = $_ with $!updated-at;
        %h;
    }
}

# ─── RunAutomationRequest ──────────────────────────────────────────────────

class RunAutomationRequest is export {
    has Int $.profile-id;
    has Bool $.delete-cookies;
    has %.variables;

    method to-json() {
        my %h;
        %h<profileId> = $!profile-id;
        %h<deleteCookies> = $_ with $!delete-cookies;
        %h<variables> = %!variables if %!variables.elems;
        %h;
    }
}

# ─── RunAutomationResult ───────────────────────────────────────────────────

class RunAutomationResult is export {
    has Bool $.success;
    has Str $.message;
    has %.variables;

    method from-json($json) {
        self.bless(
            success   => $json<success>.Bool,
            message   => $json<message> // '',
            variables => $json<variables> // {},
        );
    }

    method to-json() {
        my %h;
        %h<success> = $!success;
        %h<message> = $!message;
        %h<variables> = %!variables if %!variables.elems;
        %h;
    }
}

# ─── Settings ──────────────────────────────────────────────────────────────

class Settings is export {
    has Int $.id;
    has Str $.chrome-path;
    has Str $.license-key;
    has Str $.default-browser-type;
    has Str $.default-os-fingerprint;
    has Str $.default-screen-resolution;
    has Str $.default-language;
    has Str $.default-accept-language;
    has Str $.default-timezone;
    has Bool $.default-low-bandwidth;
    has Bool $.api-enabled;
    has Str $.api-key;
    has Str $.language;
    has Str $.on-close-action where 'minimize' | 'exit' | Any;
    has Bool $.launch-on-startup;
    has Bool $.launch-minimized-on-startup;
    has Str $.ip-quality-score-api-key;
    has Bool $.use-ip-quality-score;
    has Str $.browser-flags;
    has Str $.font-size-scale;

    method from-json($json) {
        self.bless(
            id                          => $json<id>,
            chrome-path                 => $json<chromePath>,
            license-key                 => $json<licenseKey>,
            default-browser-type        => $json<defaultBrowserType>,
            default-os-fingerprint      => $json<defaultOsFingerprint>,
            default-screen-resolution   => $json<defaultScreenResolution>,
            default-language            => $json<defaultLanguage>,
            default-accept-language     => $json<defaultAcceptLanguage>,
            default-timezone            => $json<defaultTimezone>,
            default-low-bandwidth       => $json<defaultLowBandwidth>,
            api-enabled                 => $json<apiEnabled>,
            api-key                     => $json<apiKey>,
            language                    => $json<language>,
            on-close-action             => $json<onCloseAction>,
            launch-on-startup           => $json<launchOnStartup>,
            launch-minimized-on-startup => $json<launchMinimizedOnStartup>,
            ip-quality-score-api-key    => $json<ipQualityScoreApiKey>,
            use-ip-quality-score        => $json<useIpQualityScore>,
            browser-flags               => $json<browserFlags>,
            font-size-scale             => $json<fontSizeScale>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $_ with $!id;
        %h<chromePath> = $_ with $!chrome-path;
        %h<licenseKey> = $_ with $!license-key;
        %h<defaultBrowserType> = $_ with $!default-browser-type;
        %h<defaultOsFingerprint> = $_ with $!default-os-fingerprint;
        %h<defaultScreenResolution> = $_ with $!default-screen-resolution;
        %h<defaultLanguage> = $_ with $!default-language;
        %h<defaultAcceptLanguage> = $_ with $!default-accept-language;
        %h<defaultTimezone> = $_ with $!default-timezone;
        %h<defaultLowBandwidth> = $_ with $!default-low-bandwidth;
        %h<apiEnabled> = $_ with $!api-enabled;
        %h<apiKey> = $_ with $!api-key;
        %h<language> = $_ with $!language;
        %h<onCloseAction> = $_ with $!on-close-action;
        %h<launchOnStartup> = $_ with $!launch-on-startup;
        %h<launchMinimizedOnStartup> = $_ with $!launch-minimized-on-startup;
        %h<ipQualityScoreApiKey> = $_ with $!ip-quality-score-api-key;
        %h<useIpQualityScore> = $_ with $!use-ip-quality-score;
        %h<browserFlags> = $_ with $!browser-flags;
        %h<fontSizeScale> = $_ with $!font-size-scale;
        %h;
    }
}

# ─── SyncStatus ────────────────────────────────────────────────────────────

class SyncStatus is export {
    has @.active;
    has @.active-extensions;
    has Int $.total;
    has Int $.completed;
    has %.errors;
    has %.progress;
    has Bool $.is-syncing;

    method from-json($json) {
        self.bless(
            active            => ($json<active> // []).list,
            active-extensions => ($json<activeExtensions> // []).list,
            total             => ($json<total> // 0).Int,
            completed         => ($json<completed> // 0).Int,
            errors            => $json<errors> // {},
            progress          => $json<progress> // {},
            is-syncing        => $json<isSyncing>.Bool,
        );
    }

    method to-json() {
        {
            active            => @!active,
            activeExtensions  => @!active-extensions,
            total             => $!total,
            completed         => $!completed,
            errors            => %!errors,
            progress          => %!progress,
            isSyncing         => $!is-syncing,
        };
    }
}

# ─── ApiResponse ───────────────────────────────────────────────────────────

class ApiResponse is export {
    has Bool $.success;
    has Str $.message;
    has $.data;

    method from-json($json) {
        self.bless(
            success => $json<success>,
            message => $json<message>,
            data    => $json<data>,
        );
    }

    method to-json() {
        my %h;
        %h<success> = $_ with $!success;
        %h<message> = $_ with $!message;
        %h<data> = $_ with $!data;
        %h;
    }
}

# ─── DuplicateProfileRequest ───────────────────────────────────────────────

class DuplicateProfileRequest is export {
    has Str $.name;
    has Str $.directory-name;

    method to-json() {
        my %h;
        %h<name> = $_ with $!name;
        %h<directoryName> = $_ with $!directory-name;
        %h;
    }
}
