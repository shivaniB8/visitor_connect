import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatDate([String? format]) {
    final DateFormat formatter = DateFormat(format ?? 'dd/MM/yyyy');
    final String formatted = formatter.format(this);
    return formatted;
  }
}
