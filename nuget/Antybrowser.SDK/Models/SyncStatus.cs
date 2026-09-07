using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    public class SyncStatus
    {
        [JsonPropertyName("syncing")]
        public bool Syncing { get; set; }

        [JsonPropertyName("lastSync")]
        public string? LastSync { get; set; }

        [JsonPropertyName("progress")]
        public int Progress { get; set; }
    }
}
