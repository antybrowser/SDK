class AntybrowserException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  AntybrowserException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'AntybrowserException: $message';
}
