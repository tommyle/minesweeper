class StringHelpers {
  /*
   *  Converts a duration to a string in the format mm:ss
   */
  static String durationToMMSS(Duration duration) {
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
