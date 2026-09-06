package antybrowser

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"
)

// AntyBrowserClient is the client for the AntyBrowser Local API.
type AntyBrowserClient struct {
	apiKey     string
	baseURL    string
	httpClient *http.Client
}

// Option configures the client.
type Option func(*AntyBrowserClient)

// WithPort sets a custom API port (default 5173).
func WithPort(port int) Option {
	return func(c *AntyBrowserClient) {
		c.baseURL = fmt.Sprintf("http://127.0.0.1:%d", port)
	}
}

// WithBaseURL overrides the full base URL.
func WithBaseURL(url string) Option {
	return func(c *AntyBrowserClient) {
		c.baseURL = url
	}
}

// WithTimeout sets the HTTP client timeout.
func WithTimeout(d time.Duration) Option {
	return func(c *AntyBrowserClient) {
		c.httpClient.Timeout = d
	}
}

// WithHTTPClient sets a custom http.Client.
func WithHTTPClient(client *http.Client) Option {
	return func(c *AntyBrowserClient) {
		c.httpClient = client
	}
}

// NewClient creates a new AntyBrowser API client.
func NewClient(apiKey string, opts ...Option) *AntyBrowserClient {
	c := &AntyBrowserClient{
		apiKey:  apiKey,
		baseURL: "http://127.0.0.1:5173",
		httpClient: &http.Client{
			Timeout: 30 * time.Second,
		},
	}
	for _, opt := range opts {
		opt(c)
	}
	return c
}

// ─── System ──────────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetStatus() (*StatusResponse, error) {
	var result StatusResponse
	err := c.get("/api/status", &result)
	return &result, err
}

func (c *AntyBrowserClient) GetSettings() (*Settings, error) {
	var result Settings
	err := c.get("/api/settings", &result)
	return &result, err
}

func (c *AntyBrowserClient) GetSyncStatus() (*SyncStatus, error) {
	var result SyncStatus
	err := c.get("/api/sync/status", &result)
	return &result, err
}

func (c *AntyBrowserClient) RefreshSync(profileID *int) (map[string]any, error) {
	body := map[string]any{}
	if profileID != nil {
		body["profileId"] = *profileID
	}
	var result map[string]any
	err := c.post("/api/sync/refresh", body, &result)
	return result, err
}

// ─── Profiles ────────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetProfiles() ([]Profile, error) {
	var result []Profile
	err := c.get("/api/profiles", &result)
	return result, err
}

func (c *AntyBrowserClient) CreateProfile(req CreateProfileRequest) (*Profile, error) {
	var result Profile
	err := c.post("/api/profiles", req, &result)
	return &result, err
}

func (c *AntyBrowserClient) UpdateProfile(id int, data map[string]any) (*Profile, error) {
	var result Profile
	err := c.put(fmt.Sprintf("/api/profiles/%d", id), data, &result)
	return &result, err
}

func (c *AntyBrowserClient) DeleteProfile(id int) (map[string]any, error) {
	var result map[string]any
	err := c.delete(fmt.Sprintf("/api/profiles/%d", id), &result)
	return result, err
}

func (c *AntyBrowserClient) StartProfile(id int) (*StartProfileResponse, error) {
	var result StartProfileResponse
	err := c.post(fmt.Sprintf("/api/profiles/%d/start", id), nil, &result)
	return &result, err
}

func (c *AntyBrowserClient) StopProfile(id int) (map[string]any, error) {
	var result map[string]any
	err := c.post(fmt.Sprintf("/api/profiles/%d/stop", id), nil, &result)
	return result, err
}

func (c *AntyBrowserClient) DuplicateProfile(id int, opts *DuplicateProfileRequest) (*Profile, error) {
	var body any
	if opts != nil {
		body = opts
	}
	var result Profile
	err := c.post(fmt.Sprintf("/api/profiles/%d/duplicate", id), body, &result)
	return &result, err
}

// ─── Automations ─────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetAutomations() ([]Automation, error) {
	var result []Automation
	err := c.get("/api/automations", &result)
	return result, err
}

func (c *AntyBrowserClient) RunAutomation(id int, req RunAutomationRequest) (*RunAutomationResult, error) {
	var result RunAutomationResult
	err := c.post(fmt.Sprintf("/api/automations/%d/run", id), req, &result)
	return &result, err
}

// ─── Groups ──────────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetGroups() ([]Group, error) {
	var result []Group
	err := c.get("/api/groups", &result)
	return result, err
}

func (c *AntyBrowserClient) CreateGroup(req CreateGroupRequest) (*Group, error) {
	var result Group
	err := c.post("/api/groups", req, &result)
	return &result, err
}

