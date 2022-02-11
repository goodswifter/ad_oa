/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-17 17:53:49
 * @Description: 语音动作状态返回
 * @FilePath: \js_oa\lib\im\voice_call\call_back_entiry.dart
 * @LastEditTime: 2021-11-17 17:53:50
 */
class ActionCallback {
  /// 错误码
  int code;

  /// 信息描述
  String desc;

  ActionCallback({this.code = 0, this.desc = ''});
}
