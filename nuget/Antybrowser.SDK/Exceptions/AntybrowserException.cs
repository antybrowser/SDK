using System;
using System.Net;

namespace Antybrowser.SDK.Exceptions
{
    public class AntybrowserException : Exception
    {
        public HttpStatusCode? StatusCode { get; }
        public string? ResponseContent { get; }

        public AntybrowserException(string message) : base(message)
        {
        }

        public AntybrowserException(string message, Exception innerException) : base(message, innerException)
        {
        }

        public AntybrowserException(string message, HttpStatusCode statusCode, string? responseContent) 
            : base($"{message} (Status: {statusCode})")
        {
            StatusCode = statusCode;
            ResponseContent = responseContent;
        }
    }
}
