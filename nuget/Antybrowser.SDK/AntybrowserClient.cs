using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Antybrowser.SDK.Models;
using Antybrowser.SDK.Exceptions;

namespace Antybrowser.SDK
{
    /// <summary>
    /// Antybrowser .NET SDK Client for interacting with the Antybrowser Local API.
    /// Provide seamless integration for browser automation, multi-accounting, and anti-detect profile management.
    /// </summary>
    public class AntybrowserClient : IDisposable
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiKey;
        private readonly string _baseUrl;

        /// <summary>
        /// Initializes a new instance of the <see cref="AntybrowserClient"/> class.
        /// </summary>
        /// <param name="apiKey">The API Key found in Antybrowser settings.</param>
        /// <param name="baseUrl">The base URL of the Antybrowser Local API (defaults to http://127.0.0.1:5173).</param>
        public AntybrowserClient(string apiKey, string baseUrl = "http://127.0.0.1:5173")
        {
            _apiKey = apiKey ?? throw new ArgumentNullException(nameof(apiKey));
            _baseUrl = baseUrl.TrimEnd('/');
            _httpClient = new HttpClient();
            _httpClient.DefaultRequestHeaders.Add("x-api-key", _apiKey);
        }

        #region System
        /// <summary>
        /// Checks the status of the Antybrowser Local API.
        /// </summary>
        public async Task<ApiResponse> GetStatusAsync()
        {
            return await GetAsync<ApiResponse>("/api/status");
        }

        /// <summary>
        /// Gets the current synchronization status for all profiles.
        /// </summary>
        public async Task<SyncStatus> GetSyncStatusAsync()
        {
            return await GetAsync<SyncStatus>("/api/sync/status");
        }

        /// <summary>
        /// Triggers a synchronization refresh, optionally for a specific profile.
        /// </summary>
        /// <param name="profileId">Optional profile ID to sync.</param>
        public async Task<ApiResponse> RefreshSyncAsync(string? profileId = null)
        {
            var body = profileId != null ? new { profileId } : null;
            return await PostAsync<ApiResponse>("/api/sync/refresh", body);
        }

        /// <summary>
        /// Retrieves the global Antybrowser settings.
        /// </summary>
        public async Task<Settings> GetSettingsAsync()
        {
            return await GetAsync<Settings>("/api/settings");
        }
        #endregion

        #region Profiles
        /// <summary>
        /// Lists all available browser profiles.
        /// </summary>
        public async Task<List<Profile>> GetProfilesAsync()
        {
            return await GetAsync<List<Profile>>("/api/profiles");
        }

        /// <summary>
        /// Launches a specific browser profile.
        /// </summary>
        /// <param name="id">The unique profile ID.</param>
        public async Task<ApiResponse<object>> StartProfileAsync(int id)
        {
            return await PostAsync<ApiResponse<object>>($"/api/profiles/{id}/start", null);
        }

        /// <summary>
        /// Stops a currently running browser profile.
        /// </summary>
        /// <param name="id">The unique profile ID.</param>
        public async Task<ApiResponse> StopProfileAsync(int id)
        {
            return await PostAsync<ApiResponse>($"/api/profiles/{id}/stop", null);
        }

        /// <summary>
        /// Creates a new anti-detect browser profile.
        /// </summary>
        /// <param name="request">The profile configuration parameters.</param>
        public async Task<Profile> CreateProfileAsync(CreateProfileRequest request)
        {
            return await PostAsync<Profile>("/api/profiles", request);
        }

        /// <summary>
        /// Duplicates an existing browser profile.
        /// </summary>
        /// <param name="id">Source profile ID.</param>
        /// <param name="name">New profile name (optional).</param>
        /// <param name="directoryName">New directory name (optional).</param>
        public async Task<Profile> DuplicateProfileAsync(int id, string? name = null, string? directoryName = null)
        {
            var body = new { name, directoryName };
            return await PostAsync<Profile>($"/api/profiles/{id}/duplicate", body);
        }

        /// <summary>
        /// Updates the configuration of an existing profile.
        /// </summary>
        /// <param name="id">Profile ID to update.</param>
        /// <param name="updateData">Data to update.</param>
        public async Task<Profile> UpdateProfileAsync(int id, object updateData)
        {
            return await PutAsync<Profile>($"/api/profiles/{id}", updateData);
        }

        /// <summary>
        /// Deletes a browser profile permanently.
        /// </summary>
        /// <param name="id">Profile ID to delete.</param>
        public async Task<ApiResponse> DeleteProfileAsync(int id)
        {
            return await DeleteAsync<ApiResponse>($"/api/profiles/{id}");
        }
        #endregion

        #region Automations
        /// <summary>
        /// Lists all available automation scripts.
        /// </summary>
        public async Task<List<Automation>> GetAutomationsAsync()
        {
            return await GetAsync<List<Automation>>("/api/automations");
        }

        /// <summary>
        /// Executes an automation workflow on a specific profile.
        /// </summary>
        /// <param name="automationId">The automation script ID.</param>
        /// <param name="request">Execution parameters and variables.</param>
        public async Task<RunAutomationResult> RunAutomationAsync(int automationId, RunAutomationRequest request)
        {
            return await PostAsync<RunAutomationResult>($"/api/automations/{automationId}/run", request);
        }
        #endregion

        #region Groups
        /// <summary>
        /// Lists all profile groups.
        /// </summary>
        public async Task<List<Group>> GetGroupsAsync()
        {
            return await GetAsync<List<Group>>("/api/groups");
        }

