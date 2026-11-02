module antybrowser.types;

import std.json;
import std.traits : isSomeString;
import std.typecons : Nullable;

struct Profile
{
    int id;
    Nullable!int userId;
    Nullable!string userGuid;
    string name;
    Nullable!string directoryName;
    Nullable!int groupId;
    Nullable!int proxyId;
    Nullable!string browserType;
    Nullable!string browserVersion;
    Nullable!string osFingerprint;
    Nullable!string screenResolution;
    Nullable!bool screenMaximizable;
    Nullable!string language;
    Nullable!string acceptLanguage;
    Nullable!string timezone;
    Nullable!bool useFingerprint;
    // Server-owned noise seed. Read-only — never sent on create/update.
    Nullable!string fingerprintId;
    // --- Fingerprint surface ---
    Nullable!string platformVersion;
    Nullable!string brandVersion;
    Nullable!string engineVersion;
    Nullable!string gpuVendor;
    Nullable!string gpuModel;
    Nullable!JSONValue hardwareConcurrency;
    Nullable!JSONValue deviceMemory;
    Nullable!JSONValue deviceScaleFactor;
    Nullable!string mobileModel;
    Nullable!JSONValue mobileVersion;
    Nullable!string chPlatform;
    Nullable!string chPlatformVersion;
    Nullable!string chArch;
    Nullable!string chBitness;
    Nullable!string chModel;
    Nullable!JSONValue chMobile;
    Nullable!string disableSpoofing;
    // --- Geolocation spoof ---
    Nullable!string locationMode;
    Nullable!string locationLatitude;
    Nullable!string locationLongitude;
    Nullable!string locationAccuracy;
    Nullable!string userAgent;
    Nullable!bool restoreSession;
    Nullable!bool lowBandwidth;
    Nullable!string notes;
    Nullable!string startUrl;
    Nullable!string customFlags;
    Nullable!string status;
    Nullable!string statusMachineId;
    Nullable!string statusHeartbeatAt;
    Nullable!bool needsSync;
    Nullable!int lastPid;
    Nullable!int debugPort;
    Nullable!string tabsSnapshot;
    Nullable!bool hidden;
    Nullable!bool trash;
    Nullable!string deletedAt;
    Nullable!string createdAt;
    Nullable!string updatedAt;
    Nullable!string lastSyncedAt;
    Nullable!string s3Key;

