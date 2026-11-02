from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, Optional, Union


@dataclass
class StartProfileData:
    debug_port: Optional[int] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    def __getattr__(self, name: str) -> Any:
        return self.extra.get(name)


@dataclass
class StartProfileResponse:
    success: bool
    data: StartProfileData


@dataclass
class Profile:
    id: int
    name: str
    user_id: Optional[int] = None
    user_guid: Optional[str] = None
    directory_name: Optional[str] = None
    group_id: Optional[int] = None
    proxy_id: Optional[int] = None
    browser_type: Optional[str] = None
    browser_version: Optional[str] = None
    os_fingerprint: Optional[str] = None
    screen_resolution: Optional[str] = None
    screen_maximizable: Optional[bool] = None
    language: Optional[str] = None
    accept_language: Optional[str] = None
    timezone: Optional[str] = None
    use_fingerprint: Optional[bool] = None
    #: Server-owned noise seed. Read-only — never sent on create/update.
    fingerprint_id: Optional[str] = None
    # --- Fingerprint surface ---
    platform_version: Optional[str] = None
    brand_version: Optional[str] = None
    engine_version: Optional[str] = None
    gpu_vendor: Optional[str] = None
    gpu_model: Optional[str] = None
    hardware_concurrency: Optional[Union[str, int]] = None
    device_memory: Optional[Union[str, int]] = None
    device_scale_factor: Optional[Union[str, int]] = None
    mobile_model: Optional[str] = None
    mobile_version: Optional[Union[str, int]] = None
    ch_platform: Optional[str] = None
    ch_platform_version: Optional[str] = None
    ch_arch: Optional[str] = None
    ch_bitness: Optional[str] = None
    ch_model: Optional[str] = None
    ch_mobile: Optional[Union[str, int]] = None
    disable_spoofing: Optional[str] = None
    # --- Geolocation spoof ---
    location_mode: Optional[str] = None
    location_latitude: Optional[str] = None
    location_longitude: Optional[str] = None
    location_accuracy: Optional[str] = None
    user_agent: Optional[str] = None
    restore_session: Optional[bool] = None
    low_bandwidth: Optional[bool] = None
    notes: Optional[str] = None
    start_url: Optional[str] = None
    custom_flags: Optional[str] = None
    status: Optional[str] = None
    status_machine_id: Optional[str] = None
    status_heartbeat_at: Optional[str] = None
    needs_sync: Optional[bool] = None
    last_pid: Optional[int] = None
    debug_port: Optional[int] = None
    tabs_snapshot: Optional[str] = None
    hidden: Optional[bool] = None
    trash: Optional[bool] = None
    deleted_at: Optional[str] = None
    created_at: Optional[str] = None
    updated_at: Optional[str] = None
    last_synced_at: Optional[str] = None
    s3_key: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Profile:
        known = {f.name for f in cls.__dataclass_fields__.values()} | {"extra"}
        extra = {k: v for k, v in d.items() if k not in known}
        return cls(
            id=d["id"],
            name=d["name"],
            user_id=d.get("userId"),
            user_guid=d.get("userGuid"),
            directory_name=d.get("directoryName"),
            group_id=d.get("groupId"),
            proxy_id=d.get("proxyId"),
            browser_type=d.get("browserType"),
            browser_version=d.get("browserVersion"),
            os_fingerprint=d.get("osFingerprint"),
            screen_resolution=d.get("screenResolution"),
            screen_maximizable=d.get("screenMaximizable"),
            language=d.get("language"),
            accept_language=d.get("acceptLanguage"),
            timezone=d.get("timezone"),
            use_fingerprint=d.get("useFingerprint"),
            fingerprint_id=d.get("fingerprintId"),
            platform_version=d.get("platformVersion"),
            brand_version=d.get("brandVersion"),
            engine_version=d.get("engineVersion"),
            gpu_vendor=d.get("gpuVendor"),
            gpu_model=d.get("gpuModel"),
            hardware_concurrency=d.get("hardwareConcurrency"),
            device_memory=d.get("deviceMemory"),
            device_scale_factor=d.get("deviceScaleFactor"),
            mobile_model=d.get("mobileModel"),
            mobile_version=d.get("mobileVersion"),
            ch_platform=d.get("chPlatform"),
            ch_platform_version=d.get("chPlatformVersion"),
            ch_arch=d.get("chArch"),
            ch_bitness=d.get("chBitness"),
            ch_model=d.get("chModel"),
            ch_mobile=d.get("chMobile"),
            disable_spoofing=d.get("disableSpoofing"),
            location_mode=d.get("locationMode"),
            location_latitude=d.get("locationLatitude"),
            location_longitude=d.get("locationLongitude"),
            location_accuracy=d.get("locationAccuracy"),
            user_agent=d.get("userAgent"),
            restore_session=d.get("restoreSession"),
            low_bandwidth=d.get("lowBandwidth"),
            notes=d.get("notes"),
            start_url=d.get("startUrl"),
            custom_flags=d.get("customFlags"),
            status=d.get("status"),
            status_machine_id=d.get("statusMachineId"),
            status_heartbeat_at=d.get("statusHeartbeatAt"),
            needs_sync=d.get("needsSync"),
            last_pid=d.get("lastPid"),
            debug_port=d.get("debugPort"),
            tabs_snapshot=d.get("tabsSnapshot"),
            hidden=d.get("hidden"),
            trash=d.get("trash"),
            deleted_at=d.get("deletedAt"),
            created_at=d.get("createdAt"),
            updated_at=d.get("updatedAt"),
            last_synced_at=d.get("lastSyncedAt"),
            s3_key=d.get("s3Key"),
            extra=extra,
        )


