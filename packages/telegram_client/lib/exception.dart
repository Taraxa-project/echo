class MessageException implements Exception {
  final int? code;
  final String? message;
  MessageException({
    this.code,
    this.message,
  });
}