    static Profile fromJSON(JSONValue j)
    {
        Profile p;
        if ("id" in j) p.id = j["id"].integer.to!int;
        setNullable(j, "userId", p.userId);
        setNullable(j, "userGuid", p.userGuid);
        if ("name" in j) p.name = j["name"].str;
        setNullable(j, "directoryName", p.directoryName);
        setNullable(j, "groupId", p.groupId);
        setNullable(j, "proxyId", p.proxyId);
        setNullable(j, "browserType", p.browserType);
        setNullable(j, "browserVersion", p.browserVersion);
        setNullable(j, "osFingerprint", p.osFingerprint);
        setNullable(j, "screenResolution", p.screenResolution);
        setNullable(j, "screenMaximizable", p.screenMaximizable);
        setNullable(j, "language", p.language);
        setNullable(j, "acceptLanguage", p.acceptLanguage);
        setNullable(j, "timezone", p.timezone);
        setNullable(j, "useFingerprint", p.useFingerprint);
        setNullable(j, "fingerprintId", p.fingerprintId);
        setNullable(j, "platformVersion", p.platformVersion);
        setNullable(j, "brandVersion", p.brandVersion);
        setNullable(j, "engineVersion", p.engineVersion);
        setNullable(j, "gpuVendor", p.gpuVendor);
        setNullable(j, "gpuModel", p.gpuModel);
        setNullable(j, "hardwareConcurrency", p.hardwareConcurrency);
        setNullable(j, "deviceMemory", p.deviceMemory);
        setNullable(j, "deviceScaleFactor", p.deviceScaleFactor);
        setNullable(j, "mobileModel", p.mobileModel);
        setNullable(j, "mobileVersion", p.mobileVersion);
        setNullable(j, "chPlatform", p.chPlatform);
        setNullable(j, "chPlatformVersion", p.chPlatformVersion);
        setNullable(j, "chArch", p.chArch);
        setNullable(j, "chBitness", p.chBitness);
        setNullable(j, "chModel", p.chModel);
        setNullable(j, "chMobile", p.chMobile);
        setNullable(j, "disableSpoofing", p.disableSpoofing);
        setNullable(j, "locationMode", p.locationMode);
        setNullable(j, "locationLatitude", p.locationLatitude);
        setNullable(j, "locationLongitude", p.locationLongitude);
        setNullable(j, "locationAccuracy", p.locationAccuracy);
        setNullable(j, "userAgent", p.userAgent);
        setNullable(j, "restoreSession", p.restoreSession);
        setNullable(j, "lowBandwidth", p.lowBandwidth);
        setNullable(j, "notes", p.notes);
        setNullable(j, "startUrl", p.startUrl);
        setNullable(j, "customFlags", p.customFlags);
        setNullable(j, "status", p.status);
        setNullable(j, "statusMachineId", p.statusMachineId);
        setNullable(j, "statusHeartbeatAt", p.statusHeartbeatAt);
        setNullable(j, "needsSync", p.needsSync);
        setNullable(j, "lastPid", p.lastPid);
        setNullable(j, "debugPort", p.debugPort);
        setNullable(j, "tabsSnapshot", p.tabsSnapshot);
        setNullable(j, "hidden", p.hidden);
        setNullable(j, "trash", p.trash);
        setNullable(j, "deletedAt", p.deletedAt);
        setNullable(j, "createdAt", p.createdAt);
        setNullable(j, "updatedAt", p.updatedAt);
        setNullable(j, "lastSyncedAt", p.lastSyncedAt);
        setNullable(j, "s3Key", p.s3Key);
        return p;
    }

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["id"] = id;
        j["name"] = name;
        if (!userId.isNull) j["userId"] = userId.get;
        if (!userGuid.isNull) j["userGuid"] = userGuid.get;
        if (!directoryName.isNull) j["directoryName"] = directoryName.get;
        if (!groupId.isNull) j["groupId"] = groupId.get;
        if (!proxyId.isNull) j["proxyId"] = proxyId.get;
        if (!browserType.isNull) j["browserType"] = browserType.get;
        if (!browserVersion.isNull) j["browserVersion"] = browserVersion.get;
        if (!osFingerprint.isNull) j["osFingerprint"] = osFingerprint.get;
        if (!screenResolution.isNull) j["screenResolution"] = screenResolution.get;
        if (!screenMaximizable.isNull) j["screenMaximizable"] = screenMaximizable.get;
        if (!language.isNull) j["language"] = language.get;
        if (!acceptLanguage.isNull) j["acceptLanguage"] = acceptLanguage.get;
        if (!timezone.isNull) j["timezone"] = timezone.get;
        if (!useFingerprint.isNull) j["useFingerprint"] = useFingerprint.get;
        if (!fingerprintId.isNull) j["fingerprintId"] = fingerprintId.get;
        if (!platformVersion.isNull) j["platformVersion"] = platformVersion.get;
        if (!brandVersion.isNull) j["brandVersion"] = brandVersion.get;
        if (!engineVersion.isNull) j["engineVersion"] = engineVersion.get;
        if (!gpuVendor.isNull) j["gpuVendor"] = gpuVendor.get;
        if (!gpuModel.isNull) j["gpuModel"] = gpuModel.get;
        if (!hardwareConcurrency.isNull) j["hardwareConcurrency"] = hardwareConcurrency.get;
        if (!deviceMemory.isNull) j["deviceMemory"] = deviceMemory.get;
        if (!deviceScaleFactor.isNull) j["deviceScaleFactor"] = deviceScaleFactor.get;
        if (!mobileModel.isNull) j["mobileModel"] = mobileModel.get;
        if (!mobileVersion.isNull) j["mobileVersion"] = mobileVersion.get;
        if (!chPlatform.isNull) j["chPlatform"] = chPlatform.get;
        if (!chPlatformVersion.isNull) j["chPlatformVersion"] = chPlatformVersion.get;
        if (!chArch.isNull) j["chArch"] = chArch.get;
        if (!chBitness.isNull) j["chBitness"] = chBitness.get;
        if (!chModel.isNull) j["chModel"] = chModel.get;
        if (!chMobile.isNull) j["chMobile"] = chMobile.get;
        if (!disableSpoofing.isNull) j["disableSpoofing"] = disableSpoofing.get;
        if (!locationMode.isNull) j["locationMode"] = locationMode.get;
        if (!locationLatitude.isNull) j["locationLatitude"] = locationLatitude.get;
        if (!locationLongitude.isNull) j["locationLongitude"] = locationLongitude.get;
        if (!locationAccuracy.isNull) j["locationAccuracy"] = locationAccuracy.get;
        if (!userAgent.isNull) j["userAgent"] = userAgent.get;
        if (!restoreSession.isNull) j["restoreSession"] = restoreSession.get;
        if (!lowBandwidth.isNull) j["lowBandwidth"] = lowBandwidth.get;
        if (!notes.isNull) j["notes"] = notes.get;
        if (!startUrl.isNull) j["startUrl"] = startUrl.get;
        if (!customFlags.isNull) j["customFlags"] = customFlags.get;
        if (!status.isNull) j["status"] = status.get;
        if (!statusMachineId.isNull) j["statusMachineId"] = statusMachineId.get;
        if (!statusHeartbeatAt.isNull) j["statusHeartbeatAt"] = statusHeartbeatAt.get;
        if (!needsSync.isNull) j["needsSync"] = needsSync.get;
        if (!lastPid.isNull) j["lastPid"] = lastPid.get;
        if (!debugPort.isNull) j["debugPort"] = debugPort.get;
        if (!tabsSnapshot.isNull) j["tabsSnapshot"] = tabsSnapshot.get;
        if (!hidden.isNull) j["hidden"] = hidden.get;
        if (!trash.isNull) j["trash"] = trash.get;
        if (!deletedAt.isNull) j["deletedAt"] = deletedAt.get;
        if (!createdAt.isNull) j["createdAt"] = createdAt.get;
        if (!updatedAt.isNull) j["updatedAt"] = updatedAt.get;
        if (!lastSyncedAt.isNull) j["lastSyncedAt"] = lastSyncedAt.get;
        if (!s3Key.isNull) j["s3Key"] = s3Key.get;
        return j;
    }
}

