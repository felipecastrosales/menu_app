extension DurationX on Duration {
  String format() {
    final seconds = inSeconds % 60;
    final minutes = inMinutes % 60;
    final hours = inMinutes ~/ 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
