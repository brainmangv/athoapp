String formatTime(int seconds) {
  final duration = Duration(seconds: seconds);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  // String twoDigitHours = twoDigits(duration.inHours);
  String twoDigitMinutes = twoDigits(duration.inMinutes);
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String fim = twoDigitMinutes != '00' ? 'minutos' : 'segundos';
  return "$twoDigitMinutes:$twoDigitSeconds $fim";
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