struct CreateProfileRequest
{
    string name;
    Nullable!string directoryName;
    Nullable!int groupId;
    Nullable!int proxyId;
    Nullable!string browserType;
    Nullable!string browserVersion;
    Nullable!string osFingerprint;
    Nullable!string screenResolution;
    Nullable!bool screenMaximizable;
    Nullable!string language;
    Nullable!string acceptLanguage;
    Nullable!string timezone;
    Nullable!bool useFingerprint;
    Nullable!string platformVersion;
    Nullable!string brandVersion;
    Nullable!string engineVersion;
    Nullable!string gpuVendor;
    Nullable!string gpuModel;
    Nullable!JSONValue hardwareConcurrency;
    Nullable!JSONValue deviceMemory;
    Nullable!JSONValue deviceScaleFactor;
    Nullable!string mobileModel;
    Nullable!JSONValue mobileVersion;
    Nullable!string chPlatform;
    Nullable!string chPlatformVersion;
    Nullable!string chArch;
    Nullable!string chBitness;
    Nullable!string chModel;
    Nullable!JSONValue chMobile;
    Nullable!string disableSpoofing;
    Nullable!string locationMode;
    Nullable!string locationLatitude;
    Nullable!string locationLongitude;
    Nullable!string locationAccuracy;
    Nullable!bool restoreSession;
    Nullable!bool lowBandwidth;
    Nullable!string notes;
    Nullable!string startUrl;
    Nullable!string customFlags;
    Nullable!string status;
    Nullable!bool hidden;

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["name"] = name;
        if (!directoryName.isNull) j["directoryName"] = directoryName.get;
        if (!groupId.isNull) j["groupId"] = groupId.get;
        if (!proxyId.isNull) j["proxyId"] = proxyId.get;
        if (!browserType.isNull) j["browserType"] = browserType.get;
        if (!browserVersion.isNull) j["browserVersion"] = browserVersion.get;
        if (!osFingerprint.isNull) j["osFingerprint"] = osFingerprint.get;
        if (!screenResolution.isNull) j["screenResolution"] = screenResolution.get;
        if (!screenMaximizable.isNull) j["screenMaximizable"] = screenMaximizable.get;
        if (!language.isNull) j["language"] = language.get;
        if (!acceptLanguage.isNull) j["acceptLanguage"] = acceptLanguage.get;
        if (!timezone.isNull) j["timezone"] = timezone.get;
        if (!useFingerprint.isNull) j["useFingerprint"] = useFingerprint.get;
        if (!platformVersion.isNull) j["platformVersion"] = platformVersion.get;
        if (!brandVersion.isNull) j["brandVersion"] = brandVersion.get;
        if (!engineVersion.isNull) j["engineVersion"] = engineVersion.get;
        if (!gpuVendor.isNull) j["gpuVendor"] = gpuVendor.get;
        if (!gpuModel.isNull) j["gpuModel"] = gpuModel.get;
        if (!hardwareConcurrency.isNull) j["hardwareConcurrency"] = hardwareConcurrency.get;
        if (!deviceMemory.isNull) j["deviceMemory"] = deviceMemory.get;
        if (!deviceScaleFactor.isNull) j["deviceScaleFactor"] = deviceScaleFactor.get;
        if (!mobileModel.isNull) j["mobileModel"] = mobileModel.get;
        if (!mobileVersion.isNull) j["mobileVersion"] = mobileVersion.get;
        if (!chPlatform.isNull) j["chPlatform"] = chPlatform.get;
        if (!chPlatformVersion.isNull) j["chPlatformVersion"] = chPlatformVersion.get;
        if (!chArch.isNull) j["chArch"] = chArch.get;
        if (!chBitness.isNull) j["chBitness"] = chBitness.get;
        if (!chModel.isNull) j["chModel"] = chModel.get;
        if (!chMobile.isNull) j["chMobile"] = chMobile.get;
        if (!disableSpoofing.isNull) j["disableSpoofing"] = disableSpoofing.get;
        if (!locationMode.isNull) j["locationMode"] = locationMode.get;
        if (!locationLatitude.isNull) j["locationLatitude"] = locationLatitude.get;
        if (!locationLongitude.isNull) j["locationLongitude"] = locationLongitude.get;
        if (!locationAccuracy.isNull) j["locationAccuracy"] = locationAccuracy.get;
        if (!restoreSession.isNull) j["restoreSession"] = restoreSession.get;
        if (!lowBandwidth.isNull) j["lowBandwidth"] = lowBandwidth.get;
        if (!notes.isNull) j["notes"] = notes.get;
        if (!startUrl.isNull) j["startUrl"] = startUrl.get;
        if (!customFlags.isNull) j["customFlags"] = customFlags.get;
        if (!status.isNull) j["status"] = status.get;
        if (!hidden.isNull) j["hidden"] = hidden.get;
        return j;
    }
}

