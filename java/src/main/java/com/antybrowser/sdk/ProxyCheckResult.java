package com.antybrowser.sdk;

public class ProxyCheckResult {
    private boolean success;
    private java.util.Map<String, Object> details;
    private String errorMessage;

    public boolean isSuccess() { return success; }
    public java.util.Map<String, Object> getDetails() { return details; }
    public String getErrorMessage() { return errorMessage; }
}
