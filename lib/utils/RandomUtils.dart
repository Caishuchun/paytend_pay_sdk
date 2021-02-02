import 'dart:math';

class RandomUtils {
  static getRandomNumStr(int len) {
    Random random = new Random(); //随机数生成类
    String str = '';
    for (int i = 0; i < len; i++) {
      //生成10个随机数99
      str += random.nextInt(10).toString();
    }
    return str;
  }

  static getRandomStr(int len) {
    String base =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = new Random();
    String str = '';
    for (int i = 0; i < len; i++) {
      //生成10个随机数99
      str += base[random.nextInt(base.length)];
    }
    return str;
  }
}
