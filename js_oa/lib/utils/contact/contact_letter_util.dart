/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-12 15:58:23
 * @Description: 联系人姓名首字母工具
 * @FilePath: \js_oa\lib\utils\contact\contact_letter_util.dart
 * @LastEditTime: 2021-11-12 16:04:07
 */
import 'package:lpinyin/lpinyin.dart';

class ContactLetterUtil {
  static String getFirstLetterName(String realName) {
    String pinyin;
    pinyin = PinyinHelper.getPinyinE(realName.trim());
    if (realName.length > 1 && "仇" == realName.substring(0, 1)) {
      pinyin = "Q";
    }
    if (realName.length > 1 && "曾" == realName.substring(0, 1)) {
      pinyin = "Z";
    }
    if (realName.length > 1 && "翟" == realName.substring(0, 1)) {
      pinyin = "Z";
    }
    if (realName.length > 1 && "单" == realName.substring(0, 1)) {
      pinyin = "S";
    }
    if (realName.length > 1 && "解" == realName.substring(0, 1)) {
      pinyin = "X";
    }
    if (realName.length > 1 && "区" == realName.substring(0, 1)) {
      pinyin = "O";
    }
    if (realName.length > 1 && "查" == realName.substring(0, 1)) {
      pinyin = "Z";
    }
    if (realName.length > 1 && "乐" == realName.substring(0, 1)) {
      pinyin = "Y";
    }
    if (realName.length > 1 && "谌" == realName.substring(0, 1)) {
      pinyin = "C";
    }
    return pinyin;
  }
}
