extension DurationExtension on Duration {
  /// returns duration mm:ss format
  String toMMSSFormat() {
    String convertToTwoDigits(int num) => num.toString().padLeft(2, "0");
    final String minutes = convertToTwoDigits(inMinutes);
    final String seconds = convertToTwoDigits(inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
