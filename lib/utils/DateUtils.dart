class DateUtils {
  static String getSystemTime() {
    DateTime dateTime = DateTime.now();
    return dateTime.toString().split(".")[0];
  }

  static String getSystemFormatTime() {
    DateTime dateTime = DateTime.now();
    return dateTime
        .toString()
        .split(".")[0]
        .replaceAll(":", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");
  }
}
