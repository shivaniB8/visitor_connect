import 'package:host_visitor_connect/common/exceptions/general_exception.dart';

class MinCharsException extends GeneralException {
  String? _message;

  MinCharsException(int charCont, [String? message]) {
    this._message = message ?? "Need at least $charCont characters";
  }

  @override
  String toString() => this._message ?? "";
}
