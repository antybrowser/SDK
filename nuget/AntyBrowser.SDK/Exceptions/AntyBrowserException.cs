using System;
using System.Net;

namespace AntyBrowser.SDK.Exceptions
{
    public class AntyBrowserException : Exception
    {
        public HttpStatusCode? StatusCode { get; }
        public string? ResponseContent { get; }

        public AntyBrowserException(string message) : base(message)
        {
        }

        public AntyBrowserException(string message, Exception innerException) : base(message, innerException)
        {
        }

        public AntyBrowserException(string message, HttpStatusCode statusCode, string? responseContent) 
            : base($"{message} (Status: {statusCode})")
        {
            StatusCode = statusCode;
            ResponseContent = responseContent;
        }
    }
}