struct Proxy
{
    int id;
    Nullable!string name;
    Nullable!string type;
    Nullable!string host;
    Nullable!int port;
    Nullable!string username;
    Nullable!string password;
    Nullable!string status;
    Nullable!string countryCode;
    Nullable!string ip;
    Nullable!string country;
    Nullable!string timezone;
    Nullable!string asn;
    Nullable!string isp;

    static Proxy fromJSON(JSONValue j)
    {
        Proxy p;
        if ("id" in j) p.id = j["id"].integer.to!int;
        setNullable(j, "name", p.name);
        setNullable(j, "type", p.type);
        setNullable(j, "host", p.host);
        setNullable(j, "port", p.port);
        setNullable(j, "username", p.username);
        setNullable(j, "password", p.password);
        setNullable(j, "status", p.status);
        setNullable(j, "countryCode", p.countryCode);
        setNullable(j, "ip", p.ip);
        setNullable(j, "country", p.country);
        setNullable(j, "timezone", p.timezone);
        setNullable(j, "asn", p.asn);
        setNullable(j, "isp", p.isp);
        return p;
    }

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["id"] = id;
        if (!name.isNull) j["name"] = name.get;
        if (!type.isNull) j["type"] = type.get;
        if (!host.isNull) j["host"] = host.get;
        if (!port.isNull) j["port"] = port.get;
        if (!username.isNull) j["username"] = username.get;
        if (!password.isNull) j["password"] = password.get;
        if (!status.isNull) j["status"] = status.get;
        if (!countryCode.isNull) j["countryCode"] = countryCode.get;
        if (!ip.isNull) j["ip"] = ip.get;
        if (!country.isNull) j["country"] = country.get;
        if (!timezone.isNull) j["timezone"] = timezone.get;
        if (!asn.isNull) j["asn"] = asn.get;
        if (!isp.isNull) j["isp"] = isp.get;
        return j;
    }
}

