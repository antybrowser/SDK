package com.antybrowser.sdk;

// Payload for creating or updating a profile. Every field is optional except name.
// fingerprintId is server-generated and tlsGrease is retired, so neither is part of this request.
public class CreateProfileRequest {
    private String name;
    private String directoryName;
    private Integer groupId;
    private Integer proxyId;
    // Chrome, Edge, Opera, Vivaldi or Brave. Chromium is not a brand - it folds to Chrome.
    private String browserType;
    private String browserVersion;
    private String osFingerprint;
    private String screenResolution;
    private Boolean screenMaximizable;
    private String language;
    private String acceptLanguage;
    private String timezone;
    private Boolean useFingerprint;
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
    // "" (off), "proxy" (based on the exit IP) or "manual".
    private String locationMode;
    private String locationLatitude;
    private String locationLongitude;
    private String locationAccuracy;
    private Boolean restoreSession;
    private Boolean lowBandwidth;
    private String notes;
    private String startUrl;
    private String customFlags;
    private String status;
    private Boolean hidden;

    public CreateProfileRequest setName(String name) { this.name = name; return this; }
    public CreateProfileRequest setDirectoryName(String directoryName) { this.directoryName = directoryName; return this; }
    public CreateProfileRequest setGroupId(Integer groupId) { this.groupId = groupId; return this; }
    public CreateProfileRequest setProxyId(Integer proxyId) { this.proxyId = proxyId; return this; }
    public CreateProfileRequest setBrowserType(String browserType) { this.browserType = browserType; return this; }
    public CreateProfileRequest setBrowserVersion(String browserVersion) { this.browserVersion = browserVersion; return this; }
    public CreateProfileRequest setOsFingerprint(String osFingerprint) { this.osFingerprint = osFingerprint; return this; }
    public CreateProfileRequest setScreenResolution(String screenResolution) { this.screenResolution = screenResolution; return this; }
    public CreateProfileRequest setScreenMaximizable(Boolean screenMaximizable) { this.screenMaximizable = screenMaximizable; return this; }
    public CreateProfileRequest setLanguage(String language) { this.language = language; return this; }
    public CreateProfileRequest setAcceptLanguage(String acceptLanguage) { this.acceptLanguage = acceptLanguage; return this; }
    public CreateProfileRequest setTimezone(String timezone) { this.timezone = timezone; return this; }
    public CreateProfileRequest setUseFingerprint(Boolean useFingerprint) { this.useFingerprint = useFingerprint; return this; }
    public CreateProfileRequest setPlatformVersion(String platformVersion) { this.platformVersion = platformVersion; return this; }
    public CreateProfileRequest setBrandVersion(String brandVersion) { this.brandVersion = brandVersion; return this; }
    public CreateProfileRequest setEngineVersion(String engineVersion) { this.engineVersion = engineVersion; return this; }
    public CreateProfileRequest setGpuVendor(String gpuVendor) { this.gpuVendor = gpuVendor; return this; }
    public CreateProfileRequest setGpuModel(String gpuModel) { this.gpuModel = gpuModel; return this; }
    public CreateProfileRequest setHardwareConcurrency(Object hardwareConcurrency) { this.hardwareConcurrency = hardwareConcurrency; return this; }
    public CreateProfileRequest setDeviceMemory(Object deviceMemory) { this.deviceMemory = deviceMemory; return this; }
    public CreateProfileRequest setDeviceScaleFactor(Object deviceScaleFactor) { this.deviceScaleFactor = deviceScaleFactor; return this; }
    public CreateProfileRequest setMobileModel(String mobileModel) { this.mobileModel = mobileModel; return this; }
    public CreateProfileRequest setMobileVersion(Object mobileVersion) { this.mobileVersion = mobileVersion; return this; }
    public CreateProfileRequest setChPlatform(String chPlatform) { this.chPlatform = chPlatform; return this; }
    public CreateProfileRequest setChPlatformVersion(String chPlatformVersion) { this.chPlatformVersion = chPlatformVersion; return this; }
    public CreateProfileRequest setChArch(String chArch) { this.chArch = chArch; return this; }
    public CreateProfileRequest setChBitness(String chBitness) { this.chBitness = chBitness; return this; }
    public CreateProfileRequest setChModel(String chModel) { this.chModel = chModel; return this; }
    public CreateProfileRequest setChMobile(Object chMobile) { this.chMobile = chMobile; return this; }
    public CreateProfileRequest setDisableSpoofing(String disableSpoofing) { this.disableSpoofing = disableSpoofing; return this; }
    public CreateProfileRequest setLocationMode(String locationMode) { this.locationMode = locationMode; return this; }
    public CreateProfileRequest setLocationLatitude(String locationLatitude) { this.locationLatitude = locationLatitude; return this; }
    public CreateProfileRequest setLocationLongitude(String locationLongitude) { this.locationLongitude = locationLongitude; return this; }
    public CreateProfileRequest setLocationAccuracy(String locationAccuracy) { this.locationAccuracy = locationAccuracy; return this; }
    public CreateProfileRequest setRestoreSession(Boolean restoreSession) { this.restoreSession = restoreSession; return this; }
    public CreateProfileRequest setLowBandwidth(Boolean lowBandwidth) { this.lowBandwidth = lowBandwidth; return this; }
    public CreateProfileRequest setNotes(String notes) { this.notes = notes; return this; }
    public CreateProfileRequest setStartUrl(String startUrl) { this.startUrl = startUrl; return this; }
    public CreateProfileRequest setCustomFlags(String customFlags) { this.customFlags = customFlags; return this; }
    public CreateProfileRequest setStatus(String status) { this.status = status; return this; }
    public CreateProfileRequest setHidden(Boolean hidden) { this.hidden = hidden; return this; }
}
