unit module Antybrowser::SDK::Types;

use JSON::Fast;

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
    has Int $.user-id;
    has Str $.user-guid;
    has Str $.name;
    has Str $.directory-name;
    has Int $.group-id;
    has Int $.proxy-id;
    has Str $.browser-type;
    has Str $.browser-version;
    has Str $.os-fingerprint;
    has Str $.screen-resolution;
    has Bool $.screen-maximizable;
    has Str $.language;
    has Str $.accept-language;
    has Str $.timezone;
    has Bool $.use-fingerprint;
    # Server-owned noise seed. Read-only — never sent on create/update.
    has Str $.fingerprint-id;
    has Str $.platform-version;
    has Str $.brand-version;
    has Str $.engine-version;
    has Str $.gpu-vendor;
    has Str $.gpu-model;
    has $.hardware-concurrency;
    has $.device-memory;
    has $.device-scale-factor;
    has Str $.mobile-model;
    has $.mobile-version;
    has Str $.ch-platform;
    has Str $.ch-platform-version;
    has Str $.ch-arch;
    has Str $.ch-bitness;
    has Str $.ch-model;
    has $.ch-mobile;
    has Str $.disable-spoofing;
    has Str $.location-mode;
    has Str $.location-latitude;
    has Str $.location-longitude;
    has Str $.location-accuracy;
    has Str $.user-agent;
    has Bool $.restore-session;
    has Bool $.low-bandwidth;
    has Str $.notes;
    has Str $.start-url;
    has Str $.custom-flags;
    has Str $.status;
    has Str $.status-machine-id;
    has Str $.status-heartbeat-at;
    has Bool $.needs-sync;
    has Int $.last-pid;
    has Int $.debug-port;
    has Str $.tabs-snapshot;
    has Str $.created-at;
    has Str $.updated-at;
    has Str $.last-synced-at;
    has Str $.s3-key;
    has Bool $.trash;
    has Str $.deleted-at;
    has Bool $.hidden;

    method from-json($json) {
        self.bless(
            id                    => $json<id>.Int,
            user-id               => $json<userId>,
            user-guid             => $json<userGuid>,
            name                  => $json<name> // '',
            directory-name        => $json<directoryName>,
            group-id              => $json<groupId>,
            proxy-id              => $json<proxyId>,
            browser-type          => $json<browserType>,
            browser-version       => $json<browserVersion>,
            os-fingerprint        => $json<osFingerprint>,
            screen-resolution     => $json<screenResolution>,
            screen-maximizable    => $json<screenMaximizable>,
            language              => $json<language>,
            accept-language       => $json<acceptLanguage>,
            timezone              => $json<timezone>,
            use-fingerprint       => $json<useFingerprint>,
            fingerprint-id        => $json<fingerprintId>,
            platform-version      => $json<platformVersion>,
            brand-version         => $json<brandVersion>,
            engine-version        => $json<engineVersion>,
            gpu-vendor            => $json<gpuVendor>,
            gpu-model             => $json<gpuModel>,
            hardware-concurrency  => $json<hardwareConcurrency>,
            device-memory         => $json<deviceMemory>,
            device-scale-factor   => $json<deviceScaleFactor>,
            mobile-model          => $json<mobileModel>,
            mobile-version        => $json<mobileVersion>,
            ch-platform           => $json<chPlatform>,
            ch-platform-version   => $json<chPlatformVersion>,
            ch-arch               => $json<chArch>,
            ch-bitness            => $json<chBitness>,
            ch-model              => $json<chModel>,
            ch-mobile             => $json<chMobile>,
            disable-spoofing      => $json<disableSpoofing>,
            location-mode         => $json<locationMode>,
            location-latitude     => $json<locationLatitude>,
            location-longitude    => $json<locationLongitude>,
            location-accuracy     => $json<locationAccuracy>,
            user-agent            => $json<userAgent>,
            restore-session       => $json<restoreSession>,
            low-bandwidth         => $json<lowBandwidth>,
            notes                 => $json<notes>,
            start-url             => $json<startUrl>,
            custom-flags          => $json<customFlags>,
            status                => $json<status>,
            status-machine-id     => $json<statusMachineId>,
            status-heartbeat-at   => $json<statusHeartbeatAt>,
            needs-sync            => $json<needsSync>,
            last-pid              => $json<lastPid>,
            debug-port            => $json<debugPort>,
            tabs-snapshot         => $json<tabsSnapshot>,
            created-at            => $json<createdAt>,
            updated-at            => $json<updatedAt>,
            last-synced-at        => $json<lastSyncedAt>,
            s3-key                => $json<s3Key>,
            trash                 => $json<trash>,
            deleted-at            => $json<deletedAt>,
            hidden                => $json<hidden>,
        );
    }

    method to-json() {
        my %h;
        %h<id> = $!id;
        %h<userId> = $_ with $!user-id;
        %h<userGuid> = $_ with $!user-guid;
        %h<name> = $!name;
        %h<directoryName> = $_ with $!directory-name;
        %h<groupId> = $_ with $!group-id;
        %h<proxyId> = $_ with $!proxy-id;
        %h<browserType> = $_ with $!browser-type;
        %h<browserVersion> = $_ with $!browser-version;
        %h<osFingerprint> = $_ with $!os-fingerprint;
        %h<screenResolution> = $_ with $!screen-resolution;
        %h<screenMaximizable> = $_ with $!screen-maximizable;
        %h<language> = $_ with $!language;
        %h<acceptLanguage> = $_ with $!accept-language;
        %h<timezone> = $_ with $!timezone;
        %h<useFingerprint> = $_ with $!use-fingerprint;
        %h<fingerprintId> = $_ with $!fingerprint-id;
        %h<platformVersion> = $_ with $!platform-version;
        %h<brandVersion> = $_ with $!brand-version;
        %h<engineVersion> = $_ with $!engine-version;
        %h<gpuVendor> = $_ with $!gpu-vendor;
        %h<gpuModel> = $_ with $!gpu-model;
        %h<hardwareConcurrency> = $_ with $!hardware-concurrency;
        %h<deviceMemory> = $_ with $!device-memory;
        %h<deviceScaleFactor> = $_ with $!device-scale-factor;
        %h<mobileModel> = $_ with $!mobile-model;
        %h<mobileVersion> = $_ with $!mobile-version;
        %h<chPlatform> = $_ with $!ch-platform;
        %h<chPlatformVersion> = $_ with $!ch-platform-version;
        %h<chArch> = $_ with $!ch-arch;
        %h<chBitness> = $_ with $!ch-bitness;
        %h<chModel> = $_ with $!ch-model;
        %h<chMobile> = $_ with $!ch-mobile;
        %h<disableSpoofing> = $_ with $!disable-spoofing;
        %h<locationMode> = $_ with $!location-mode;
        %h<locationLatitude> = $_ with $!location-latitude;
        %h<locationLongitude> = $_ with $!location-longitude;
        %h<locationAccuracy> = $_ with $!location-accuracy;
        %h<userAgent> = $_ with $!user-agent;
        %h<restoreSession> = $_ with $!restore-session;
        %h<lowBandwidth> = $_ with $!low-bandwidth;
        %h<notes> = $_ with $!notes;
        %h<startUrl> = $_ with $!start-url;
        %h<customFlags> = $_ with $!custom-flags;
        %h<status> = $_ with $!status;
        %h<statusMachineId> = $_ with $!status-machine-id;
        %h<statusHeartbeatAt> = $_ with $!status-heartbeat-at;
        %h<needsSync> = $_ with $!needs-sync;
        %h<lastPid> = $_ with $!last-pid;
        %h<debugPort> = $_ with $!debug-port;
        %h<tabsSnapshot> = $_ with $!tabs-snapshot;
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
    # Brand. Chromium is not a brand — it folds to Chrome.
    has Str $.browser-type;
    has Str $.browser-version;
    has Str $.os-fingerprint;
    has Str $.screen-resolution;
    has Bool $.screen-maximizable;
    has Str $.language;
    has Str $.accept-language;
    has Str $.timezone;
    has Bool $.use-fingerprint;
    has Str $.platform-version;
    has Str $.brand-version;
    has Str $.engine-version;
    has Str $.gpu-vendor;
    has Str $.gpu-model;
    has $.hardware-concurrency;
    has $.device-memory;
    has $.device-scale-factor;
    has Str $.mobile-model;
    has $.mobile-version;
    has Str $.ch-platform;
    has Str $.ch-platform-version;
    has Str $.ch-arch;
    has Str $.ch-bitness;
    has Str $.ch-model;
    has $.ch-mobile;
    # Comma list of spoof features to turn OFF.
    has Str $.disable-spoofing;
    # One of "", "proxy", "manual".
    has Str $.location-mode;
    has Str $.location-latitude;
    has Str $.location-longitude;
    has Str $.location-accuracy;
    has Bool $.restore-session;
    has Bool $.low-bandwidth;
    has Str $.notes;
    has Str $.start-url;
    has Str $.custom-flags;
    has Str $.status;
    has Bool $.hidden;

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
        %h<screenMaximizable> = $_ with $!screen-maximizable;
        %h<language> = $_ with $!language;
        %h<acceptLanguage> = $_ with $!accept-language;
        %h<timezone> = $_ with $!timezone;
        %h<useFingerprint> = $_ with $!use-fingerprint;
        %h<platformVersion> = $_ with $!platform-version;
        %h<brandVersion> = $_ with $!brand-version;
        %h<engineVersion> = $_ with $!engine-version;
        %h<gpuVendor> = $_ with $!gpu-vendor;
        %h<gpuModel> = $_ with $!gpu-model;
        %h<hardwareConcurrency> = $_ with $!hardware-concurrency;
        %h<deviceMemory> = $_ with $!device-memory;
        %h<deviceScaleFactor> = $_ with $!device-scale-factor;
        %h<mobileModel> = $_ with $!mobile-model;
        %h<mobileVersion> = $_ with $!mobile-version;
        %h<chPlatform> = $_ with $!ch-platform;
        %h<chPlatformVersion> = $_ with $!ch-platform-version;
        %h<chArch> = $_ with $!ch-arch;
        %h<chBitness> = $_ with $!ch-bitness;
        %h<chModel> = $_ with $!ch-model;
        %h<chMobile> = $_ with $!ch-mobile;
        %h<disableSpoofing> = $_ with $!disable-spoofing;
        %h<locationMode> = $_ with $!location-mode;
        %h<locationLatitude> = $_ with $!location-latitude;
        %h<locationLongitude> = $_ with $!location-longitude;
        %h<locationAccuracy> = $_ with $!location-accuracy;
        %h<restoreSession> = $_ with $!restore-session;
        %h<lowBandwidth> = $_ with $!low-bandwidth;
        %h<notes> = $_ with $!notes;
        %h<startUrl> = $_ with $!start-url;
        %h<customFlags> = $_ with $!custom-flags;
        %h<status> = $_ with $!status;
        %h<hidden> = $_ with $!hidden;
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
