package antybrowser

// StartProfileData holds the data returned when starting a profile.
type StartProfileData struct {
	DebugPort int            `json:"debugPort"`
	Extra     map[string]any `json:"-"`
}

// StartProfileResponse is returned by StartProfile.
type StartProfileResponse struct {
	Success bool              `json:"success"`
	Data    StartProfileData  `json:"data"`
}

// Profile represents a browser profile.
type Profile struct {
	ID                  int     `json:"id"`
	UserID              *int    `json:"userId"`
	UserGUID            *string `json:"userGuid"`
	Name                string  `json:"name"`
	DirectoryName       *string `json:"directoryName"`
	GroupID             *int    `json:"groupId"`
	ProxyID             *int    `json:"proxyId"`
	BrowserType         *string `json:"browserType"`
	BrowserVersion      *string `json:"browserVersion"`
	OSFingerprint       *string `json:"osFingerprint"`
	ScreenResolution    *string `json:"screenResolution"`
	ScreenMaximizable   *bool   `json:"screenMaximizable"`
	Language            *string `json:"language"`
	AcceptLanguage      *string `json:"acceptLanguage"`
	Timezone            *string `json:"timezone"`
	UseFingerprint      *bool   `json:"useFingerprint"`
	// FingerprintID is a server-owned noise seed. Read-only — never sent on create/update.
	FingerprintID       *string `json:"fingerprintId"`
	PlatformVersion     *string `json:"platformVersion"`
	BrandVersion        *string `json:"brandVersion"`
	EngineVersion       *string `json:"engineVersion"`
	GPUVendor           *string `json:"gpuVendor"`
	GPUModel            *string `json:"gpuModel"`
	HardwareConcurrency any     `json:"hardwareConcurrency"`
	DeviceMemory        any     `json:"deviceMemory"`
	DeviceScaleFactor   any     `json:"deviceScaleFactor"`
	MobileModel         *string `json:"mobileModel"`
	MobileVersion       any     `json:"mobileVersion"`
	CHPlatform          *string `json:"chPlatform"`
	CHPlatformVersion   *string `json:"chPlatformVersion"`
	CHArch              *string `json:"chArch"`
	CHBitness           *string `json:"chBitness"`
	CHModel             *string `json:"chModel"`
	CHMobile            any     `json:"chMobile"`
	DisableSpoofing     *string `json:"disableSpoofing"`
	LocationMode        *string `json:"locationMode"`
	LocationLatitude    *string `json:"locationLatitude"`
	LocationLongitude   *string `json:"locationLongitude"`
	LocationAccuracy    *string `json:"locationAccuracy"`
	UserAgent           *string `json:"userAgent"`
	RestoreSession      *bool   `json:"restoreSession"`
	LowBandwidth        *bool   `json:"lowBandwidth"`
	Notes               *string `json:"notes"`
	StartURL            *string `json:"startUrl"`
	CustomFlags         *string `json:"customFlags"`
	Status              *string `json:"status"`
	StatusMachineID     *string `json:"statusMachineId"`
	StatusHeartbeatAt   *string `json:"statusHeartbeatAt"`
	NeedsSync           *bool   `json:"needsSync"`
	LastPid             *int    `json:"lastPid"`
	DebugPort           *int    `json:"debugPort"`
	TabsSnapshot        *string `json:"tabsSnapshot"`
	Hidden              *bool   `json:"hidden"`
	Trash               *bool   `json:"trash"`
	DeletedAt           *string `json:"deletedAt"`
	CreatedAt           *string `json:"createdAt"`
	UpdatedAt           *string `json:"updatedAt"`
	LastSyncedAt        *string `json:"lastSyncedAt"`
	S3Key               *string `json:"s3Key"`
}

