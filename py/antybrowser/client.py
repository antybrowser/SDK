from __future__ import annotations

from typing import Any, Dict, List, Optional

import httpx

from antybrowser.errors import AntybrowserError
from antybrowser.types import (
    Automation,
    CreateGroupRequest,
    CreateProfileRequest,
    CreateProxyRequest,
    Extension,
    Group,
    Profile,
    Proxy,
    RunAutomationRequest,
    RunAutomationResult,
    StartProfileData,
    StartProfileResponse,
    DuplicateProfileRequest,
)


class AntybrowserClient:
    """Client for the Antybrowser Local API.

    Args:
        api_key: Your Antybrowser API key.
        port: Local API port (default 5173).
        base_url: Full base URL override (overrides port).
        timeout: Request timeout in seconds (default 30).
    """

    def __init__(
        self,
        api_key: str,
        port: int = 5173,
        base_url: Optional[str] = None,
        timeout: float = 30.0,
    ):
        self._api_key = api_key
        self._base_url = base_url or f"http://127.0.0.1:{port}"
        self._client = httpx.AsyncClient(
            base_url=self._base_url,
            headers={"x-api-key": api_key, "Content-Type": "application/json"},
            timeout=timeout,
        )

    async def close(self) -> None:
        await self._client.aclose()

    async def __aenter__(self) -> AntybrowserClient:
        return self

    async def __aexit__(self, *args: Any) -> None:
        await self.close()

    # ─── Profiles ────────────────────────────────────────────────────────

    async def get_profiles(self) -> List[Profile]:
        data = await self._get("/api/profiles")
        return [Profile.from_dict(p) for p in data]

    async def create_profile(self, request: CreateProfileRequest) -> Profile:
        data = await self._post("/api/profiles", request.to_dict())
        return Profile.from_dict(data)

    async def update_profile(self, profile_id: int, **kwargs: Any) -> Profile:
        data = await self._put(f"/api/profiles/{profile_id}", kwargs)
        return Profile.from_dict(data)

    async def delete_profile(self, profile_id: int) -> Dict[str, Any]:
        return await self._delete(f"/api/profiles/{profile_id}")

    async def start_profile(self, profile_id: int) -> StartProfileResponse:
        data = await self._post(f"/api/profiles/{profile_id}/start")
        return StartProfileResponse(
            success=data.get("success", False),
            data=StartProfileData(
                debug_port=data.get("data", {}).get("debugPort"),
                extra={k: v for k, v in data.get("data", {}).items() if k != "debugPort"},
            ),
        )

    async def stop_profile(self, profile_id: int) -> Dict[str, Any]:
        return await self._post(f"/api/profiles/{profile_id}/stop")

    async def duplicate_profile(
        self, profile_id: int, options: Optional[DuplicateProfileRequest] = None
    ) -> Profile:
        body = options.to_dict() if options else {}
        data = await self._post(f"/api/profiles/{profile_id}/duplicate", body)
        return Profile.from_dict(data)

    # ─── Automations ─────────────────────────────────────────────────────

    async def get_automations(self) -> List[Automation]:
        data = await self._get("/api/automations")
        return [Automation.from_dict(a) for a in data]

    async def run_automation(
        self, automation_id: int, request: RunAutomationRequest
    ) -> RunAutomationResult:
        data = await self._post(f"/api/automations/{automation_id}/run", request.to_dict())
        return RunAutomationResult(
            success=data.get("success", False),
            message=data.get("message", ""),
            variables=data.get("variables"),
        )

    # ─── Groups ──────────────────────────────────────────────────────────

    async def get_groups(self) -> List[Group]:
        data = await self._get("/api/groups")
        return [Group.from_dict(g) for g in data]

    async def create_group(self, request: CreateGroupRequest) -> Group:
        data = await self._post("/api/groups", request.to_dict())
        return Group.from_dict(data)

    async def update_group(self, group_id: int, **kwargs: Any) -> Group:
        data = await self._put(f"/api/groups/{group_id}", kwargs)
        return Group.from_dict(data)

    async def delete_group(self, group_id: int) -> None:
        await self._delete(f"/api/groups/{group_id}")

    # ─── Proxies ─────────────────────────────────────────────────────────

    async def get_proxies(self) -> List[Proxy]:
        data = await self._get("/api/proxies")
        return [Proxy.from_dict(p) for p in data]

    async def create_proxy(self, request: CreateProxyRequest) -> Proxy:
        data = await self._post("/api/proxies", request.to_dict())
        return Proxy.from_dict(data)

    async def delete_proxy(self, proxy_id: int) -> None:
        await self._delete(f"/api/proxies/{proxy_id}")

    # ─── Extensions ──────────────────────────────────────────────────────

    async def get_extensions(self) -> List[Extension]:
        data = await self._get("/api/extensions")
        return [Extension.from_dict(e) for e in data]

    async def delete_extension(self, extension_id: int) -> None:
        await self._delete(f"/api/extensions/{extension_id}")

    # ─── HTTP Helpers ────────────────────────────────────────────────────

    async def _get(self, path: str) -> Any:
        try:
            resp = await self._client.get(path)
        except httpx.HTTPError as e:
            raise AntybrowserError(f"Failed to connect to Antybrowser: {e}")
        return self._handle(resp)

    async def _post(self, path: str, body: Optional[Dict[str, Any]] = None) -> Any:
        try:
            resp = await self._client.post(path, json=body or {})
        except httpx.HTTPError as e:
            raise AntybrowserError(f"Failed to connect to Antybrowser: {e}")
        return self._handle(resp)

    async def _put(self, path: str, body: Dict[str, Any]) -> Any:
        try:
            resp = await self._client.put(path, json=body)
        except httpx.HTTPError as e:
            raise AntybrowserError(f"Failed to connect to Antybrowser: {e}")
        return self._handle(resp)

    async def _delete(self, path: str) -> Any:
        try:
            resp = await self._client.delete(path)
        except httpx.HTTPError as e:
            raise AntybrowserError(f"Failed to connect to Antybrowser: {e}")
        return self._handle(resp)

    def _handle(self, resp: httpx.Response) -> Any:
        if not resp.is_success:
            raise AntybrowserError(
                f"API request failed with status {resp.status_code}",
                status_code=resp.status_code,
                response_body=resp.text,
            )
        if not resp.text or not resp.text.strip():
            return {}
        try:
            return resp.json()
        except Exception:
            raise AntybrowserError(
                "Invalid JSON response from API",
                status_code=resp.status_code,
                response_body=resp.text,
            )
