package com.antybrowser.sdk;

public class AntybrowserException extends RuntimeException {
    private final int statusCode;
    private final String responseBody;

    public AntybrowserException(String message) {
        this(message, 0, null);
    }

    public AntybrowserException(String message, int statusCode, String responseBody) {
        super(message);
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public int getStatusCode() { return statusCode; }
    public String getResponseBody() { return responseBody; }
}
