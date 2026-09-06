"""Official AntyBrowser SDK — Python client for the AntyBrowser Local API."""

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

__version__ = "1.0.1"
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
