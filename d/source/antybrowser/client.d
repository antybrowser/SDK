module antybrowser.client;

import std.net.curl : Curl, CurlOption, HTTP, HTTPCode, CurlHandle;
import std.json;
import std.conv : to;
import std.format : format;
import std.typecons : Nullable;
import core.time : dur;

import antybrowser.types;
import antybrowser.error;

class AntybrowserClient
{
    private string apiKey;
    private string baseURL;
    private int timeout;

    this(string apiKey, int port = 5173, string baseUrl = null, int timeout = 30000)
    {
        this.apiKey = apiKey;
        this.baseURL = baseUrl.length > 0 ? baseUrl : format("http://127.0.0.1:%d", port);
        this.timeout = timeout;
    }

    // ─── System ──────────────────────────────────────────────────────────

    StatusResponse getStatus()
    {
        return doGet!StatusResponse("/api/status");
    }

    Settings getSettings()
    {
        return doGet!Settings("/api/settings");
    }

    SyncStatus getSyncStatus()
    {
        return doGet!SyncStatus("/api/sync/status");
    }

    JSONValue refreshSync(Nullable!int profileID = Nullable!int.init)
    {
        JSONValue body_;
        if (!profileID.isNull)
        {
            body_ = JSONValue(string[string].init);
            body_["profileId"] = profileID.get;
        }
        else
        {
            body_ = JSONValue(string[string].init);
        }
        return doPost("/api/sync/refresh", body_);
    }

    // ─── Profiles ────────────────────────────────────────────────────────

    Profile[] getProfiles()
    {
        return doGetArray!Profile("/api/profiles");
    }

    Profile createProfile(CreateProfileRequest req)
    {
        return doPostAndDeserialize!Profile("/api/profiles", req.toJSON);
    }

    Profile updateProfile(int id, JSONValue data)
    {
        return doPut!Profile(format("/api/profiles/%d", id), data);
    }

    JSONValue deleteProfile(int id)
    {
        return doDelete(format("/api/profiles/%d", id));
    }

    StartProfileResponse startProfile(int id)
    {
        return doPostAndDeserialize!StartProfileResponse(format("/api/profiles/%d/start", id), JSONValue());
    }

    JSONValue stopProfile(int id)
    {
        return doPost(format("/api/profiles/%d/stop", id), JSONValue());
    }

    Profile duplicateProfile(int id, DuplicateProfileRequest opts = DuplicateProfileRequest.init)
    {
        return doPostAndDeserialize!Profile(format("/api/profiles/%d/duplicate", id), opts.toJSON);
    }

    // ─── Automations ─────────────────────────────────────────────────────

    Automation[] getAutomations()
    {
        return doGetArray!Automation("/api/automations");
    }

    RunAutomationResult runAutomation(int id, RunAutomationRequest req)
    {
        return doPostAndDeserialize!RunAutomationResult(
            format("/api/automations/%d/run", id), req.toJSON);
    }

    // ─── Groups ──────────────────────────────────────────────────────────

    Group[] getGroups()
    {
        return doGetArray!Group("/api/groups");
    }

    Group createGroup(CreateGroupRequest req)
    {
        return doPostAndDeserialize!Group("/api/groups", req.toJSON);
    }

    Group updateGroup(int id, JSONValue data)
    {
        return doPut!Group(format("/api/groups/%d", id), data);
    }

    void deleteGroup(int id)
    {
        doDeleteNoContent(format("/api/groups/%d", id));
    }

    // ─── Proxies ─────────────────────────────────────────────────────────

    Proxy[] getProxies()
    {
        return doGetArray!Proxy("/api/proxies");
    }

    Proxy createProxy(CreateProxyRequest req)
    {
        return doPostAndDeserialize!Proxy("/api/proxies", req.toJSON);
    }

    ProxyCheckResult checkProxy(string host, int port,
                                Nullable!string username = Nullable!string.init,
                                Nullable!string password = Nullable!string.init,
                                Nullable!string proxyType = Nullable!string.init)
    {
        JSONValue body_ = JSONValue(string[string].init);
        body_["host"] = host;
        body_["port"] = port;
        if (!username.isNull) body_["username"] = username.get;
        if (!password.isNull) body_["password"] = password.get;
        if (!proxyType.isNull) body_["type"] = proxyType.get;
        return doPostAndDeserialize!ProxyCheckResult("/api/proxies/check", body_);
    }

    ProxyCheckResult[] checkProxiesBulk(JSONValue[] proxies)
    {
        JSONValue body_ = JSONValue(string[string].init);
        JSONValue arr = JSONValue[].init;
        foreach (p; proxies)
            arr.arrayOf ~= p;
        body_["proxies"] = arr;
        JSONValue result = doPost("/api/proxies/check-bulk", body_);
        ProxyCheckResult[] results;
        if ("results" in result && result["results"].type == JSONType.array)
        {
            foreach (v; result["results"].arrayOf)
                results ~= ProxyCheckResult.fromJSON(v);
        }
        return results;
    }

