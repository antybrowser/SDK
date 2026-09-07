using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class Profile
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("status")]
        public string? Status { get; set; }

        [JsonPropertyName("browserType")]
        public string? BrowserType { get; set; }

        [JsonPropertyName("osFingerprint")]
        public string? OsFingerprint { get; set; }

        [JsonPropertyName("language")]
        public string? Language { get; set; }

        [JsonPropertyName("directoryName")]
        public string? DirectoryName { get; set; }

        [JsonPropertyName("createdAt")]
        public string? CreatedAt { get; set; }

        [JsonPropertyName("updatedAt")]
        public string? UpdatedAt { get; set; }
    }

    public class CreateProfileRequest
    {
        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("browserType")]
        public string? BrowserType { get; set; }

        [JsonPropertyName("osFingerprint")]
        public string? OsFingerprint { get; set; }

        [JsonPropertyName("language")]
        public string? Language { get; set; }

        [JsonPropertyName("useFingerprint")]
        public bool? UseFingerprint { get; set; }

        [JsonPropertyName("groupId")]
        public int? GroupId { get; set; }

        [JsonPropertyName("proxyId")]
        public int? ProxyId { get; set; }
    }
}
