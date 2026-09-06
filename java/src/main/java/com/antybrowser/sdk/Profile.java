package com.antybrowser.sdk;

public class Profile {
    private int id;
    private String name;
    private String directoryName;
    private Integer groupId;
    private Integer proxyId;
    private String browserType;
    private String browserVersion;
    private String osFingerprint;
    private String screenResolution;
    private String language;
    private String acceptLanguage;
    private String timezone;
    private Boolean useFingerprint;
    private String fingerprintId;
    private Boolean restoreSession;
    private Boolean lowBandwidth;
    private String notes;
    private String startUrl;
    private String customFlags;
    private String status;
    private Boolean needsSync;
    private Integer lastPid;
    private Integer debugPort;
    private String createdAt;
    private String updatedAt;

    public int getId() { return id; }
    public String getName() { return name; }
    public String getDirectoryName() { return directoryName; }
    public Integer getGroupId() { return groupId; }
    public Integer getProxyId() { return proxyId; }
    public String getBrowserType() { return browserType; }
    public String getBrowserVersion() { return browserVersion; }
    public String getOsFingerprint() { return osFingerprint; }
    public String getScreenResolution() { return screenResolution; }
    public String getLanguage() { return language; }
    public String getAcceptLanguage() { return acceptLanguage; }
    public String getTimezone() { return timezone; }
    public Boolean getUseFingerprint() { return useFingerprint; }
    public String getFingerprintId() { return fingerprintId; }
    public Boolean getRestoreSession() { return restoreSession; }
    public Boolean getLowBandwidth() { return lowBandwidth; }
    public String getNotes() { return notes; }
    public String getStartUrl() { return startUrl; }
    public String getCustomFlags() { return customFlags; }
    public String getStatus() { return status; }
    public Boolean getNeedsSync() { return needsSync; }
    public Integer getLastPid() { return lastPid; }
    public Integer getDebugPort() { return debugPort; }
    public String getCreatedAt() { return createdAt; }
    public String getUpdatedAt() { return updatedAt; }
}
