/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 14:50:46
 * @Description: 软键盘工具类
 * @FilePath: \js_oa\lib\utils\keyboard\keyboard_utils.dart
 * @LastEditTime: 2021-09-24 15:54:52
 */
import 'package:flutter/services.dart';

class KeyBoardUtils {
  //隐藏软键盘
  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

  static void showKeyBoard() {
    SystemChannels.textInput.invokeMethod("TextInput.show");
  }
}