struct CreateProxyRequest
{
    string name;
    string host;
    int port;
    string type;
    Nullable!string username;
    Nullable!string password;

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["name"] = name;
        j["host"] = host;
        j["port"] = port;
        j["type"] = type;
        if (!username.isNull) j["username"] = username.get;
        if (!password.isNull) j["password"] = password.get;
        return j;
    }
}

struct Group
{
    int id;
    string name;
    Nullable!string description;
    Nullable!string color;
    Nullable!int displayOrder;
    Nullable!string createdAt;
    Nullable!string updatedAt;

    static Group fromJSON(JSONValue j)
    {
        Group g;
        if ("id" in j) g.id = j["id"].integer.to!int;
        if ("name" in j) g.name = j["name"].str;
        setNullable(j, "description", g.description);
        setNullable(j, "color", g.color);
        setNullable(j, "displayOrder", g.displayOrder);
        setNullable(j, "createdAt", g.createdAt);
        setNullable(j, "updatedAt", g.updatedAt);
        return g;
    }

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["id"] = id;
        j["name"] = name;
        if (!description.isNull) j["description"] = description.get;
        if (!color.isNull) j["color"] = color.get;
        if (!displayOrder.isNull) j["displayOrder"] = displayOrder.get;
        if (!createdAt.isNull) j["createdAt"] = createdAt.get;
        if (!updatedAt.isNull) j["updatedAt"] = updatedAt.get;
        return j;
    }
}

struct CreateGroupRequest
{
    string name;
    Nullable!string description;
    Nullable!string color;

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["name"] = name;
        if (!description.isNull) j["description"] = description.get;
        if (!color.isNull) j["color"] = color.get;
        return j;
    }
}

struct Extension
{
    int id;
    string name;
    Nullable!string path;
    Nullable!string description;
    Nullable!string icon;
    Nullable!string iconDataUrl;
    Nullable!string createdAt;

    static Extension fromJSON(JSONValue j)
    {
        Extension e;
        if ("id" in j) e.id = j["id"].integer.to!int;
        if ("name" in j) e.name = j["name"].str;
        setNullable(j, "path", e.path);
        setNullable(j, "description", e.description);
        setNullable(j, "icon", e.icon);
        setNullable(j, "iconDataUrl", e.iconDataUrl);
        setNullable(j, "createdAt", e.createdAt);
        return e;
    }
}