// CreateProfileRequest is the payload for creating a profile.
type CreateProfileRequest struct {
	Name                string  `json:"name"`
	DirectoryName       *string `json:"directoryName,omitempty"`
	GroupID             *int    `json:"groupId,omitempty"`
	ProxyID             *int    `json:"proxyId,omitempty"`
	BrowserType         *string `json:"browserType,omitempty"`
	BrowserVersion      *string `json:"browserVersion,omitempty"`
	OSFingerprint       *string `json:"osFingerprint,omitempty"`
	ScreenResolution    *string `json:"screenResolution,omitempty"`
	ScreenMaximizable   *bool   `json:"screenMaximizable,omitempty"`
	Language            *string `json:"language,omitempty"`
	AcceptLanguage      *string `json:"acceptLanguage,omitempty"`
	Timezone            *string `json:"timezone,omitempty"`
	UseFingerprint      *bool   `json:"useFingerprint,omitempty"`
	PlatformVersion     *string `json:"platformVersion,omitempty"`
	BrandVersion        *string `json:"brandVersion,omitempty"`
	EngineVersion       *string `json:"engineVersion,omitempty"`
	GPUVendor           *string `json:"gpuVendor,omitempty"`
	GPUModel            *string `json:"gpuModel,omitempty"`
	HardwareConcurrency any     `json:"hardwareConcurrency,omitempty"`
	DeviceMemory        any     `json:"deviceMemory,omitempty"`
	DeviceScaleFactor   any     `json:"deviceScaleFactor,omitempty"`
	MobileModel         *string `json:"mobileModel,omitempty"`
	MobileVersion       any     `json:"mobileVersion,omitempty"`
	CHPlatform          *string `json:"chPlatform,omitempty"`
	CHPlatformVersion   *string `json:"chPlatformVersion,omitempty"`
	CHArch              *string `json:"chArch,omitempty"`
	CHBitness           *string `json:"chBitness,omitempty"`
	CHModel             *string `json:"chModel,omitempty"`
	CHMobile            any     `json:"chMobile,omitempty"`
	DisableSpoofing     *string `json:"disableSpoofing,omitempty"`
	LocationMode        *string `json:"locationMode,omitempty"`
	LocationLatitude    *string `json:"locationLatitude,omitempty"`
	LocationLongitude   *string `json:"locationLongitude,omitempty"`
	LocationAccuracy    *string `json:"locationAccuracy,omitempty"`
	RestoreSession      *bool   `json:"restoreSession,omitempty"`
	LowBandwidth        *bool   `json:"lowBandwidth,omitempty"`
	Notes               *string `json:"notes,omitempty"`
	StartURL            *string `json:"startUrl,omitempty"`
	CustomFlags         *string `json:"customFlags,omitempty"`
	Status              *string `json:"status,omitempty"`
	Hidden              *bool   `json:"hidden,omitempty"`
}

// UpdateProfileRequest is the payload for updating a profile. Every field is optional.
type UpdateProfileRequest struct {
	Name                *string `json:"name,omitempty"`
	DirectoryName       *string `json:"directoryName,omitempty"`
	GroupID             *int    `json:"groupId,omitempty"`
	ProxyID             *int    `json:"proxyId,omitempty"`
	BrowserType         *string `json:"browserType,omitempty"`
	BrowserVersion      *string `json:"browserVersion,omitempty"`
	OSFingerprint       *string `json:"osFingerprint,omitempty"`
	ScreenResolution    *string `json:"screenResolution,omitempty"`
	ScreenMaximizable   *bool   `json:"screenMaximizable,omitempty"`
	Language            *string `json:"language,omitempty"`
	AcceptLanguage      *string `json:"acceptLanguage,omitempty"`
	Timezone            *string `json:"timezone,omitempty"`
	UseFingerprint      *bool   `json:"useFingerprint,omitempty"`
	PlatformVersion     *string `json:"platformVersion,omitempty"`
	BrandVersion        *string `json:"brandVersion,omitempty"`
	EngineVersion       *string `json:"engineVersion,omitempty"`
	GPUVendor           *string `json:"gpuVendor,omitempty"`
	GPUModel            *string `json:"gpuModel,omitempty"`
	HardwareConcurrency any     `json:"hardwareConcurrency,omitempty"`
	DeviceMemory        any     `json:"deviceMemory,omitempty"`
	DeviceScaleFactor   any     `json:"deviceScaleFactor,omitempty"`
	MobileModel         *string `json:"mobileModel,omitempty"`
	MobileVersion       any     `json:"mobileVersion,omitempty"`
	CHPlatform          *string `json:"chPlatform,omitempty"`
	CHPlatformVersion   *string `json:"chPlatformVersion,omitempty"`
	CHArch              *string `json:"chArch,omitempty"`
	CHBitness           *string `json:"chBitness,omitempty"`
	CHModel             *string `json:"chModel,omitempty"`
	CHMobile            any     `json:"chMobile,omitempty"`
	DisableSpoofing     *string `json:"disableSpoofing,omitempty"`
	LocationMode        *string `json:"locationMode,omitempty"`
	LocationLatitude    *string `json:"locationLatitude,omitempty"`
	LocationLongitude   *string `json:"locationLongitude,omitempty"`
	LocationAccuracy    *string `json:"locationAccuracy,omitempty"`
	RestoreSession      *bool   `json:"restoreSession,omitempty"`
	LowBandwidth        *bool   `json:"lowBandwidth,omitempty"`
	Notes               *string `json:"notes,omitempty"`
	StartURL            *string `json:"startUrl,omitempty"`
	CustomFlags         *string `json:"customFlags,omitempty"`
	Status              *string `json:"status,omitempty"`
	Hidden              *bool   `json:"hidden,omitempty"`
}

