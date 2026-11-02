"""Official Antybrowser SDK — Python client for the Antybrowser Local API."""

from antybrowser.client import AntybrowserClient
from antybrowser.errors import AntybrowserError
from antybrowser.types import (
    Profile,
    CreateProfileRequest,
    Proxy,
    CreateProxyRequest,
    Group,
    CreateGroupRequest,
    Extension,
    Automation,
    RunAutomationRequest,
    RunAutomationResult,
    StartProfileResponse,
    DuplicateProfileRequest,
)

__version__ = "1.0.2"
__all__ = [
    "AntybrowserClient",
    "AntybrowserError",
    "Profile",
    "CreateProfileRequest",
    "Proxy",
    "CreateProxyRequest",
    "Group",
    "CreateGroupRequest",
    "Extension",
    "Automation",
    "RunAutomationRequest",
    "RunAutomationResult",
    "StartProfileResponse",
    "DuplicateProfileRequest",
]