        /// <summary>
        /// Creates a new group for organizing profiles.
        /// </summary>
        public async Task<Group> CreateGroupAsync(CreateGroupRequest request)
        {
            return await PostAsync<Group>("/api/groups", request);
        }

        /// <summary>
        /// Updates an existing group's information.
        /// </summary>
        public async Task<Group> UpdateGroupAsync(int id, object updateData)
        {
            return await PutAsync<Group>($"/api/groups/{id}", updateData);
        }

        /// <summary>
        /// Deletes a group permanently.
        /// </summary>
        public async Task<ApiResponse> DeleteGroupAsync(int id)
        {
            return await DeleteAsync<ApiResponse>($"/api/groups/{id}");
        }
        #endregion

        #region Proxies
        /// <summary>
        /// Lists all managed proxies.
        /// </summary>
        public async Task<List<Proxy>> GetProxiesAsync()
        {
            return await GetAsync<List<Proxy>>("/api/proxies");
        }

        /// <summary>
        /// Adds a new proxy to the Antybrowser proxy manager.
        /// </summary>
        public async Task<Proxy> CreateProxyAsync(CreateProxyRequest request)
        {
            return await PostAsync<Proxy>("/api/proxies", request);
        }

        /// <summary>
        /// Validates a proxy connection and detects its location and IP.
        /// </summary>
        public async Task<ProxyCheckResult> CheckProxyAsync(object proxyData)
        {
            return await PostAsync<ProxyCheckResult>("/api/proxies/check", proxyData);
        }

        /// <summary>
        /// Performs a bulk validation of multiple proxies.
        /// </summary>
        public async Task<ApiResponse<List<ProxyCheckResult>>> CheckProxiesBulkAsync(List<object> proxies)
        {
            return await PostAsync<ApiResponse<List<ProxyCheckResult>>>("/api/proxies/check-bulk", new { proxies });
        }

        /// <summary>
        /// Deletes a proxy configuration.
        /// </summary>
        public async Task DeleteProxyAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"{_baseUrl}/api/proxies/{id}");
            if (!response.IsSuccessStatusCode)
            {
                var content = await response.Content.ReadAsStringAsync();
                throw new AntybrowserException("Failed to delete proxy", response.StatusCode, content);
            }
        }
        #endregion

        #region Extensions
        /// <summary>
        /// Lists all uploaded browser extensions.
        /// </summary>
        public async Task<List<Extension>> GetExtensionsAsync()
        {
            return await GetAsync<List<Extension>>("/api/extensions");
        }

        /// <summary>
        /// Deletes a browser extension.
        /// </summary>
        public async Task DeleteExtensionAsync(int id)
        {
            var response = await _httpClient.DeleteAsync($"{_baseUrl}/api/extensions/{id}");
            if (!response.IsSuccessStatusCode)
            {
                var content = await response.Content.ReadAsStringAsync();
                throw new AntybrowserException("Failed to delete extension", response.StatusCode, content);
            }
        }

        /// <summary>
        /// Gets extensions assigned to a specific profile.
        /// </summary>
        /// <param name="profileId">Target profile ID.</param>
        /// <param name="details">Whether to include full extension metadata.</param>
        public async Task<List<Extension>> GetProfileExtensionsAsync(int profileId, bool details = false)
        {
            return await GetAsync<List<Extension>>($"/api/profiles/{profileId}/extensions?details={details.ToString().ToLower()}");
        }

        /// <summary>
        /// Assigns a set of extensions to a profile.
        /// </summary>
        /// <param name="profileId">Target profile ID.</param>
        /// <param name="extensionIds">List of extension IDs to assign.</param>
        public async Task<ApiResponse> SetProfileExtensionsAsync(int profileId, List<int> extensionIds)
        {
            return await PostAsync<ApiResponse>($"/api/profiles/{profileId}/extensions", new { extensionIds });
        }
        #endregion

        #region HTTP Helpers
        private async Task<T> GetAsync<T>(string path)
        {
            var response = await _httpClient.GetAsync($"{_baseUrl}{path}");
            return await HandleResponseAsync<T>(response);
        }

        private async Task<T> PostAsync<T>(string path, object? body)
        {
            var json = body != null ? JsonSerializer.Serialize(body) : "{}";
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync($"{_baseUrl}{path}", content);
            return await HandleResponseAsync<T>(response);
        }

        private async Task<T> PutAsync<T>(string path, object body)
        {
            var json = JsonSerializer.Serialize(body);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            var response = await _httpClient.PutAsync($"{_baseUrl}{path}", content);
            return await HandleResponseAsync<T>(response);
        }

        private async Task<T> DeleteAsync<T>(string path)
        {
            var response = await _httpClient.DeleteAsync($"{_baseUrl}{path}");
            return await HandleResponseAsync<T>(response);
        }

        private async Task<T> HandleResponseAsync<T>(HttpResponseMessage response)
        {
            var content = await response.Content.ReadAsStringAsync();
            if (!response.IsSuccessStatusCode)
            {
                throw new AntybrowserException($"API request failed with status {response.StatusCode}", response.StatusCode, content);
            }

            try
            {
                return JsonSerializer.Deserialize<T>(content, new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                }) ?? throw new AntybrowserException("Failed to deserialize response");
            }
            catch (JsonException ex)
            {
                throw new AntybrowserException("Invalid JSON response from API", ex);
            }
        }
        #endregion

        /// <summary>
        /// Disposes the underlying HTTP client.
        /// </summary>
        public void Dispose()
        {
            _httpClient.Dispose();
        }
    }
}
