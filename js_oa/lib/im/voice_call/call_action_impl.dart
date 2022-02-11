/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-17 17:49:27
 * @Description: 语音通话 动作实现类
 * @FilePath: \js_oa\lib\im\voice_call\call_action_impl.dart
 * @LastEditTime: 2021-12-30 16:26:14
 */
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/im/entity/voice_call_entity.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:js_oa/im/voice_call/call_back_entity.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:tencent_trtc_cloud/trtc_cloud.dart';
import 'package:tencent_trtc_cloud/trtc_cloud_def.dart';
import 'package:tencent_trtc_cloud/tx_device_manager.dart';

import '../tpns_config.dart';

class CallActionImpl extends CallAction {
  ///超时时间，默认30s
  final int timeOutCount = 30;

  ///房间id
  late int roomId;

  ///腾讯云视频通话功能的主要接口类
  late final TRTCCloud? mTRTCCloud;

  ///当前是否处于通话中，处于房间中
  bool isOnline = false;

  ///设备管理器
  late final TXDeviceManager? txDeviceManager;

  ///获取当前登录的用户信息
  final MessageController messageController = Get.find();

  @override
  Future<ActionCallback> call(
      {required String toUser,
      required String inviterName,
      required String inviterAvatar}) async {
    dynamic value = SpUtil.getObject("userinfo");
    UserEntity userInfo = UserEntity.fromJson(value);
    int myUserId = userInfo.id ?? -1;
    if (toUser == myUserId.toString()) {
      ToastUtil.showToast("不能邀请自己");
      return ActionCallback(code: -1, desc: "不能邀请自己");
    }
    if (!isOnline) {
      roomId = _createRoomId();
      await _enterRoom(roomId: roomId);
    }
    V2TimValueCallback res = await _sendInviteMessage(
        inviterAvatar: inviterAvatar, inviterName: inviterName, toUser: toUser);
    return ActionCallback(code: res.code, desc: res.desc);
  }

  @override
  Future<ActionCallback> accept(
      {required String inviteID, required int roomid}) async {
    await _enterRoom(roomId: roomid);
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager
        .getSignalingManager()
        .accept(inviteID: inviteID, data: jsonEncode(_getReplyCustomMap()));
    return ActionCallback(code: res.code, desc: res.desc);
  }

  @override
  Future<void> cancel() async {
    _stopCall();
    releaseRes();
  }

  @override
  Future<void> hangup({String? inviteID, String? toUser}) async {
    if (!isOnline) {
      await reject(inviteID: inviteID!);
      return;
    }
    String id = inviteID ?? toUser!;
    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(text: '·对方已挂断·');
    await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .sendMessage(groupID: '', id: result.data!.id!, receiver: id);
    await _exitRoom();
    _stopCall();
  }

  @override
  Future<ActionCallback> reject({required String inviteID}) async {
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager
        .getSignalingManager()
        .reject(inviteID: inviteID, data: jsonEncode(_getRejectCustomMap()));
    return ActionCallback(code: res.code, desc: res.desc);
  }

  ///创建房间id
  int _createRoomId() {
    Random rng = new Random();
    String numStr = '';
    for (var i = 0; i < 9; i++) {
      numStr += rng.nextInt(9).toString();
    }
    return int.tryParse(numStr) ?? -1;
  }

  ///进入房间
  _enterRoom({required int roomId}) async {
    isOnline = true;
    mTRTCCloud = await TRTCCloud.sharedInstance();
    mTRTCCloud?.enableAudioVolumeEvaluation(300);
    txDeviceManager = mTRTCCloud?.getDeviceManager();
    txDeviceManager?.setAudioRoute(TRTCCloudDef.TRTC_AUDIO_ROUTE_EARPIECE);
    mTRTCCloud?.muteLocalAudio(false);
    mTRTCCloud?.startLocalAudio(TRTCCloudDef.TRTC_AUDIO_QUALITY_DEFAULT);
    mTRTCCloud?.enterRoom(
        TRTCParams(
            sdkAppId: TpnsConfig.sdkappid,
            userId: messageController.imUser!.userId!.toString(),
            userSig: messageController.imUser!.userSig!,
            roomId: roomId,
            role: TRTCCloudDef.TRTC_APP_SCENE_AUDIOCALL),
        TRTCCloudDef.TRTC_APP_SCENE_AUDIOCALL);
  }

  @override
  Future<void> setHandsFree({required bool isHandsFree}) {
    throw UnimplementedError();
  }

  ///发送邀请通话信令消息
  Future<V2TimValueCallback> _sendInviteMessage(
      {required String toUser,
      required String inviterName,
      required String inviterAvatar}) async {
    return await TencentImSDKPlugin.v2TIMManager.getSignalingManager().invite(
        invitee: toUser,
        data: jsonEncode(_getCustomMap(
            inviterAvatar: inviterAvatar,
            inviterName: inviterName,
            roomId: roomId)),
        timeout: timeOutCount,
        onlineUserOnly: false);
  }

  ///发送自定义邀请信令消息给接收者
  _getCustomMap(
      {required String inviterAvatar,
      required String inviterName,
      required int roomId}) {
    VoiceCallSiganlEntity entity = VoiceCallSiganlEntity(
        inviteTypeName: "邀请语音通话",
        callType: 1,
        inviterAvatar: inviterAvatar,
        timeout: timeOutCount,
        inviterName: inviterName,
        roomId: roomId);
    Map<String, dynamic> customMap = entity.toJson();
    return customMap;
  }

  ///接收者同意后，发送自定义消息回调给发送者
  _getReplyCustomMap() {
    VoiceCallSiganlEntity entity =
        VoiceCallSiganlEntity(inviteTypeName: "同意语音邀请", callType: 2);
    Map<String, dynamic> customMap = entity.toJson();
    return customMap;
  }

  ///接收者拒绝后，发送自定义消息回调给发送者
  _getRejectCustomMap() {
    VoiceCallSiganlEntity entity =
        VoiceCallSiganlEntity(inviteTypeName: "拒绝语音邀请", callType: 3);
    Map<String, dynamic> customMap = entity.toJson();
    return customMap;
  }

  ///一个人挂断后，给对方发送挂断信令消息
  // _getHangupCustomMap() {
  //   VoiceCallSiganlEntity entity =
  //       VoiceCallSiganlEntity(inviteTypeName: "通话结束", callType: 4);
  //   Map<String, dynamic> customMap = entity.toJson();
  //   return customMap;
  // }

  _stopCall() {
    isOnline = false;
    roomId = -1;
  }

  ///挂断、拒绝、结束 退出房间
  _exitRoom() async {
    await mTRTCCloud?.stopLocalAudio();
    await mTRTCCloud?.exitRoom();
  }

  @override
  void releaseRes() async {
    await _exitRoom();
  }

  @override
  bool getCurrentCallStatus() => isOnline;
}
