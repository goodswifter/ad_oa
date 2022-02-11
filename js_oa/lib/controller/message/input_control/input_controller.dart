/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-10-22 15:56:08
 * @Description: 输入操作台状态管理
 * @FilePath: \js_oa\lib\controller\message\input_control\input_controller.dart
 * @LastEditTime: 2021-12-29 17:13:13
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/advance/advance_icons_widget.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/voice_icon.dart';
import 'package:js_oa/utils/keyboard/keyboard_utils.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:tencent_im_sdk_plugin/enum/offlinePushInfo.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

import '../c2c_conversation_controller.dart';

///控制"添加","发送"显示逻辑方法回调
typedef SendAndAddButtonChangeBuilder = Function();

///消息输入控制管理器
class InputController extends GetxController {
  ///控制语音按钮显示
  bool showVoiceIcon = true;

  ///文本输入框控制器
  late TextEditingController editingController;

  ///文本输入框内容
  String textFieldContent = "";

  ///统一适配iOS和Android用户 发送消息习惯
  var showAddButton = true.obs;

  ///控制台的高度
  double keyboardHeight = 0;

  ///输入框焦点
  final FocusNode focusNode = FocusNode();

  SendAndAddButtonChangeBuilder? addButtonBuilder;

  setSendAndAddButtonChangeBuilder(SendAndAddButtonChangeBuilder builder) {
    this.addButtonBuilder = builder;
  }

  @override
  void onInit() {
    super.onInit();
    editingController = TextEditingController();
    editingController.addListener(() {
      showAddButton.value =
          (editingController.text == "" || editingController.text.trim() == "");
      if (editingController.text == "" || editingController.text.trim() == "") {
        textFieldContent = "";
      } else {
        textFieldContent = editingController.text;
      }
    });
    ever(showAddButton, (value) {
      if (addButtonBuilder != null) {
        addButtonBuilder!.call();
      }
    });
  }

  ///录音按钮 点击事件
  voiceButtonClickEvent() async {
    keyboardHeight = 0;
    focusNode.unfocus();
    if (showVoiceIcon) {
      KeyBoardUtils.hideKeyBoard();
    }
    showVoiceIcon = !showVoiceIcon;
    update([AdvanceIconsWidget.advanceId]);
    update([VoiceIconWidget.voiceIcon]);
  }

  ///表情按钮点击事件逻辑处理
  emojiButtonClickEvent() {
    focusNode.unfocus();
    keyboardHeight = 185;
    update([AdvanceIconsWidget.advanceId]);
    if (!showVoiceIcon) {
      showVoiceIcon = true;
      update([VoiceIconWidget.voiceIcon]);
    }
  }

  ///"+"号按钮点击事件逻辑处理
  addButtonClickEvent() {
    focusNode.unfocus();
    keyboardHeight = 130;
    update([AdvanceIconsWidget.advanceId]);
    if (!showVoiceIcon) {
      showVoiceIcon = true;
      update([VoiceIconWidget.voiceIcon]);
    }
  }

  ///聊天背景点击事件
  chatInnerBackgroundClickEvent() {
    keyboardHeight = 0;
    // focusNode.unfocus();
    update([AdvanceIconsWidget.advanceId]);
  }

  ///表情面板 回退键的点击事件
  backSpaceButtonClickEvent() {
    String content = editingController.text;
    if (content.length == 0) return;
    Runes r = content.runes;
    editingController.text = String.fromCharCodes(r, 0, r.length - 1);
    editingController.selection = TextSelection.fromPosition(
        TextPosition(offset: editingController.text.length));
  }

  /// “发送”按钮的点击事件
  sendButtonClickEvent({required String toUser}) async {
    String messageText = editingController.text;
    editingController.clear();
    if (messageText == '' || messageText.trim() == '') return;
    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(text: messageText);
    if (result.code == 0) {
      LoginController loginController = Get.find();
      String realeName = loginController.userinfo.value.realName ??
          loginController.userinfo.value.userName!;
      V2TimValueCallback<V2TimMessage> res =
          await TencentImSDKPlugin.v2TIMManager.getMessageManager().sendMessage(
                id: result.data!.id!,
                receiver: toUser,
                groupID: "",
                offlinePushInfo: OfflinePushInfo(
                    title: "京师OA", desc: "$realeName:$messageText"),
              );
      if (res.code == 0) {
        C2cConversationController conversationController = Get.find();
        conversationController.addMessage(res.data!);
      } else {
        ToastUtil.showToast("消息发送失败 ${res.desc} ${res.code}");
      }
    }
  }
}
