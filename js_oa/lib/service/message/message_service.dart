/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-18 18:02:00
 * @Description: 消息模块网络请求服务
 * @FilePath: \js_oa\lib\service\message\message_service.dart
 * @LastEditTime: 2021-12-30 16:31:39
 */
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/entity/message/contact_detail_model.dart';
import 'package:js_oa/entity/message/im_login_entity.dart';
import 'package:js_oa/service/message/message_api.dart';

import 'package:js_oa/utils/http/src/http_client.dart';
import 'package:sp_util/sp_util.dart';

const String sp_im_user = "im_user";

class MessageService {
  late final HttpClient _httpClient;
  static MessageService? _instance;

  factory MessageService.getInstance() => _getInstance();

  static _getInstance() {
    if (_instance == null) {
      _instance = MessageService._interal();
    }
    return _instance;
  }

  MessageService._interal() {
    _httpClient = Get.find();
  }

  ///请求联系人详情
  Future<ContactDetailEntity> getContactDetailById(
      {required String toUserId}) async {
    ContactDetailEntity entity = ContactDetailEntity();
    return await _httpClient
        .get(MessageApi.getContactDetail + "$toUserId",
            isShowEasyLoading: false)
        .then((value) {
      if (value.ok) {
        entity = ContactDetailEntity.fromJson(value.data);
      }
      return entity;
    });
  }

  ///请求im登录的签名
  Future<IMLoginInputResponse> getImLoginSig() async {
    IMLoginInputResponse response = IMLoginInputResponse();
    return await _httpClient
        .get(MessageApi.getUserImSig, isShowEasyLoading: false)
        .then((value) async {
      if (value.ok) {
        response = IMLoginInputResponse.fromJson(value.data);
        bool? isSaveSuccess = await SpUtil.putObject(sp_im_user, response);
        if (isSaveSuccess != null && isSaveSuccess) {
          MessageController controller = Get.find();
          controller.setImUser(response);
        }
      }
      return response;
    });
  }
}
