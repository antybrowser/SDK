const std = @import("std");
const types = @import("types.zig");
const errors = @import("error.zig");

const Allocator = std.mem.Allocator;
const Http = std.http;

pub const AntybrowserClient = struct {
    allocator: Allocator,
    base_url: []const u8,
    api_key: []const u8,
    timeout_ms: u64,

    const default_base_url = "http://127.0.0.1:5173";
    const default_timeout_ms: u64 = 30000;

    pub fn init(allocator: Allocator, api_key: []const u8) AntybrowserClient {
        return .{
            .allocator = allocator,
            .base_url = allocator.dupe(u8, default_base_url) catch default_base_url,
            .api_key = api_key,
            .timeout_ms = default_timeout_ms,
        };
    }

    pub fn deinit(self: *AntybrowserClient) void {
        if (!std.mem.eql(u8, self.base_url, default_base_url)) {
            self.allocator.free(self.base_url);
        }
    }

    pub fn withPort(self: *AntybrowserClient, port: u16) AntybrowserClient {
        var copy = self.*;
        copy.base_url = std.fmt.allocPrint(self.allocator, "http://127.0.0.1:{d}", .{port}) catch self.base_url;
        return copy;
    }

    pub fn withBaseUrl(self: *AntybrowserClient, url: []const u8) AntybrowserClient {
        var copy = self.*;
        copy.base_url = self.allocator.dupe(u8, url) catch self.base_url;
        return copy;
    }

    fn buildUrl(self: *AntybrowserClient, path: []const u8) ![]const u8 {
        return std.fmt.allocPrint(self.allocator, "{s}{s}", .{ self.base_url, path });
    }

    fn buildUrlFmt(self: *AntybrowserClient, comptime fmt: []const u8, args: anytype) ![]const u8 {
        return std.fmt.allocPrint(self.allocator, "{s}" ++ fmt, .{self.base_url} ++ args);
    }

    fn doRequest(self: *AntybrowserClient, method: Http.Method, url: []const u8, body: ?[]const u8) errors.AntybrowserError![]const u8 {
        const uri = std.Uri.parse(url) catch return error.UriParseError;

        var client = Http.Client{ .allocator = self.allocator };
        defer client.deinit();

        var header_buf: [16 * 1024]u8 = undefined;
        var req = client.open(method, uri, .{
            .server_header_buffer = &header_buf,
        }) catch return error.HttpError;
        defer req.deinit();

        req.send() catch return error.HttpError;

        {
            var w = req.writer();
            w.writeAll("x-api-key: ") catch return error.HttpError;
            w.writeAll(self.api_key) catch return error.HttpError;
            w.writeAll("\r\n") catch return error.HttpError;
            w.writeAll("content-type: application/json\r\n") catch return error.HttpError;
            w.writeAll("\r\n") catch return error.HttpError;
        }

        if (body) |b| {
            req.writer().writeAll(b) catch return error.HttpError;
        }

        var resp = req.wait() catch return error.HttpError;
        defer resp.deinit();

        const status_code: u16 = @intFromEnum(resp.status);
        if (status_code < 200 or status_code >= 300) {
            return errors.httpStatusToApiError(status_code);
        }

        const response_body = resp.reader().readAllAlloc(self.allocator, 10 * 1024 * 1024) catch return error.HttpError;
        return response_body;
    }

    fn doGet(self: *AntybrowserClient, path: []const u8) errors.AntybrowserError![]const u8 {
        const url = try self.buildUrl(path);
        defer self.allocator.free(url);
        return self.doRequest(.GET, url, null);
    }

    fn doPost(self: *AntybrowserClient, path: []const u8, body: []const u8) errors.AntybrowserError![]const u8 {
        const url = try self.buildUrl(path);
        defer self.allocator.free(url);
        return self.doRequest(.POST, url, body);
    }

    fn doPut(self: *AntybrowserClient, path: []const u8, body: []const u8) errors.AntybrowserError![]const u8 {
        const url = try self.buildUrl(path);
        defer self.allocator.free(url);
        return self.doRequest(.PUT, url, body);
    }

    fn doDelete(self: *AntybrowserClient, path: []const u8) errors.AntybrowserError![]const u8 {
        const url = try self.buildUrl(path);
        defer self.allocator.free(url);
        return self.doRequest(.DELETE, url, null);
    }

    fn toJson(self: *AntybrowserClient, value: anytype) errors.AntybrowserError![]const u8 {
        return std.json.stringifyAlloc(self.allocator, value, .{}) catch return error.JsonError;
    }

    fn parseResponse(self: *AntybrowserClient, comptime T: type, body: []const u8) errors.AntybrowserError!T {
        const parsed = std.json.parseFromSlice(T, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        }) catch return error.JsonError;
        defer parsed.deinit();
        return try std.mem.dupe(self.allocator, u8, std.json.stringifyAlloc(self.allocator, parsed.value, .{}) catch return error.JsonError);
    }

    // ── Status ──────────────────────────────────────────────────────────

    pub fn getStatus(self: *AntybrowserClient) errors.AntybrowserError!types.StatusResponse {
        const body = try self.doGet("/api/status");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.StatusResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Profiles ────────────────────────────────────────────────────────

    pub fn listProfiles(self: *AntybrowserClient) errors.AntybrowserError!types.ProfileListResponse {
        const body = try self.doGet("/api/profiles");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ProfileListResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn createProfile(self: *AntybrowserClient, request: types.CreateProfileRequest) errors.AntybrowserError!types.Profile {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const body = try self.doPost("/api/profiles", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Profile, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn getProfile(self: *AntybrowserClient, profile_id: []const u8) errors.AntybrowserError!types.Profile {
        const path = try self.buildUrlFmt("/api/profiles/{s}", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doGet(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Profile, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn updateProfile(self: *AntybrowserClient, profile_id: []const u8, request: types.CreateProfileRequest) errors.AntybrowserError!types.Profile {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const path = try self.buildUrlFmt("/api/profiles/{s}", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doPut(path, json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Profile, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn deleteProfile(self: *AntybrowserClient, profile_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/profiles/{s}", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doDelete(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn duplicateProfile(self: *AntybrowserClient, profile_id: []const u8, request: types.DuplicateProfileRequest) errors.AntybrowserError!types.Profile {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const path = try self.buildUrlFmt("/api/profiles/{s}/duplicate", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doPost(path, json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Profile, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn startProfile(self: *AntybrowserClient, profile_id: []const u8) errors.AntybrowserError!types.StartProfileResponse {
        const path = try self.buildUrlFmt("/api/profiles/{s}/start", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doPost(path, "{}");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.StartProfileResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn stopProfile(self: *AntybrowserClient, profile_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/profiles/{s}/stop", .{profile_id});
        defer self.allocator.free(path);
        const body = try self.doPost(path, "{}");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Proxies ─────────────────────────────────────────────────────────

    pub fn listProxies(self: *AntybrowserClient) errors.AntybrowserError!types.ProxyListResponse {
        const body = try self.doGet("/api/proxies");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ProxyListResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn createProxy(self: *AntybrowserClient, request: types.CreateProxyRequest) errors.AntybrowserError!types.Proxy {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const body = try self.doPost("/api/proxies", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Proxy, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn getProxy(self: *AntybrowserClient, proxy_id: []const u8) errors.AntybrowserError!types.Proxy {
        const path = try self.buildUrlFmt("/api/proxies/{s}", .{proxy_id});
        defer self.allocator.free(path);
        const body = try self.doGet(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Proxy, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn deleteProxy(self: *AntybrowserClient, proxy_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/proxies/{s}", .{proxy_id});
        defer self.allocator.free(path);
        const body = try self.doDelete(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn checkProxy(self: *AntybrowserClient, proxy_id: []const u8) errors.AntybrowserError!types.ProxyCheckResult {
        const json = try std.json.stringifyAlloc(self.allocator, .{ .proxy_id = proxy_id }, .{});
        defer self.allocator.free(json);
        const body = try self.doPost("/api/proxies/check", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ProxyCheckResult, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Groups ──────────────────────────────────────────────────────────

    pub fn listGroups(self: *AntybrowserClient) errors.AntybrowserError!types.GroupListResponse {
        const body = try self.doGet("/api/groups");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.GroupListResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn createGroup(self: *AntybrowserClient, request: types.CreateGroupRequest) errors.AntybrowserError!types.Group {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const body = try self.doPost("/api/groups", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Group, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn getGroup(self: *AntybrowserClient, group_id: []const u8) errors.AntybrowserError!types.Group {
        const path = try self.buildUrlFmt("/api/groups/{s}", .{group_id});
        defer self.allocator.free(path);
        const body = try self.doGet(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Group, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn updateGroup(self: *AntybrowserClient, group_id: []const u8, request: types.CreateGroupRequest) errors.AntybrowserError!types.Group {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const path = try self.buildUrlFmt("/api/groups/{s}", .{group_id});
        defer self.allocator.free(path);
        const body = try self.doPut(path, json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Group, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn deleteGroup(self: *AntybrowserClient, group_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/groups/{s}", .{group_id});
        defer self.allocator.free(path);
        const body = try self.doDelete(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Extensions ──────────────────────────────────────────────────────

    pub fn listExtensions(self: *AntybrowserClient) errors.AntybrowserError!types.ExtensionListResponse {
        const body = try self.doGet("/api/extensions");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ExtensionListResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn installExtension(self: *AntybrowserClient, extension_path: []const u8) errors.AntybrowserError!types.Extension {
        const json = try std.json.stringifyAlloc(self.allocator, .{ .path = extension_path }, .{});
        defer self.allocator.free(json);
        const body = try self.doPost("/api/extensions/install", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Extension, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn uninstallExtension(self: *AntybrowserClient, extension_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/extensions/{s}", .{extension_id});
        defer self.allocator.free(path);
        const body = try self.doDelete(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Automations ─────────────────────────────────────────────────────

    pub fn runAutomation(self: *AntybrowserClient, request: types.RunAutomationRequest) errors.AntybrowserError!types.RunAutomationResult {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const body = try self.doPost("/api/automations/run", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.RunAutomationResult, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn stopAutomation(self: *AntybrowserClient, automation_id: []const u8) errors.AntybrowserError!types.ApiResponse {
        const path = try self.buildUrlFmt("/api/automations/{s}/stop", .{automation_id});
        defer self.allocator.free(path);
        const body = try self.doPost(path, "{}");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.ApiResponse, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn getAutomationStatus(self: *AntybrowserClient, automation_id: []const u8) errors.AntybrowserError!types.Automation {
        const path = try self.buildUrlFmt("/api/automations/{s}/status", .{automation_id});
        defer self.allocator.free(path);
        const body = try self.doGet(path);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Automation, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    // ── Settings ────────────────────────────────────────────────────────

    pub fn getSettings(self: *AntybrowserClient) errors.AntybrowserError!types.Settings {
        const body = try self.doGet("/api/settings");
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Settings, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }

    pub fn updateSettings(self: *AntybrowserClient, request: types.Settings) errors.AntybrowserError!types.Settings {
        const json = try self.toJson(request);
        defer self.allocator.free(json);
        const body = try self.doPut("/api/settings", json);
        defer self.allocator.free(body);
        const parsed = try std.json.parseFromSlice(types.Settings, self.allocator, body, .{
            .allocate = .alloc_always,
            .ignore_unknown_fields = true,
        });
        defer parsed.deinit();
        return parsed.value;
    }
};
