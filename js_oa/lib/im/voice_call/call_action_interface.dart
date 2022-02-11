/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-17 17:47:20
 * @Description: 语音通话 动作接口
 * @FilePath: \js_oa\lib\im\voice_call\call_action_interface.dart
 * @LastEditTime: 2021-12-16 16:54:23
 */
import 'package:js_oa/im/voice_call/call_back_entity.dart';

abstract class CallAction {
  static final String callType = "callType";

  ///邀请一个用户进行语音通话，发送信令消息 等待对方响应
  Future<ActionCallback> call(
      {required String toUser,
      required String inviterName,
      required String inviterAvatar});

  ///被邀请者 接受语音请求，开始通话
  Future<ActionCallback> accept(
      {required String inviteID, required int roomid});

  ///被邀请者拒绝通话
  Future<ActionCallback> reject({required String inviteID});

  ///当处于通话中状态 调用hangup挂断通话
  Future<void> hangup({String? inviteID, String? toUser});

  ///没接通前，取消通话
  Future<void> cancel();

  ///设置是否开发免提
  Future<void> setHandsFree({required bool isHandsFree});

  ///退出后释放资源
  void releaseRes();

  ///获取当前通话状态:  true：在房间中  false：未在房间中
  bool getCurrentCallStatus();
}
