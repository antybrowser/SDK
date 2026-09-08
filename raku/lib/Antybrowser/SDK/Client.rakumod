unit module Antybrowser::SDK::Client;

use HTTP::UserAgent;
use HTTP::Status;
use JSON::Fast;
use Antybrowser::SDK::Error;
use Antybrowser::SDK::Types;

class AntybrowserClient is export {
    has Str $.api-key;
    has Str $.base-url;
    has Int $.timeout;
    has HTTP::UserAgent $!ua;

    method new(:$api-key!, Int :$port = 5173, Str :$base-url = '', Int :$timeout = 30000) {
        my $url = $base-url ne '' ?? $base-url !! "http://127.0.0.1:$port";
        my $ua = HTTP::UserAgent.new(
            :timeout($timeout / 1000),
            :user-agent('AntybrowserSDK-Raku/1.0.3'),
        );
        self.bless(api-key => $api-key, base-url => $url, timeout => $timeout, ua => $ua);
    }

    # ─── System ────────────────────────────────────────────────────────────

    method get-status() {
        my $data = self!get('/api/status');
        StatusResponse.from-json($data);
    }

    method get-settings() {
        my $data = self!get('/api/settings');
        Settings.from-json($data);
    }

    method get-sync-status() {
        my $data = self!get('/api/sync/status');
        SyncStatus.from-json($data);
    }

    method refresh-sync(Int :$profile-id) {
        my %body = $profile-id.defined ?? { profileId => $profile-id } !! {};
        self!post('/api/sync/refresh', %body);
    }

    # ─── Profiles ──────────────────────────────────────────────────────────

    method get-profiles() {
        my $data = self!get('/api/profiles');
        $data.list.map({ Profile.from-json($_) }).list;
    }

    method create-profile(CreateProfileRequest $request) {
        my $data = self!post('/api/profiles', $request.to-json);
        Profile.from-json($data);
    }

    method update-profile(Int $id, CreateProfileRequest $request) {
        my $data = self!put("/api/profiles/$id", $request.to-json);
        Profile.from-json($data);
    }

    method delete-profile(Int $id) {
        self!delete("/api/profiles/$id");
    }

    method start-profile(Int $id) {
        my $data = self!post("/api/profiles/$id/start");
        StartProfileResponse.from-json($data);
    }

    method stop-profile(Int $id) {
        self!post("/api/profiles/$id/stop");
    }

    method duplicate-profile(Int $id, DuplicateProfileRequest :$options) {
        my %body = $options.defined ?? $options.to-json !! {};
        my $data = self!post("/api/profiles/$id/duplicate", %body);
        Profile.from-json($data);
    }

    # ─── Automations ───────────────────────────────────────────────────────

    method get-automations() {
        my $data = self!get('/api/automations');
        $data.list.map({ Automation.from-json($_) }).list;
    }

    method run-automation(Int $id, RunAutomationRequest $request) {
        my $data = self!post("/api/automations/$id/run", $request.to-json);
        RunAutomationResult.from-json($data);
    }

    # ─── Groups ────────────────────────────────────────────────────────────

    method get-groups() {
        my $data = self!get('/api/groups');
        $data.list.map({ Group.from-json($_) }).list;
    }

    method create-group(CreateGroupRequest $request) {
        my $data = self!post('/api/groups', $request.to-json);
        Group.from-json($data);
    }

    method update-group(Int $id, CreateGroupRequest $request) {
        my $data = self!put("/api/groups/$id", $request.to-json);
        Group.from-json($data);
    }

    method delete-group(Int $id) {
        self!delete("/api/groups/$id");
    }

    # ─── Proxies ───────────────────────────────────────────────────────────

    method get-proxies() {
        my $data = self!get('/api/proxies');
        $data.list.map({ Proxy.from-json($_) }).list;
    }

    method create-proxy(CreateProxyRequest $request) {
        my $data = self!post('/api/proxies', $request.to-json);
        Proxy.from-json($data);
    }

    method check-proxy(Str :$host!, Int :$port!, Str :$username, Str :$password, Str :$type) {
        my %body = :$host, :$port;
        %body<username> = $username if $username.defined;
        %body<password> = $password if $password.defined;
        %body<type> = $type if $type.defined;
        my $data = self!post('/api/proxies/check', %body);
        ProxyCheckResult.from-json($data);
    }

