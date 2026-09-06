"""Official Antybrowser SDK — Python client for the Antybrowser Local API."""

from antybrowser.client import AntyBrowserClient
from antybrowser.errors import AntyBrowserError
from antybrowser.types import (
    Profile,
    CreateProfileRequest,
    Proxy,
    CreateProxyRequest,
    ProxyCheckResult,
    Group,
    CreateGroupRequest,
    Extension,
    Automation,
    RunAutomationRequest,
    RunAutomationResult,
    Settings,
    SyncStatus,
    StatusResponse,
    StartProfileResponse,
    DuplicateProfileRequest,
)

__version__ = "1.0.2"
__all__ = [
    "AntyBrowserClient",
    "AntyBrowserError",
    "Profile",
    "CreateProfileRequest",
    "Proxy",
    "CreateProxyRequest",
    "ProxyCheckResult",
    "Group",
    "CreateGroupRequest",
    "Extension",
    "Automation",
    "RunAutomationRequest",
    "RunAutomationResult",
    "Settings",
    "SyncStatus",
    "StatusResponse",
    "StartProfileResponse",
    "DuplicateProfileRequest",
]
