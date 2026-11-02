package com.antybrowser.sdk;

public class Profile {
    private int id;
    private Integer userId;
    private String userGuid;
    private String name;
    private String directoryName;
    private Integer groupId;
    private Integer proxyId;
    private String browserType;
    private String browserVersion;
    private String osFingerprint;
    private String screenResolution;
    private Boolean screenMaximizable;
    private String language;
    private String acceptLanguage;
    private String timezone;
    private Boolean useFingerprint;
    // Server-owned noise seed. Read-only - never sent on create/update.
    private String fingerprintId;
    private String platformVersion;
    private String brandVersion;
    private String engineVersion;
    private String gpuVendor;
    private String gpuModel;
    private Object hardwareConcurrency;
    private Object deviceMemory;
    private Object deviceScaleFactor;
    private String mobileModel;
    private Object mobileVersion;
    private String chPlatform;
    private String chPlatformVersion;
    private String chArch;
    private String chBitness;
    private String chModel;
    private Object chMobile;
    private String disableSpoofing;
    private String locationMode;
    private String locationLatitude;
    private String locationLongitude;
    private String locationAccuracy;
    private String userAgent;
    private Boolean restoreSession;
    private Boolean lowBandwidth;
    private String notes;
    private String startUrl;
    private String customFlags;
    private String status;
    private String statusMachineId;
    private String statusHeartbeatAt;
    private Boolean needsSync;
    private Integer lastPid;
    private Integer debugPort;
    private String tabsSnapshot;
    private String createdAt;
    private String updatedAt;

    public int getId() { return id; }
    public Integer getUserId() { return userId; }
    public String getUserGuid() { return userGuid; }
    public String getName() { return name; }
    public String getDirectoryName() { return directoryName; }
    public Integer getGroupId() { return groupId; }
    public Integer getProxyId() { return proxyId; }
    public String getBrowserType() { return browserType; }
    public String getBrowserVersion() { return browserVersion; }
    public String getOsFingerprint() { return osFingerprint; }
    public String getScreenResolution() { return screenResolution; }
    public Boolean getScreenMaximizable() { return screenMaximizable; }
    public String getLanguage() { return language; }
    public String getAcceptLanguage() { return acceptLanguage; }
    public String getTimezone() { return timezone; }
    public Boolean getUseFingerprint() { return useFingerprint; }
    public String getFingerprintId() { return fingerprintId; }
    public String getPlatformVersion() { return platformVersion; }
    public String getBrandVersion() { return brandVersion; }
    public String getEngineVersion() { return engineVersion; }
    public String getGpuVendor() { return gpuVendor; }
    public String getGpuModel() { return gpuModel; }
    public Object getHardwareConcurrency() { return hardwareConcurrency; }
    public Object getDeviceMemory() { return deviceMemory; }
    public Object getDeviceScaleFactor() { return deviceScaleFactor; }
    public String getMobileModel() { return mobileModel; }
    public Object getMobileVersion() { return mobileVersion; }
    public String getChPlatform() { return chPlatform; }
    public String getChPlatformVersion() { return chPlatformVersion; }
    public String getChArch() { return chArch; }
    public String getChBitness() { return chBitness; }
    public String getChModel() { return chModel; }
    public Object getChMobile() { return chMobile; }
    public String getDisableSpoofing() { return disableSpoofing; }
    public String getLocationMode() { return locationMode; }
    public String getLocationLatitude() { return locationLatitude; }
    public String getLocationLongitude() { return locationLongitude; }
    public String getLocationAccuracy() { return locationAccuracy; }
    public String getUserAgent() { return userAgent; }
    public Boolean getRestoreSession() { return restoreSession; }
    public Boolean getLowBandwidth() { return lowBandwidth; }
    public String getNotes() { return notes; }
    public String getStartUrl() { return startUrl; }
    public String getCustomFlags() { return customFlags; }
    public String getStatus() { return status; }
    public String getStatusMachineId() { return statusMachineId; }
    public String getStatusHeartbeatAt() { return statusHeartbeatAt; }
    public Boolean getNeedsSync() { return needsSync; }
    public Integer getLastPid() { return lastPid; }
    public Integer getDebugPort() { return debugPort; }
    public String getTabsSnapshot() { return tabsSnapshot; }
    public String getCreatedAt() { return createdAt; }
    public String getUpdatedAt() { return updatedAt; }
}
