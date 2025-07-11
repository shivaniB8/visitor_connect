import 'dart:io';

extension ExceptionExtension on Exception {
  bool isConnectionException() {
    return this is SocketException;
  }
}