struct Automation
{
    int id;
    string name;
    Nullable!string description;
    Nullable!string status;
    Nullable!string lastRun;
    Nullable!string createdAt;
    Nullable!string updatedAt;

    static Automation fromJSON(JSONValue j)
    {
        Automation a;
        if ("id" in j) a.id = j["id"].integer.to!int;
        if ("name" in j) a.name = j["name"].str;
        setNullable(j, "description", a.description);
        setNullable(j, "status", a.status);
        setNullable(j, "lastRun", a.lastRun);
        setNullable(j, "createdAt", a.createdAt);
        setNullable(j, "updatedAt", a.updatedAt);
        return a;
    }
}

struct RunAutomationRequest
{
    int profileId;
    Nullable!bool deleteCookies;
    Nullable!(string[string]) variables;

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        j["profileId"] = profileId;
        if (!deleteCookies.isNull) j["deleteCookies"] = deleteCookies.get;
        if (!variables.isNull)
        {
            JSONValue v = JSONValue(string[string].init);
            foreach (k, val; variables.get)
                v[k] = val;
            j["variables"] = v;
        }
        return j;
    }
}

struct RunAutomationResult
{
    bool success;
    string message;
    Nullable!(JSONValue[string]) variables;

    static RunAutomationResult fromJSON(JSONValue j)
    {
        RunAutomationResult r;
        if ("success" in j) r.success = j["success"].boolean;
        if ("message" in j) r.message = j["message"].str;
        if ("variables" in j && j["variables"].type == JSONType.object)
        {
            JSONValue[string] m;
            foreach (k, v; j["variables"].objectOf)
                m[k] = v;
            r.variables = m;
        }
        return r;
    }
}

struct StartProfileData
{
    int debugPort;
    JSONValue[string] extra;

    static StartProfileData fromJSON(JSONValue j)
    {
        StartProfileData d;
        if ("debugPort" in j) d.debugPort = j["debugPort"].integer.to!int;
        foreach (k, v; j.objectOf)
        {
            if (k != "debugPort")
                d.extra[k] = v;
        }
        return d;
    }
}

struct StartProfileResponse
{
    bool success;
    StartProfileData data;

    static StartProfileResponse fromJSON(JSONValue j)
    {
        StartProfileResponse r;
        if ("success" in j) r.success = j["success"].boolean;
        if ("data" in j) r.data = StartProfileData.fromJSON(j["data"]);
        return r;
    }
}

struct ApiResponse
{
    bool success;
    JSONValue data;

    static ApiResponse fromJSON(JSONValue j)
    {
        ApiResponse r;
        if ("success" in j) r.success = j["success"].boolean;
        if ("data" in j) r.data = j["data"];
        return r;
    }
}

struct DuplicateProfileRequest
{
    Nullable!string name;
    Nullable!string directoryName;

    JSONValue toJSON() const
    {
        JSONValue j = JSONValue(string[string].init);
        if (!name.isNull) j["name"] = name.get;
        if (!directoryName.isNull) j["directoryName"] = directoryName.get;
        return j;
    }
}

private:
import std.conv : to;

void setNullable(T)(JSONValue j, string key, ref Nullable!T target)
{
    if (key in j && j[key].type != JSONType.null_)
    {
        static if (is(T == int))
            target = Nullable!int(j[key].integer.to!int);
        else static if (is(T == bool))
            target = Nullable!bool(j[key].boolean);
        else static if (isSomeString!T)
            target = Nullable!string(j[key].str);
        else static if (is(T == long))
            target = Nullable!long(j[key].integer);
        else static if (is(T == double))
            target = Nullable!double(j[key].floating);
        else static if (is(T == JSONValue))
            target = Nullable!JSONValue(j[key]);
        else
            static assert(false, "Unsupported Nullable type: " ~ T.stringof);
    }
}