    method check-proxies-bulk(@proxies) {
        my $data = self!post('/api/proxies/check-bulk', { proxies => @proxies });
        ($data<results> // $data).list.map({ ProxyCheckResult.from-json($_) }).list;
    }

    method delete-proxy(Int $id) {
        self!delete("/api/proxies/$id");
    }

    # ─── Extensions ────────────────────────────────────────────────────────

    method get-extensions() {
        my $data = self!get('/api/extensions');
        $data.list.map({ Extension.from-json($_) }).list;
    }

    method delete-extension(Int $id) {
        self!delete("/api/extensions/$id");
    }

    method get-profile-extensions(Int $profile-id, Bool :$details = False) {
        my $data = self!get("/api/profiles/$profile-id/extensions?details={$details.lc}");
        $data.list.map({ Extension.from-json($_) }).list;
    }

    method set-profile-extensions(Int $profile-id, @extension-ids) {
        self!post("/api/profiles/$profile-id/extensions", { extensionIds => @extension-ids });
    }

    # ─── HTTP Helpers ──────────────────────────────────────────────────────

    method !get(Str $path) {
        my $url = "$!base-url$path";
        my $req = HTTP::Request.new(:GET($url));
        $req.header-field('x-api-key', $!api-key);
        $req.header-field('Content-Type', 'application/json');

        my $resp;
        try {
            $resp = $!ua.request($req);
            CATCH {
                default {
                    AntybrowserError.new(
                        message => "Failed to connect to Antybrowser Local API at $!base-url. Is Antybrowser running?\n{$_.message}",
                    ).throw;
                }
            }
        }

        self!handle-response($resp);
    }

    method !post(Str $path, %body = {}) {
        my $url = "$!base-url$path";
        my $req = HTTP::Request.new(:POST($url));
        $req.header-field('x-api-key', $!api-key);
        $req.header-field('Content-Type', 'application/json');
        $req.content = to-json(%body) if %body.elems;

        my $resp;
        try {
            $resp = $!ua.request($req);
            CATCH {
                default {
                    AntybrowserError.new(
                        message => "Failed to connect to Antybrowser Local API at $!base-url. Is Antybrowser running?\n{$_.message}",
                    ).throw;
                }
            }
        }

        self!handle-response($resp);
    }

    method !put(Str $path, %body) {
        my $url = "$!base-url$path";
        my $req = HTTP::Request.new(:PUT($url));
        $req.header-field('x-api-key', $!api-key);
        $req.header-field('Content-Type', 'application/json');
        $req.content = to-json(%body);

        my $resp;
        try {
            $resp = $!ua.request($req);
            CATCH {
                default {
                    AntybrowserError.new(
                        message => "Failed to connect to Antybrowser Local API at $!base-url. Is Antybrowser running?\n{$_.message}",
                    ).throw;
                }
            }
        }

        self!handle-response($resp);
    }

    method !delete(Str $path) {
        my $url = "$!base-url$path";
        my $req = HTTP::Request.new(:DELETE($url));
        $req.header-field('x-api-key', $!api-key);
        $req.header-field('Content-Type', 'application/json');

        my $resp;
        try {
            $resp = $!ua.request($req);
            CATCH {
                default {
                    AntybrowserError.new(
                        message => "Failed to connect to Antybrowser Local API at $!base-url. Is Antybrowser running?\n{$_.message}",
                    ).throw;
                }
            }
        }

        self!handle-response($resp);
    }

    method !handle-response($resp) {
        my $text = $resp.content-decoded-body // '';

        unless $resp.is-success {
            AntybrowserError.new(
                message       => "API request failed with status {$resp.status-code}",
                status-code   => $resp.status-code.Int,
                response-body => $text,
            ).throw;
        }

        return {} unless $text && $text.trim ne '';

        try {
            return from-json($text);
            CATCH {
                AntybrowserError.new(
                    message       => 'Invalid JSON response from API',
                    status-code   => $resp.status-code.Int,
                    response-body => $text,
                ).throw;
            }
        }
    }
}
