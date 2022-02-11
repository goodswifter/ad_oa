/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-18 09:42:01
 * @Description: 语音通话状态管理
 * @FilePath: \js_oa\lib\controller\message\voice_call\voice_call_controller.dart
 * @LastEditTime: 2021-12-16 17:38:30
 */
import 'package:get/get.dart';
import 'package:js_oa/im/voice_call/call_action_impl.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:js_oa/im/voice_call/call_back_entity.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';

///被拒接后回调监听
typedef OnRejectListener = Function();

class VoiceCallController extends GetxController with CallAction {
  late final CallAction callAction;
  OnRejectListener? onRejectListener;

  ///是否被拒接的监听变量
  var isRejected = false.obs;

  ///文本显示当前的通话状态
  var content = "".obs;

  ///控制当前显示邀请人底部布局还是被邀请人的底部布局
  var indexStackType = 0.obs;
  setOnRejectListener(OnRejectListener? listener) {
    this.onRejectListener = listener;
  }

  @override
  void onInit() {
    super.onInit();
    callAction = CallActionImpl();
    once<bool>(isRejected, (value) {
      if (this.onRejectListener != null) {
        onRejectListener!.call();
      }
    });
  }

  ///对方接受的回调
  acceptCallBack() {
    indexStackType.value = 0;
    EasyLoading.showToast("已接通",
        duration: Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.top);
    content.value = "开始通话";
  }

  ///自己接受
  @override
  Future<ActionCallback> accept(
      {required String inviteID, required int roomid}) async {
    return await callAction.accept(inviteID: inviteID, roomid: roomid);
  }

  ///对方拒绝的回调
  rejectCallBack() {
    isRejected.value = true;
  }

  ///自己拒绝
  @override
  Future<ActionCallback> reject({required String inviteID}) async {
    return await callAction.reject(inviteID: inviteID);
  }

  ///结束通话 对方挂断
  end() {
    cancel();
  }

  ///结束通话 自己挂断
  @override
  Future<void> hangup({String? inviteID, String? toUser}) async {
    return await callAction.hangup(inviteID: inviteID, toUser: toUser);
  }

  ///对方收到邀请 成功的回调
  newInvitedSendSuccessCallBack() {
    content.value = "正在等待对方接受邀请";
    EasyLoading.showToast("已发出语音邀请", duration: Duration(seconds: 3));
  }

  ///发送邀请
  @override
  Future<ActionCallback> call(
      {required String toUser,
      required String inviterName,
      required String inviterAvatar}) async {
    return await callAction.call(
        toUser: toUser, inviterName: inviterName, inviterAvatar: inviterAvatar);
  }

  @override
  Future<void> cancel() {
    isRejected.value = true;
    return callAction.cancel();
  }

  @override
  void releaseRes() {
    callAction.releaseRes();
  }

  @override
  Future<void> setHandsFree({required bool isHandsFree}) {
    return callAction.setHandsFree(isHandsFree: isHandsFree);
  }

  @override
  bool getCurrentCallStatus() => callAction.getCurrentCallStatus();
}
