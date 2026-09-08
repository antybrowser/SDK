const std = @import("std");

pub const ApiError = error{
    BadRequest,
    Unauthorized,
    Forbidden,
    NotFound,
    Conflict,
    UnprocessableEntity,
    TooManyRequests,
    InternalServerError,
    BadGateway,
    ServiceUnavailable,
    GatewayTimeout,
    Unknown,
};

pub const HttpError = error{
    ConnectionRefused,
    ConnectionReset,
    TimedOut,
    TlsInitFailed,
    HttpError,
    UriParseError,
    OutOfMemory,
};

pub const JsonError = error{
    JsonParseError,
    JsonUnexpectedEof,
    JsonInvalidCharacter,
    JsonUnknownField,
    JsonMissingField,
    OutOfMemory,
};

pub const AntybrowserError = ApiError || HttpError || JsonError;

pub fn httpStatusToApiError(status: u16) ApiError {
    return switch (status) {
        400 => error.BadRequest,
        401 => error.Unauthorized,
        403 => error.Forbidden,
        404 => error.NotFound,
        409 => error.Conflict,
        422 => error.UnprocessableEntity,
        429 => error.TooManyRequests,
        500 => error.InternalServerError,
        502 => error.BadGateway,
        503 => error.ServiceUnavailable,
        504 => error.GatewayTimeout,
        else => error.Unknown,
    };
}

pub fn apiErrorToString(err: ApiError) []const u8 {
    return switch (err) {
        error.BadRequest => "Bad Request",
        error.Unauthorized => "Unauthorized",
        error.Forbidden => "Forbidden",
        error.NotFound => "Not Found",
        error.Conflict => "Conflict",
        error.UnprocessableEntity => "Unprocessable Entity",
        error.TooManyRequests => "Too Many Requests",
        error.InternalServerError => "Internal Server Error",
        error.BadGateway => "Bad Gateway",
        error.ServiceUnavailable => "Service Unavailable",
        error.GatewayTimeout => "Gateway Timeout",
        error.Unknown => "Unknown Error",
    };
}
