using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class Automation
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("script")]
        public string? Script { get; set; }

        [JsonPropertyName("createdAt")]
        public string? CreatedAt { get; set; }
    }

    public class RunAutomationRequest
    {
        [JsonPropertyName("profileId")]
        public int ProfileId { get; set; }

        [JsonPropertyName("variables")]
        public Dictionary<string, object>? Variables { get; set; }
    }

    public class RunAutomationResult
    {
        [JsonPropertyName("success")]
        public bool Success { get; set; }

        [JsonPropertyName("output")]
        public string? Output { get; set; }

        [JsonPropertyName("error")]
        public string? Error { get; set; }
    }
}
