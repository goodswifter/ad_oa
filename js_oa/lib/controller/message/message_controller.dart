/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-01 21:52:13
 * @Description: 消息模块 状态管理器
 * @FilePath: \js_oa\lib\controller\message\message_controller.dart
 * @LastEditTime: 2021-12-31 11:11:49
 */
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:js_oa/entity/message/contact_detail_model.dart';
import 'package:js_oa/entity/message/im_login_entity.dart';
import 'package:js_oa/im/tpns_config.dart';
import 'package:js_oa/im/im_login_manager.dart';
import 'package:js_oa/service/message/message_service.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_message_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:tpns_flutter_plugin/tpns_flutter_plugin.dart';

class MessageController extends GetxController {
  ///会话列表数据源
  List<V2TimConversation> _conversionList = [];

  ///设备token
  String deviceToken = "";

  ///TPNS推送接口类
  final XgFlutterPlugin tPush = XgFlutterPlugin();

  ///当前app的生命周期状态
  AppLifecycleState state = AppLifecycleState.resumed;

  ///未读消息总数
  var unreadTotalCount = 0.obs;

  IMLoginInputResponse? imUser;

  List<V2TimConversation> get getConversionList => _conversionList;
  set setConversionList(List<V2TimConversation> value) =>
      _conversionList = value;
  @override
  void onInit() {
    super.onInit();
  }

  Future<IMLoginInputResponse> loginIm() async {
    return await MessageService.getInstance().getImLoginSig();
  }

  ///获取会话消息列表数据
  void getConversationListData() async {
    dynamic value = SpUtil.getObject(sp_im_user);
    if (value == null) {
      await loginIm();
    } else {
      imUser = IMLoginInputResponse.fromJson(value);
    }
    await IMLoginManager.loginIm(
            userId: imUser!.userId.toString(), pwdStr: imUser!.userSig ?? "")
        .then((value) async {
      setOfflinePush();
      V2TimValueCallback<V2TimConversationResult> res = await TencentImSDKPlugin
          .v2TIMManager
          .getConversationManager()
          .getConversationList(nextSeq: "0", count: 100);
      V2TimConversationResult result = res.data!;
      List<V2TimConversation?>? list = result.conversationList;
      _editConversations(list);
    });
  }

  ///删除一条对话
  void removeConversationById(String id) {
    _conversionList.removeWhere((element) => element.conversationID == id);
    getTotalUnreadCount();
    update(["message_conversationlist"]);
  }

  ///设置离线推送
  setOfflinePush() async {
    double businessID = 0;
    if (Platform.isAndroid) {
      String? opt = await XgFlutterPlugin.xgApi.getOtherPushType();
      switch (opt) {
        case "xiaomi":
          businessID = TpnsConfig.xiao_mi;
          break;
        case "huawei":
          businessID = TpnsConfig.huawei;
          break;
        case "vivo":
          businessID = TpnsConfig.vivo;
          break;
        case "oppo":
          businessID = TpnsConfig.oppo;
          break;
        default:
      }
      XgFlutterPlugin.otherPushToken.then((value) {
        if (value == null) {
          deviceToken = "";
        } else {
          deviceToken = value.toString();
        }
        _setOfflinePush(businessId: businessID, deviceToken: deviceToken);
      });
    } else if (Platform.isIOS) {
      XgFlutterPlugin.otherPushToken.then((value) {
        if (value == null) {
          deviceToken = "";
        } else {
          deviceToken = value.toString();
        }
        // businessID = kDebugMode ? TpnsConfig.ios_dev : TpnsConfig.ios_pr;
        businessID = TpnsConfig.ios_pr;
        _setOfflinePush(businessId: businessID, deviceToken: deviceToken);
      });
    }
  }

  _setOfflinePush(
      {required double businessId, required String deviceToken}) async {
    if ("" == deviceToken) {
      return;
    }
    TencentImSDKPlugin.v2TIMManager
        .getOfflinePushManager()
        .setOfflinePushConfig(businessID: businessId, token: deviceToken);
  }

  ///会话列表发生变化处理数据
  void onConversationChanged(List<V2TimConversation?>? conversationList) {
    _editConversations(conversationList);
  }

  ///对会话消息进行排序去重处理
  void _editConversations(List<V2TimConversation?>? conversationList) {
    conversationList!.forEach((element) {
      String cid = element!.conversationID;
      if (_conversionList.any((ele) => ele.conversationID == cid)) {
        for (int i = 0; i < _conversionList.length; i++) {
          if (_conversionList[i].conversationID == cid) {
            getConversionList[i] = element;
          }
        }
      } else {
        _conversionList.add(element);
      }
    });
    _conversionList.sort((left, right) =>
        right.lastMessage!.timestamp!.compareTo(left.lastMessage!.timestamp!));
    update(["message_conversationlist"]);
    getTotalUnreadCount();
  }

  ///获取全部未读消息数量
  void getTotalUnreadCount() async {
    V2TimValueCallback<int> res = await TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .getTotalUnreadMessageCount();
    unreadTotalCount.value = res.data ?? 0;
  }

  ///设置一条会话全部消息已读
  void setMessageReaded(String userOrgroupID) async {
    V2TIMMessageManager manager =
        TencentImSDKPlugin.v2TIMManager.getMessageManager();
    int _code = -111;
    var res = await manager.markC2CMessageAsRead(userID: userOrgroupID);
    _code = res.code;
    if (_code == 0) {
      getTotalUnreadCount();
    }
  }

  ///根据id获取联系人详情
  Future<ContactDetailEntity> requestContactDetailByid(String toUserId) async {
    ContactDetailEntity entity = await MessageService.getInstance()
        .getContactDetailById(toUserId: toUserId);
    return entity;
  }

  void setImUser(IMLoginInputResponse res) {
    this.imUser = res;
  }
}
