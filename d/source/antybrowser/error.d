module antybrowser.error;

import std.conv : to;

class AntybrowserError : Exception
{
    int statusCode;
    string responseBody;

    this(int statusCode, string responseBody, string message = "API request failed",
         string file = __FILE__, size_t line = __LINE__, Throwable next = null)
    {
        super(message ~ " (status " ~ statusCode.to!string ~ ")", file, line, next);
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    this(string message, string file = __FILE__, size_t line = __LINE__, Throwable next = null)
    {
        super(message, file, line, next);
        this.statusCode = 0;
        this.responseBody = "";
    }
}