@dataclass
class CreateProfileRequest:
    name: str
    directory_name: Optional[str] = None
    group_id: Optional[int] = None
    proxy_id: Optional[int] = None
    browser_type: Optional[str] = None
    browser_version: Optional[str] = None
    os_fingerprint: Optional[str] = None
    screen_resolution: Optional[str] = None
    screen_maximizable: Optional[bool] = None
    language: Optional[str] = None
    accept_language: Optional[str] = None
    timezone: Optional[str] = None
    use_fingerprint: Optional[bool] = None
    platform_version: Optional[str] = None
    brand_version: Optional[str] = None
    engine_version: Optional[str] = None
    gpu_vendor: Optional[str] = None
    gpu_model: Optional[str] = None
    hardware_concurrency: Optional[Union[str, int]] = None
    device_memory: Optional[Union[str, int]] = None
    device_scale_factor: Optional[Union[str, int]] = None
    mobile_model: Optional[str] = None
    mobile_version: Optional[Union[str, int]] = None
    ch_platform: Optional[str] = None
    ch_platform_version: Optional[str] = None
    ch_arch: Optional[str] = None
    ch_bitness: Optional[str] = None
    ch_model: Optional[str] = None
    ch_mobile: Optional[Union[str, int]] = None
    disable_spoofing: Optional[str] = None
    location_mode: Optional[str] = None
    location_latitude: Optional[str] = None
    location_longitude: Optional[str] = None
    location_accuracy: Optional[str] = None
    restore_session: Optional[bool] = None
    low_bandwidth: Optional[bool] = None
    notes: Optional[str] = None
    start_url: Optional[str] = None
    custom_flags: Optional[str] = None
    status: Optional[str] = None
    hidden: Optional[bool] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {"name": self.name}
        mapping = {
            "directory_name": "directoryName", "group_id": "groupId",
            "proxy_id": "proxyId", "browser_type": "browserType",
            "browser_version": "browserVersion", "os_fingerprint": "osFingerprint",
            "screen_resolution": "screenResolution",
            "screen_maximizable": "screenMaximizable",
            "accept_language": "acceptLanguage", "use_fingerprint": "useFingerprint",
            "platform_version": "platformVersion", "brand_version": "brandVersion",
            "engine_version": "engineVersion", "gpu_vendor": "gpuVendor",
            "gpu_model": "gpuModel", "hardware_concurrency": "hardwareConcurrency",
            "device_memory": "deviceMemory", "device_scale_factor": "deviceScaleFactor",
            "mobile_model": "mobileModel", "mobile_version": "mobileVersion",
            "ch_platform": "chPlatform", "ch_platform_version": "chPlatformVersion",
            "ch_arch": "chArch", "ch_bitness": "chBitness", "ch_model": "chModel",
            "ch_mobile": "chMobile", "disable_spoofing": "disableSpoofing",
            "location_mode": "locationMode", "location_latitude": "locationLatitude",
            "location_longitude": "locationLongitude",
            "location_accuracy": "locationAccuracy",
            "restore_session": "restoreSession", "low_bandwidth": "lowBandwidth",
            "start_url": "startUrl", "custom_flags": "customFlags",
        }
        for py_key, api_key in mapping.items():
            val = getattr(self, py_key)
            if val is not None:
                d[api_key] = val
        for attr in ("language", "timezone", "notes", "status", "hidden"):
            val = getattr(self, attr)
            if val is not None:
                d[attr] = val
        return d


