/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 10:20:15
 * @Description: 项目自定义相关颜色
 * @FilePath: \js_oa\lib\core\theme\js_colors.dart
 * @LastEditTime: 2021-12-13 15:14:08
 */
import 'dart:ui';

class JSColors {
  static const Color primaryColor = Color.fromARGB(255, 255, 255, 255);
  static const Color background_grey_light = Color.fromARGB(255, 248, 248, 248);
  static const Color background_grey = Color.fromARGB(255, 240, 240, 240);
  static const Color background = Color.fromARGB(255, 230, 230, 230);
  static const Color grey = Color.fromARGB(255, 177, 179, 179);
  static const Color black = Color.fromARGB(255, 51, 51, 51);
  static const Color black_dark = Color.fromARGB(255, 41, 41, 41);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color canvasColor = Color(0xFFF1F1F1);
  static const Color black_grey = Color.fromARGB(255, 80, 80, 80);
  static Color borderColor =
      Color(int.parse('ededed', radix: 16)).withAlpha(255);
  static Color readColor = Color(int.parse('FA5151', radix: 16)).withAlpha(255);
  static Color textWeakColor =
      Color(int.parse('999999', radix: 16)).withAlpha(255);

  static Color hexToColor(String hexString) {
    return Color(int.parse(hexString, radix: 16)).withAlpha(255);
  }

  static Color homeSearchBackground =
      Color(int.parse('F1F1F3', radix: 16)).withAlpha(255);

  static Color black3 = Color(int.parse('333333', radix: 16)).withAlpha(255);
  static Color black6 = Color(int.parse('666666', radix: 16)).withAlpha(255);
  static Color black9 = Color(int.parse('999999', radix: 16)).withAlpha(255);
}
