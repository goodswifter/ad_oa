/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 14:23:46
 * @Description: 会话模块 C2C 状态管理器
 * @FilePath: \js_oa\lib\controller\message\c2c_conversation_controller.dart
 * @LastEditTime: 2022-01-04 14:36:48
 */

import 'package:get/get.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class C2cConversationController extends GetxController {
  ///对话者用户Id
  final String userId;

  ///会话Id
  final String conversationId;

  ///判断是否可加载更多历史消息
  bool _loadMoreEnabled = true;

  ///历史消息数据
  List<V2TimMessage> messageList = [];

  ///聊天对象的名称
  String? showNickName = "";

  ///聊天对象的头像
  String? faceUrl = "";
  String msgId = "";
  C2cConversationController(
      {required this.conversationId, required this.userId});

  @override
  void onInit() {
    super.onInit();
    _getConversationBaseInfo();
  }

  ///获取会话的基本信息
  _getConversationBaseInfo() async {
    V2TimValueCallback<V2TimConversation> res = await TencentImSDKPlugin
        .v2TIMManager
        .getConversationManager()
        .getConversation(conversationID: conversationId);
    if (res.code == 0 && res.desc == "ok") {
      showNickName = res.data!.showName;
      faceUrl = res.data!.faceUrl;
      _getC2cHistoryMessages();
    }
  }

  ///获取c2c历史聊天记录
  Future<void> _getC2cHistoryMessages({String? lastMsg}) async {
    V2TimValueCallback<List<V2TimMessage>> res = await TencentImSDKPlugin
        .v2TIMManager
        .getMessageManager()
        .getC2CHistoryMessageList(
            userID: userId, count: 20, lastMsgID: lastMsg);
    if (res.code == 0) {
      List<V2TimMessage>? list = res.data;
      if (list == null || list.length == 0) {
        _loadMoreEnabled = false;
      } else {
        list.forEach((element) {
          if (msgId != element.msgID) {
            msgId = element.msgID!;
            messageList.add(element);
          }
        });
        messageList.sort((left, right) {
          return left.timestamp!.compareTo(right.timestamp!);
        });
        //刷新数据列表
        update(["conversation_message_list"]);
      }
    }
  }

  ///新增一条消息内容  更新UI
  addMessage(V2TimMessage value) {
    messageList.add(value);
    //刷新数据列表
    update(["conversation_message_list"]);
  }

  ///更新消息对话列表  标记为已读  更新UI
  updateC2CMessageByUserId({required String user}) {
    if (userId == user) {
      messageList.forEach((element) {
        element.isPeerRead = true;
      });
      //刷新"已读"未读"显示
      update(["message_read"]);
    }
  }

  ///上拉加载更多历史消息
  Future<void> loadMoreHistoryData() async {
    if (!_loadMoreEnabled) {
      return;
    }
    V2TimMessage message = messageList[0];
    await _getC2cHistoryMessages(lastMsg: message.msgID);
  }

  ///发送一条图片消息
  sendOneImageMessage(String? path, String toUser) async {
    if (path == null) return;
    ToastUtil.showToast("图片发送中..");
    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createImageMessage(imagePath: path);
    if (result.code == 0) {
      V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(id: result.data!.id!, receiver: toUser, groupID: "");
      if (res.code == 0) {
        await addMessage(res.data!);
      } else {
        ToastUtil.showToast("发送失败 " + res.desc);
      }
    }
  }

  ///发送一条视频消息
  sendVideoMessage(
      {required String videoPath,
      required String toUser,
      required int duration,
      String? snapshotPath}) async {
    ToastUtil.showToast("视频发送中..");
    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createVideoMessage(
              videoFilePath: videoPath,
              type: "mp4",
              duration: duration,
              snapshotPath: snapshotPath ?? "",
            );
    if (result.code == 0) {
      V2TimValueCallback<V2TimMessage> res = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(id: result.data!.id!, receiver: toUser, groupID: "");
      if (res.code == 0) {
        await addMessage(res.data!);
      } else {
        ToastUtil.showToast("发送失败 " + res.desc);
        print("发送失败 " + res.desc);
      }
    }
  }
}
