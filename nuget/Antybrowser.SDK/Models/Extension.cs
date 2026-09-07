using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class Extension
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("name")]
        public string? Name { get; set; }

        [JsonPropertyName("description")]
        public string? Description { get; set; }

        [JsonPropertyName("version")]
        public string? Version { get; set; }

        [JsonPropertyName("extensionId")]
        public string? ExtensionId { get; set; }

        [JsonPropertyName("createdAt")]
        public string? CreatedAt { get; set; }
    }
}
