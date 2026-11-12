using System.Text.Json.Serialization;

namespace Antybrowser.SDK.Models
{
    /// <summary>Data returned when a profile starts.</summary>
    public class StartProfileData
    {
        /// <summary>Chrome DevTools Protocol port — attach Puppeteer, Playwright or Selenium.</summary>
        [JsonPropertyName("debugPort")]
        public int? DebugPort { get; set; }
    }

    /// <summary>Response from <see cref="AntybrowserClient.StartProfileAsync"/>.</summary>
    public class StartProfileResponse
    {
        [JsonPropertyName("success")]
        public bool Success { get; set; }

        [JsonPropertyName("data")]
        public StartProfileData? Data { get; set; }
    }
}
