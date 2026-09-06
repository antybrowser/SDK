from __future__ import annotations

from typing import Any, Optional


class AntybrowserError(Exception):
    """Raised when the Antybrowser API returns an error."""

    def __init__(
        self,
        message: str,
        status_code: Optional[int] = None,
        response_body: Optional[str] = None,
    ):
        super().__init__(message)
        self.status_code = status_code
        self.response_body = response_body
