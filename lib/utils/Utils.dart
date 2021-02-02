import 'DateUtils.dart';
import 'MD5Utils.dart';
import 'RandomUtils.dart';

class Utils {
  static String generateMd5(
      Map<String, String> map, String key, bool emptyParamIsSign) {
    return MD5Utils.generateMd5(map, key, emptyParamIsSign);
  }

  static String getSystemTime() {
    return DateUtils.getSystemTime();
  }

  static String getSystemFormatTime() {
    return DateUtils.getSystemFormatTime();
  }

  static getRandomNumStr(int len) {
    return RandomUtils.getRandomNumStr(len);
  }

  static getRandomStr(int len) {
    return RandomUtils.getRandomStr(len);
  }

  static log(dynamic s) {
    print(s);
  }
}
