using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class Settings
    {
        [JsonPropertyName("apiKey")]
        public string? ApiKey { get; set; }

        [JsonPropertyName("port")]
        public int Port { get; set; }

        [JsonPropertyName("autoSync")]
        public bool AutoSync { get; set; }
    }
}
