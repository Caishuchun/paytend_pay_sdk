import 'dart:convert';

import 'package:crypto/crypto.dart';

class MD5Utils {
  static Map<String, String> _toSort(Map<String, String> map) {
    List<String> keys = map.keys.toList();
    keys.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) {
          return -1;
        }
      }
      return 0;
    });
    Map<String, String> result = {};
    keys.forEach((key) => result[key] = map[key]);
    return result;
  }

  static String _toJson(Map<String, String> map, bool emptyParamIsSign) {
    var sortMap = _toSort(map);
    var newMap = sortMap;
    String result = '';
    newMap.remove("pay_type");
    newMap.forEach((key, value) {
      if (emptyParamIsSign) {
        result += "$key=$value&";
      } else {
        if (value != null && value != "") {
          result += "$key=$value&";
        }
      }
    });
    return result.substring(0, result.length - 1);
  }

  static String generateMd5(
      Map<String, String> map, String key, bool emptyParamIsSign) {
    String all = "${_toJson(map, emptyParamIsSign)}&key=$key".trim();
    // Utils.log(all);
    var content = Utf8Encoder().convert(all);
    var digest = md5.convert(content);
    return digest.toString().toUpperCase();
  }
}
