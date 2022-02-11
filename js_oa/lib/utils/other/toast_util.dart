/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-23 14:17:09
 * @Description: 
 * @FilePath: \js_oa\lib\utils\other\toast_util.dart
 * @LastEditTime: 2022-01-04 14:31:34
 */
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';

/// Toast工具类
class ToastUtil {
  static void showToast(
    String? msg, {

    /// 毫秒
    int duration = 2000,
    EasyLoadingToastPosition position = EasyLoadingToastPosition.center,
  }) {
    if (msg == null) return;

    EasyLoading.showToast(msg,
        duration: Duration(milliseconds: duration),
        toastPosition: position,
        maskType: EasyLoadingMaskType.black);
  }

  static void show({String? status}) {
    EasyLoading.show(
      status: status,
      dismissOnTap: true,
    );
  }

  static void cancelToast() {
    EasyLoading.dismiss();
  }
}
