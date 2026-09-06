from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Union


@dataclass
class StatusResponse:
    success: bool
    status: str
    version: str


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
    directory_name: Optional[str] = None
    group_id: Optional[int] = None
    proxy_id: Optional[int] = None
    browser_type: Optional[str] = None
    browser_version: Optional[str] = None
    os_fingerprint: Optional[str] = None
    screen_resolution: Optional[str] = None
    language: Optional[str] = None
    accept_language: Optional[str] = None
    timezone: Optional[str] = None
    use_fingerprint: Optional[bool] = None
    fingerprint_id: Optional[str] = None
    restore_session: Optional[bool] = None
    low_bandwidth: Optional[bool] = None
    notes: Optional[str] = None
    start_url: Optional[str] = None
    custom_flags: Optional[str] = None
    status: Optional[str] = None
    needs_sync: Optional[bool] = None
    last_pid: Optional[int] = None
    debug_port: Optional[int] = None
    created_at: Optional[str] = None
    updated_at: Optional[str] = None
    last_synced_at: Optional[str] = None
    s3_key: Optional[str] = None
    trash: Optional[bool] = None
    deleted_at: Optional[str] = None
    hidden: Optional[bool] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Profile:
        known = {f.name for f in cls.__dataclass_fields__.values()} | {"extra"}
        extra = {k: v for k, v in d.items() if k not in known}
        return cls(
            id=d["id"],
            name=d["name"],
            directory_name=d.get("directoryName"),
            group_id=d.get("groupId"),
            proxy_id=d.get("proxyId"),
            browser_type=d.get("browserType"),
            browser_version=d.get("browserVersion"),
            os_fingerprint=d.get("osFingerprint"),
            screen_resolution=d.get("screenResolution"),
            language=d.get("language"),
            accept_language=d.get("acceptLanguage"),
            timezone=d.get("timezone"),
            use_fingerprint=d.get("useFingerprint"),
            fingerprint_id=d.get("fingerprintId"),
            restore_session=d.get("restoreSession"),
            low_bandwidth=d.get("lowBandwidth"),
            notes=d.get("notes"),
            start_url=d.get("startUrl"),
            custom_flags=d.get("customFlags"),
            status=d.get("status"),
            needs_sync=d.get("needsSync"),
            last_pid=d.get("lastPid"),
            debug_port=d.get("debugPort"),
            created_at=d.get("createdAt"),
            updated_at=d.get("updatedAt"),
            last_synced_at=d.get("lastSyncedAt"),
            s3_key=d.get("s3Key"),
            trash=d.get("trash"),
            deleted_at=d.get("deletedAt"),
            hidden=d.get("hidden"),
            extra=extra,
        )


@dataclass
class CreateProfileRequest:
    name: str
    directory_name: Optional[str] = None
    group_id: Optional[int] = None
    proxy_id: Optional[int] = None
    browser_type: Optional[str] = None
    os_fingerprint: Optional[str] = None
    screen_resolution: Optional[str] = None
    language: Optional[str] = None
    accept_language: Optional[str] = None
    timezone: Optional[str] = None
    use_fingerprint: Optional[bool] = None
    fingerprint_id: Optional[str] = None
    restore_session: Optional[bool] = None
    low_bandwidth: Optional[bool] = None
    notes: Optional[str] = None
    start_url: Optional[str] = None
    custom_flags: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        d: Dict[str, Any] = {"name": self.name}
        mapping = {
            "directory_name": "directoryName", "group_id": "groupId",
            "proxy_id": "proxyId", "browser_type": "browserType",
            "os_fingerprint": "osFingerprint", "screen_resolution": "screenResolution",
            "accept_language": "acceptLanguage", "use_fingerprint": "useFingerprint",
            "fingerprint_id": "fingerprintId", "restore_session": "restoreSession",
            "low_bandwidth": "lowBandwidth", "start_url": "startUrl",
            "custom_flags": "customFlags",
        }
        for py_key, api_key in mapping.items():
            val = getattr(self, py_key)
            if val is not None:
                d[api_key] = val
        for attr in ("language", "timezone", "notes"):
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
class ProxyCheckResult:
    success: bool
    details: Optional[Dict[str, Any]] = None
    error_message: Optional[str] = None


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
class Settings:
    id: Optional[int] = None
    chrome_path: Optional[str] = None
    api_key: Optional[str] = None
    language: Optional[str] = None
    extra: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> Settings:
        return cls(
            id=d.get("id"), chrome_path=d.get("chromePath"),
            api_key=d.get("apiKey"), language=d.get("language"),
            extra={k: v for k, v in d.items() if k not in ("id", "chromePath", "apiKey", "language")},
        )


@dataclass
class SyncStatus:
    total: int
    completed: int
    is_syncing: bool
    active: List[Any] = field(default_factory=list)
    active_extensions: List[Any] = field(default_factory=list)
    errors: Dict[str, Any] = field(default_factory=dict)
    progress: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> SyncStatus:
        return cls(
            total=d.get("total", 0), completed=d.get("completed", 0),
            is_syncing=d.get("isSyncing", False), active=d.get("active", []),
            active_extensions=d.get("activeExtensions", []),
            errors=d.get("errors", {}), progress=d.get("progress", {}),
        )


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
