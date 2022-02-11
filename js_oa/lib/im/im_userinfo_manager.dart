/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-01 10:06:12
 * @Description: IM用户资料管理
 * @FilePath: \js_oa\lib\im\im_userinfo_manager.dart
 * @LastEditTime: 2021-12-01 10:30:12
 */

import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class IMUserInfoManager {
  static Future<bool> setImUserInfo({
    String? userID,
    String? nickName,
    String? faceUrl,
    String? selfSignature,
    int? gender,
    int? allowType,
    int? role,
    int? level,
    Map<String, String>? customInfo,
  }) async {
    V2TimUserFullInfo info = await getImUserInfo();
    info.userID = userID ?? info.userID;
    info.nickName = nickName ?? info.nickName;
    info.faceUrl = faceUrl ?? info.faceUrl;
    info.selfSignature = selfSignature ?? selfSignature;
    info.gender = gender ?? info.gender;
    info.allowType = allowType ?? info.allowType;
    info.role = role ?? info.role;
    info.level = level ?? info.level;
    info.customInfo = customInfo ?? info.customInfo;
    V2TimCallback callback =
        await TencentImSDKPlugin.v2TIMManager.setSelfInfo(userFullInfo: info);
    return callback.code == 0;
  }

  static Future<V2TimUserFullInfo> getImUserInfo() async {
    LoginController loginController = Get.find();
    UserEntity user = loginController.userinfo.value;
    V2TimValueCallback<List<V2TimUserFullInfo>> list = await TencentImSDKPlugin
        .v2TIMManager
        .getUsersInfo(userIDList: [user.id.toString()]);
    return list.data![0];
  }
}