    void deleteProxy(int id)
    {
        doDeleteNoContent(format("/api/proxies/%d", id));
    }

    // ─── Extensions ──────────────────────────────────────────────────────

    Extension[] getExtensions()
    {
        return doGetArray!Extension("/api/extensions");
    }

    void deleteExtension(int id)
    {
        doDeleteNoContent(format("/api/extensions/%d", id));
    }

    Extension[] getProfileExtensions(int profileID, bool details = false)
    {
        return doGetArray!Extension(
            format("/api/profiles/%d/extensions?details=%s", profileID, details ? "true" : "false"));
    }

    JSONValue setProfileExtensions(int profileID, int[] extensionIDs)
    {
        JSONValue body_ = JSONValue(string[string].init);
        JSONValue arr = JSONValue[].init;
        foreach (id; extensionIDs)
            arr.arrayOf ~= JSONValue(id);
        body_["extensionIds"] = arr;
        return doPost(format("/api/profiles/%d/extensions", profileID), body_);
    }

    // ─── Private HTTP Helpers ────────────────────────────────────────────

    private T doGet(T)(string path)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("GET", path, null, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
        if (responseBody.length == 0)
            return T.init;
        JSONValue j = parseJSON(responseBody);
        static if (is(T == StatusResponse))
            return StatusResponse.fromJSON(j);
        else static if (is(T == Settings))
            return Settings.fromJSON(j);
        else static if (is(T == SyncStatus))
            return SyncStatus.fromJSON(j);
        else
            static assert(false, "Unsupported type for GET: " ~ T.stringof);
    }

    private T[] doGetArray(T)(string path)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("GET", path, null, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
        if (responseBody.length == 0)
            return [];
        JSONValue j = parseJSON(responseBody);
        T[] results;
        if (j.type == JSONType.array)
        {
            foreach (v; j.arrayOf)
                results ~= T.fromJSON(v);
        }
        return results;
    }

    private JSONValue doPost(string path, JSONValue body_)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("POST", path, body_, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
        if (responseBody.length == 0)
            return JSONValue();
        return parseJSON(responseBody);
    }

    private T doPostAndDeserialize(T)(string path, JSONValue body_)
    {
        JSONValue j = doPost(path, body_);
        static if (is(T == Profile))
            return Profile.fromJSON(j);
        else static if (is(T == Proxy))
            return Proxy.fromJSON(j);
        else static if (is(T == Group))
            return Group.fromJSON(j);
        else static if (is(T == ProxyCheckResult))
            return ProxyCheckResult.fromJSON(j);
        else static if (is(T == RunAutomationResult))
            return RunAutomationResult.fromJSON(j);
        else static if (is(T == StartProfileResponse))
            return StartProfileResponse.fromJSON(j);
        else
            static assert(false, "Unsupported type for POST: " ~ T.stringof);
    }

    private T doPut(T)(string path, JSONValue body_)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("PUT", path, body_, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
        if (responseBody.length == 0)
            return T.init;
        JSONValue j = parseJSON(responseBody);
        static if (is(T == Profile))
            return Profile.fromJSON(j);
        else static if (is(T == Group))
            return Group.fromJSON(j);
        else
            static assert(false, "Unsupported type for PUT: " ~ T.stringof);
    }

    private JSONValue doDelete(string path)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("DELETE", path, null, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
        if (responseBody.length == 0)
            return JSONValue();
        return parseJSON(responseBody);
    }

    private void doDeleteNoContent(string path)
    {
        string responseBody;
        HTTPCode statusCode = doRequest("DELETE", path, null, responseBody);
        if (statusCode < 200 || statusCode >= 300)
            throw new AntybrowserError(statusCode.to!int, responseBody);
    }

    private HTTPCode doRequest(string method, string path, JSONValue body_, ref string responseBody)
    {
        auto http = HTTP();
        http.url = baseURL ~ path;
        http.setTimeout(dur!"seconds"(timeout / 1000));
        http.addRequestHeader("x-api-key", apiKey);
        http.addRequestHeader("Content-Type", "application/json");

        if (body_ !is JSONValue.init && body_.type != JSONType.null_)
        {
            string bodyStr = body_.toString();
            http.setPostData(bodyStr, "application/json");
        }

        switch (method)
        {
        case "GET":
            http.method = HTTP.Method.get;
            break;
        case "POST":
            http.method = HTTP.Method.post;
            break;
        case "PUT":
            http.method = HTTP.Method.put;
            break;
        case "DELETE":
            http.method = HTTP.Method.del;
            break;
        default:
            throw new AntybrowserError("Unsupported HTTP method: " ~ method);
        }

        import std.array : appender;

        auto app = appender!string();
        http.onReceive = (ubyte[] data) {
            app ~= cast(string) data;
            return data.length;
        };

        HTTPCode code;
        try
        {
            code = http.perform();
        }
        catch (Exception e)
        {
            throw new AntybrowserError("Request failed (is Antybrowser running?): " ~ e.msg);
        }

        responseBody = app.data;
        return code;
    }
}
