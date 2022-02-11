/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-04 12:45:40
 * @Description: im 登录
 * @FilePath: \js_oa\lib\im\im_login_manager.dart
 * @LastEditTime: 2021-12-10 17:07:20
 */
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/service/message/message_service.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

///已登录
const int V2TIM_STATUS_LOGINED = 1;

///登陆中
const int V2TIM_STATUS_LOGINING = 2;

///未登录
const int V2TIM_STATUS_LOGOUT = 3;

class IMLoginManager {
  static Future<int> loginIm(
      {required String userId, required String pwdStr}) async {
    return await _getLoginStatus().then((value) async {
      if (value == 0) {
        return 0;
      } else {
        V2TimCallback calback = await TencentImSDKPlugin.v2TIMManager.login(
          userID: userId,
          userSig: pwdStr,
        );
        return calback.code;
      }
    });
  }

  static Future<int> _getLoginStatus() async {
    V2TimValueCallback<int> res =
        await TencentImSDKPlugin.v2TIMManager.getLoginStatus();
    switch (res.data) {
      case V2TIM_STATUS_LOGINED:
        return 0;
      case V2TIM_STATUS_LOGINING:
        return -1;
      case V2TIM_STATUS_LOGOUT:
        return 1;
      default:
        return 1;
    }
  }

  static Future<int> logout() async {
    await SpUtil.remove(sp_im_user);
    MessageController controller = Get.find();
    controller.getConversionList.clear();
    controller.unreadTotalCount.value = 0;
    V2TimCallback callback = await TencentImSDKPlugin.v2TIMManager.logout();
    return callback.code;
  }
}