func (c *AntyBrowserClient) UpdateGroup(id int, data map[string]any) (*Group, error) {
	var result Group
	err := c.put(fmt.Sprintf("/api/groups/%d", id), data, &result)
	return &result, err
}

func (c *AntyBrowserClient) DeleteGroup(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/groups/%d", id))
}

// ─── Proxies ─────────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetProxies() ([]Proxy, error) {
	var result []Proxy
	err := c.get("/api/proxies", &result)
	return result, err
}

func (c *AntyBrowserClient) CreateProxy(req CreateProxyRequest) (*Proxy, error) {
	var result Proxy
	err := c.post("/api/proxies", req, &result)
	return &result, err
}

func (c *AntyBrowserClient) CheckProxy(host string, port int, username, password, proxyType *string) (*ProxyCheckResult, error) {
	body := map[string]any{"host": host, "port": port}
	if username != nil {
		body["username"] = *username
	}
	if password != nil {
		body["password"] = *password
	}
	if proxyType != nil {
		body["type"] = *proxyType
	}
	var result ProxyCheckResult
	err := c.post("/api/proxies/check", body, &result)
	return &result, err
}

func (c *AntyBrowserClient) CheckProxiesBulk(proxies []any) ([]ProxyCheckResult, error) {
	body := map[string]any{"proxies": proxies}
	var raw struct {
		Results []ProxyCheckResult `json:"results"`
	}
	err := c.post("/api/proxies/check-bulk", body, &raw)
	return raw.Results, err
}

func (c *AntyBrowserClient) DeleteProxy(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/proxies/%d", id))
}

// ─── Extensions ──────────────────────────────────────────────────────────

func (c *AntyBrowserClient) GetExtensions() ([]Extension, error) {
	var result []Extension
	err := c.get("/api/extensions", &result)
	return result, err
}

func (c *AntyBrowserClient) DeleteExtension(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/extensions/%d", id))
}

func (c *AntyBrowserClient) GetProfileExtensions(profileID int, details bool) ([]Extension, error) {
	var result []Extension
	err := c.get(fmt.Sprintf("/api/profiles/%d/extensions?details=%t", profileID, details), &result)
	return result, err
}

func (c *AntyBrowserClient) SetProfileExtensions(profileID int, extensionIDs []int) (map[string]any, error) {
	body := map[string]any{"extensionIds": extensionIDs}
	var result map[string]any
	err := c.post(fmt.Sprintf("/api/profiles/%d/extensions", profileID), body, &result)
	return result, err
}

// ─── HTTP Helpers ────────────────────────────────────────────────────────

func (c *AntyBrowserClient) doRequest(method, path string, body any, result any) error {
	var bodyReader io.Reader
	if body != nil {
		data, err := json.Marshal(body)
		if err != nil {
			return fmt.Errorf("marshal body: %w", err)
		}
		bodyReader = bytes.NewReader(data)
	}

	req, err := http.NewRequest(method, c.baseURL+path, bodyReader)
	if err != nil {
		return fmt.Errorf("create request: %w", err)
	}
	req.Header.Set("x-api-key", c.apiKey)
	req.Header.Set("Content-Type", "application/json")

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return fmt.Errorf("request failed (is AntyBrowser running?): %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("read response: %w", err)
	}

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return &AntyBrowserError{
			Message:      fmt.Sprintf("API request failed with status %d", resp.StatusCode),
			StatusCode:   resp.StatusCode,
			ResponseBody: string(respBody),
		}
	}

	if result != nil && len(respBody) > 0 {
		if err := json.Unmarshal(respBody, result); err != nil {
			return &AntyBrowserError{
				Message:      "Invalid JSON response from API",
				StatusCode:   resp.StatusCode,
				ResponseBody: string(respBody),
			}
		}
	}
	return nil
}

func (c *AntyBrowserClient) get(path string, result any) error {
	return c.doRequest(http.MethodGet, path, nil, result)
}

func (c *AntyBrowserClient) post(path string, body any, result any) error {
	return c.doRequest(http.MethodPost, path, body, result)
}

func (c *AntyBrowserClient) put(path string, body any, result any) error {
	return c.doRequest(http.MethodPut, path, body, result)
}

func (c *AntyBrowserClient) delete(path string, result any) error {
	return c.doRequest(http.MethodDelete, path, nil, result)
}

func (c *AntyBrowserClient) deleteNoBody(path string) error {
	return c.doRequest(http.MethodDelete, path, nil, nil)
}
