class DateUtils {
  //YYYY-MM-DD HH:mm:ss
  static String getSystemTime() {
    DateTime dateTime = DateTime.now();
    return dateTime.toString().split(".")[0];
  }

  //YYYYMMDDHHmmss
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
