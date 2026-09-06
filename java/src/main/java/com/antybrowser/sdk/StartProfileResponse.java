package com.antybrowser.sdk;

import java.util.Map;

public class StartProfileResponse {
    private boolean success;
    private Map<String, Object> data;

    public boolean isSuccess() { return success; }
    public Map<String, Object> getData() { return data; }

    public Integer getDebugPort() {
        if (data == null || !data.containsKey("debugPort")) return null;
        Object v = data.get("debugPort");
        return v instanceof Number ? ((Number) v).intValue() : null;
    }
}
