package antybrowser

// StatusResponse represents the API health check response.
type StatusResponse struct {
	Success bool   `json:"success"`
	Status  string `json:"status"`
	Version string `json:"version"`
}

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
	ID              int     `json:"id"`
	Name            string  `json:"name"`
	DirectoryName   *string `json:"directoryName"`
	GroupID         *int    `json:"groupId"`
	ProxyID         *int    `json:"proxyId"`
	BrowserType     *string `json:"browserType"`
	BrowserVersion  *string `json:"browserVersion"`
	OSFingerprint   *string `json:"osFingerprint"`
	ScreenResolution *string `json:"screenResolution"`
	Language        *string `json:"language"`
	AcceptLanguage  *string `json:"acceptLanguage"`
	Timezone        *string `json:"timezone"`
	UseFingerprint  *bool   `json:"useFingerprint"`
	FingerprintID   *string `json:"fingerprintId"`
	RestoreSession  *bool   `json:"restoreSession"`
	LowBandwidth    *bool   `json:"lowBandwidth"`
	Notes           *string `json:"notes"`
	StartURL        *string `json:"startUrl"`
	CustomFlags     *string `json:"customFlags"`
	Status          *string `json:"status"`
	NeedsSync       *bool   `json:"needsSync"`
	LastPid         *int    `json:"lastPid"`
	DebugPort       *int    `json:"debugPort"`
	CreatedAt       *string `json:"createdAt"`
	UpdatedAt       *string `json:"updatedAt"`
	LastSyncedAt    *string `json:"lastSyncedAt"`
	S3Key           *string `json:"s3Key"`
	Trash           *bool   `json:"trash"`
	DeletedAt       *string `json:"deletedAt"`
	Hidden          *bool   `json:"hidden"`
}

// CreateProfileRequest is the payload for creating a profile.
type CreateProfileRequest struct {
	Name             string  `json:"name"`
	DirectoryName    *string `json:"directoryName,omitempty"`
	GroupID          *int    `json:"groupId,omitempty"`
	ProxyID          *int    `json:"proxyId,omitempty"`
	BrowserType      *string `json:"browserType,omitempty"`
	OSFingerprint    *string `json:"osFingerprint,omitempty"`
	ScreenResolution *string `json:"screenResolution,omitempty"`
	Language         *string `json:"language,omitempty"`
	AcceptLanguage   *string `json:"acceptLanguage,omitempty"`
	Timezone         *string `json:"timezone,omitempty"`
	UseFingerprint   *bool   `json:"useFingerprint,omitempty"`
	FingerprintID    *string `json:"fingerprintId,omitempty"`
	RestoreSession   *bool   `json:"restoreSession,omitempty"`
	LowBandwidth     *bool   `json:"lowBandwidth,omitempty"`
	Notes            *string `json:"notes,omitempty"`
	StartURL         *string `json:"startUrl,omitempty"`
	CustomFlags      *string `json:"customFlags,omitempty"`
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

// ProxyCheckResult is returned when checking a proxy.
type ProxyCheckResult struct {
	Success      bool              `json:"success"`
	Details      map[string]any    `json:"details,omitempty"`
	ErrorMessage *string           `json:"errorMessage,omitempty"`
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

// Settings represents the Antybrowser settings.
type Settings struct {
	ID            *int    `json:"id"`
	ChromePath    *string `json:"chromePath"`
	APIKey        *string `json:"apiKey"`
	Language      *string `json:"language"`
}

// SyncStatus represents the sync queue state.
type SyncStatus struct {
	Active           []any          `json:"active"`
	ActiveExtensions []any          `json:"activeExtensions"`
	Total            int            `json:"total"`
	Completed        int            `json:"completed"`
	Errors           map[string]any `json:"errors"`
	Progress         map[string]any `json:"progress"`
	IsSyncing        bool           `json:"isSyncing"`
}

// DuplicateProfileRequest is the payload for duplicating a profile.
type DuplicateProfileRequest struct {
	Name          *string `json:"name,omitempty"`
	DirectoryName *string `json:"directoryName,omitempty"`
}
