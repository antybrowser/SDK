package com.antybrowser.sdk

class AntybrowserException(message: String, val statusCode: Int? = null, val responseBody: String? = null) : Exception(message)