@dataclass
class Proxy:
    id: int
    name: Optional[str] = None
    type: Optional[str] = None
    host: Optional[str] = None
    port: Optional[int] = None
    username: Optional[str] = None
    password: Optional[str] = None
    status: Optional[str] = None
    country_code: Optional[str] = None
    ip: Optional[str] = None
    country: Optional[str] = None
    timezone: Optional[str] = None
    asn: Optional[str] = None
    isp: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Proxy:
        known = {f.name for f in cls.__dataclass_fields__.values()} | {"extra"}
        extra = {k: v for k, v in d.items() if k not in known}
        return cls(
            id=d["id"], name=d.get("name"), type=d.get("type"),
            host=d.get("host"), port=d.get("port"),
            username=d.get("username"), password=d.get("password"),
            status=d.get("status"), country_code=d.get("countryCode"),
            ip=d.get("ip"), country=d.get("country"),
            timezone=d.get("timezone"), asn=d.get("asn"), isp=d.get("isp"),
            extra=extra,
        )


@dataclass
class CreateProxyRequest:
    name: str
    host: str
    port: int
    type: str
    username: Optional[str] = None
    password: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {"name": self.name, "host": self.host, "port": self.port, "type": self.type}
        if self.username is not None:
            d["username"] = self.username
        if self.password is not None:
            d["password"] = self.password
        return d


@dataclass
class Group:
    id: int
    name: str
    description: Optional[str] = None
    color: Optional[str] = None
    display_order: Optional[int] = None
    created_at: Optional[str] = None
    updated_at: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Group:
        return cls(
            id=d["id"], name=d["name"], description=d.get("description"),
            color=d.get("color"), display_order=d.get("displayOrder"),
            created_at=d.get("createdAt"), updated_at=d.get("updatedAt"),
        )


@dataclass
class CreateGroupRequest:
    name: str
    description: Optional[str] = None
    color: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {"name": self.name}
        if self.description is not None:
            d["description"] = self.description
        if self.color is not None:
            d["color"] = self.color
        return d


@dataclass
class Extension:
    id: int
    name: str
    path: Optional[str] = None
    description: Optional[str] = None
    icon: Optional[str] = None
    icon_data_url: Optional[str] = None
    created_at: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Extension:
        return cls(
            id=d["id"], name=d["name"], path=d.get("path"),
            description=d.get("description"), icon=d.get("icon"),
            icon_data_url=d.get("iconDataUrl"), created_at=d.get("createdAt"),
        )


@dataclass
class Automation:
    id: int
    name: str
    description: Optional[str] = None
    status: Optional[str] = None
    last_run: Optional[str] = None
    created_at: Optional[str] = None
    updated_at: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Automation:
        return cls(
            id=d["id"], name=d["name"], description=d.get("description"),
            status=d.get("status"), last_run=d.get("lastRun"),
            created_at=d.get("createdAt"), updated_at=d.get("updatedAt"),
        )


@dataclass
class RunAutomationRequest:
    profile_id: int
    delete_cookies: Optional[bool] = None
    variables: Optional[Dict[str, str]] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {"profileId": self.profile_id}
        if self.delete_cookies is not None:
            d["deleteCookies"] = self.delete_cookies
        if self.variables is not None:
            d["variables"] = self.variables
        return d


@dataclass
class RunAutomationResult:
    success: bool
    message: str
    variables: Optional[Dict[str, Any]] = None


@dataclass
class DuplicateProfileRequest:
    name: Optional[str] = None
    directory_name: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {}
        if self.name is not None:
            d["name"] = self.name
        if self.directory_name is not None:
            d["directoryName"] = self.directory_name
        return d