// Proxy represents a proxy configuration.
type Proxy struct {
	ID          int      `json:"id"`
	Name        *string  `json:"name"`
	Type        *string  `json:"type"`
	Host        *string  `json:"host"`
	Port        *int     `json:"port"`
	Username    *string  `json:"username"`
	Password    *string  `json:"password"`
	Status      *string  `json:"status"`
	CountryCode *string  `json:"countryCode"`
	IP          *string  `json:"ip"`
	Country     *string  `json:"country"`
	Timezone    *string  `json:"timezone"`
	ASN         *string  `json:"asn"`
	ISP         *string  `json:"isp"`
}

// CreateProxyRequest is the payload for creating a proxy.
type CreateProxyRequest struct {
	Name     string  `json:"name"`
	Host     string  `json:"host"`
	Port     int     `json:"port"`
	Type     string  `json:"type"`
	Username *string `json:"username,omitempty"`
	Password *string `json:"password,omitempty"`
}

// Group represents a profile group.
type Group struct {
	ID           int     `json:"id"`
	Name         string  `json:"name"`
	Description  *string `json:"description"`
	Color        *string `json:"color"`
	DisplayOrder *int    `json:"displayOrder"`
	CreatedAt    *string `json:"createdAt"`
	UpdatedAt    *string `json:"updatedAt"`
}

// CreateGroupRequest is the payload for creating a group.
type CreateGroupRequest struct {
	Name        string  `json:"name"`
	Description *string `json:"description,omitempty"`
	Color       *string `json:"color,omitempty"`
}

// Extension represents a browser extension.
type Extension struct {
	ID          int     `json:"id"`
	Name        string  `json:"name"`
	Path        *string `json:"path"`
	Description *string `json:"description"`
	Icon        *string `json:"icon"`
	IconDataURL *string `json:"iconDataUrl"`
	CreatedAt   *string `json:"createdAt"`
}

// Automation represents an automation workflow.
type Automation struct {
	ID          int     `json:"id"`
	Name        string  `json:"name"`
	Description *string `json:"description"`
	Status      *string `json:"status"`
	LastRun     *string `json:"lastRun"`
	CreatedAt   *string `json:"createdAt"`
	UpdatedAt   *string `json:"updatedAt"`
}

// RunAutomationRequest is the payload for running an automation.
type RunAutomationRequest struct {
	ProfileID    int               `json:"profileId"`
	DeleteCookies *bool            `json:"deleteCookies,omitempty"`
	Variables    map[string]string `json:"variables,omitempty"`
}

// RunAutomationResult is returned after running an automation.
type RunAutomationResult struct {
	Success   bool           `json:"success"`
	Message   string         `json:"message"`
	Variables map[string]any `json:"variables,omitempty"`
}

// DuplicateProfileRequest is the payload for duplicating a profile.
type DuplicateProfileRequest struct {
	Name          *string `json:"name,omitempty"`
	DirectoryName *string `json:"directoryName,omitempty"`
}
