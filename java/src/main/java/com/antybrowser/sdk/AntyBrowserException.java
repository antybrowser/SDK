package com.antybrowser.sdk;

public class AntyBrowserException extends RuntimeException {
    private final int statusCode;
    private final String responseBody;

    public AntyBrowserException(String message) {
        this(message, 0, null);
    }

    public AntyBrowserException(String message, int statusCode, String responseBody) {
        super(message);
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public int getStatusCode() { return statusCode; }
    public String getResponseBody() { return responseBody; }
}
