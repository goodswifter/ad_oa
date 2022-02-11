/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-18 10:38:28
 * @Description: 语音邀请实体请求
 * @FilePath: \js_oa\lib\im\entity\voice_call_entity.dart
 * @LastEditTime: 2021-11-19 17:58:20
 */
import 'package:js_oa/im/voice_call/call_action_interface.dart';

class VoiceCallSiganlEntity {
  String? inviteTypeName;

  ///1:邀请 2:同意 3:拒绝 4:挂断
  int? callType;
  String? inviterAvatar;
  String? inviterName;
  int? roomId;
  int? timeout;

  VoiceCallSiganlEntity(
      {this.callType,
      this.inviteTypeName,
      this.inviterAvatar,
      this.inviterName,
      this.timeout,
      this.roomId});
  VoiceCallSiganlEntity.fromJson(Map<String, dynamic> json) {
    inviteTypeName = json['inviteTypeName'];
    callType = json['callType'];
    inviterAvatar = json['inviterAvatar'];
    inviterName = json['inviterName'];
    roomId = json['roomId'];
    timeout = json['timeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    if (this.inviteTypeName != null) {
      data['inviteTypeName'] = this.inviteTypeName;
    }
    if (this.callType != null) {
      data['callType'] = this.callType;
    }
    if (this.inviterAvatar != null) {
      data['inviterAvatar'] = this.inviterAvatar;
    }
    if (this.roomId != null) {
      data['roomId'] = this.roomId;
    }
    if (this.inviteTypeName != null) {
      data['inviterName'] = this.inviterName;
    }
    if (this.timeout != null) {
      data['timeout'] = this.timeout;
    }

    data[CallAction.callType] = 1;
    return data;
  }
}
