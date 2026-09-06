package antybrowser

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"
)

// AntybrowserClient is the client for the Antybrowser Local API.
type AntybrowserClient struct {
	apiKey     string
	baseURL    string
	httpClient *http.Client
}

// Option configures the client.
type Option func(*AntybrowserClient)

// WithPort sets a custom API port (default 5173).
func WithPort(port int) Option {
	return func(c *AntybrowserClient) {
		c.baseURL = fmt.Sprintf("http://127.0.0.1:%d", port)
	}
}

// WithBaseURL overrides the full base URL.
func WithBaseURL(url string) Option {
	return func(c *AntybrowserClient) {
		c.baseURL = url
	}
}

// WithTimeout sets the HTTP client timeout.
func WithTimeout(d time.Duration) Option {
	return func(c *AntybrowserClient) {
		c.httpClient.Timeout = d
	}
}

// WithHTTPClient sets a custom http.Client.
func WithHTTPClient(client *http.Client) Option {
	return func(c *AntybrowserClient) {
		c.httpClient = client
	}
}

// NewClient creates a new Antybrowser API client.
func NewClient(apiKey string, opts ...Option) *AntybrowserClient {
	c := &AntybrowserClient{
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

func (c *AntybrowserClient) GetStatus() (*StatusResponse, error) {
	var result StatusResponse
	err := c.get("/api/status", &result)
	return &result, err
}

func (c *AntybrowserClient) GetSettings() (*Settings, error) {
	var result Settings
	err := c.get("/api/settings", &result)
	return &result, err
}

func (c *AntybrowserClient) GetSyncStatus() (*SyncStatus, error) {
	var result SyncStatus
	err := c.get("/api/sync/status", &result)
	return &result, err
}

func (c *AntybrowserClient) RefreshSync(profileID *int) (map[string]any, error) {
	body := map[string]any{}
	if profileID != nil {
		body["profileId"] = *profileID
	}
	var result map[string]any
	err := c.post("/api/sync/refresh", body, &result)
	return result, err
}

// ─── Profiles ────────────────────────────────────────────────────────────

func (c *AntybrowserClient) GetProfiles() ([]Profile, error) {
	var result []Profile
	err := c.get("/api/profiles", &result)
	return result, err
}

func (c *AntybrowserClient) CreateProfile(req CreateProfileRequest) (*Profile, error) {
	var result Profile
	err := c.post("/api/profiles", req, &result)
	return &result, err
}

func (c *AntybrowserClient) UpdateProfile(id int, data map[string]any) (*Profile, error) {
	var result Profile
	err := c.put(fmt.Sprintf("/api/profiles/%d", id), data, &result)
	return &result, err
}

func (c *AntybrowserClient) DeleteProfile(id int) (map[string]any, error) {
	var result map[string]any
	err := c.delete(fmt.Sprintf("/api/profiles/%d", id), &result)
	return result, err
}

func (c *AntybrowserClient) StartProfile(id int) (*StartProfileResponse, error) {
	var result StartProfileResponse
	err := c.post(fmt.Sprintf("/api/profiles/%d/start", id), nil, &result)
	return &result, err
}

func (c *AntybrowserClient) StopProfile(id int) (map[string]any, error) {
	var result map[string]any
	err := c.post(fmt.Sprintf("/api/profiles/%d/stop", id), nil, &result)
	return result, err
}

func (c *AntybrowserClient) DuplicateProfile(id int, opts *DuplicateProfileRequest) (*Profile, error) {
	var body any
	if opts != nil {
		body = opts
	}
	var result Profile
	err := c.post(fmt.Sprintf("/api/profiles/%d/duplicate", id), body, &result)
	return &result, err
}

// ─── Automations ─────────────────────────────────────────────────────────

func (c *AntybrowserClient) GetAutomations() ([]Automation, error) {
	var result []Automation
	err := c.get("/api/automations", &result)
	return result, err
}

func (c *AntybrowserClient) RunAutomation(id int, req RunAutomationRequest) (*RunAutomationResult, error) {
	var result RunAutomationResult
	err := c.post(fmt.Sprintf("/api/automations/%d/run", id), req, &result)
	return &result, err
}

// ─── Groups ──────────────────────────────────────────────────────────────

func (c *AntybrowserClient) GetGroups() ([]Group, error) {
	var result []Group
	err := c.get("/api/groups", &result)
	return result, err
}

func (c *AntybrowserClient) CreateGroup(req CreateGroupRequest) (*Group, error) {
	var result Group
	err := c.post("/api/groups", req, &result)
	return &result, err
}

func (c *AntybrowserClient) UpdateGroup(id int, data map[string]any) (*Group, error) {
	var result Group
	err := c.put(fmt.Sprintf("/api/groups/%d", id), data, &result)
	return &result, err
}

func (c *AntybrowserClient) DeleteGroup(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/groups/%d", id))
}

// ─── Proxies ─────────────────────────────────────────────────────────────

func (c *AntybrowserClient) GetProxies() ([]Proxy, error) {
	var result []Proxy
	err := c.get("/api/proxies", &result)
	return result, err
}

func (c *AntybrowserClient) CreateProxy(req CreateProxyRequest) (*Proxy, error) {
	var result Proxy
	err := c.post("/api/proxies", req, &result)
	return &result, err
}

func (c *AntybrowserClient) CheckProxy(host string, port int, username, password, proxyType *string) (*ProxyCheckResult, error) {
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

func (c *AntybrowserClient) CheckProxiesBulk(proxies []any) ([]ProxyCheckResult, error) {
	body := map[string]any{"proxies": proxies}
	var raw struct {
		Results []ProxyCheckResult `json:"results"`
	}
	err := c.post("/api/proxies/check-bulk", body, &raw)
	return raw.Results, err
}

func (c *AntybrowserClient) DeleteProxy(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/proxies/%d", id))
}

// ─── Extensions ──────────────────────────────────────────────────────────

func (c *AntybrowserClient) GetExtensions() ([]Extension, error) {
	var result []Extension
	err := c.get("/api/extensions", &result)
	return result, err
}

func (c *AntybrowserClient) DeleteExtension(id int) error {
	return c.deleteNoBody(fmt.Sprintf("/api/extensions/%d", id))
}

func (c *AntybrowserClient) GetProfileExtensions(profileID int, details bool) ([]Extension, error) {
	var result []Extension
	err := c.get(fmt.Sprintf("/api/profiles/%d/extensions?details=%t", profileID, details), &result)
	return result, err
}

func (c *AntybrowserClient) SetProfileExtensions(profileID int, extensionIDs []int) (map[string]any, error) {
	body := map[string]any{"extensionIds": extensionIDs}
	var result map[string]any
	err := c.post(fmt.Sprintf("/api/profiles/%d/extensions", profileID), body, &result)
	return result, err
}

// ─── HTTP Helpers ────────────────────────────────────────────────────────

func (c *AntybrowserClient) doRequest(method, path string, body any, result any) error {
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
		return fmt.Errorf("request failed (is Antybrowser running?): %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("read response: %w", err)
	}

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return &AntybrowserError{
			Message:      fmt.Sprintf("API request failed with status %d", resp.StatusCode),
			StatusCode:   resp.StatusCode,
			ResponseBody: string(respBody),
		}
	}

	if result != nil && len(respBody) > 0 {
		if err := json.Unmarshal(respBody, result); err != nil {
			return &AntybrowserError{
				Message:      "Invalid JSON response from API",
				StatusCode:   resp.StatusCode,
				ResponseBody: string(respBody),
			}
		}
	}
	return nil
}

func (c *AntybrowserClient) get(path string, result any) error {
	return c.doRequest(http.MethodGet, path, nil, result)
}

func (c *AntybrowserClient) post(path string, body any, result any) error {
	return c.doRequest(http.MethodPost, path, body, result)
}

func (c *AntybrowserClient) put(path string, body any, result any) error {
	return c.doRequest(http.MethodPut, path, body, result)
}

func (c *AntybrowserClient) delete(path string, result any) error {
	return c.doRequest(http.MethodDelete, path, nil, result)
}

func (c *AntybrowserClient) deleteNoBody(path string) error {
	return c.doRequest(http.MethodDelete, path, nil, nil)
}
