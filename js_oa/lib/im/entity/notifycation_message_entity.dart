/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-14 10:38:11
 * @Description: 自定义消息的实体  业务流程处理过程中 需要向相应用户推送消息的  消息实体类
 * @FilePath: \js_oa\lib\im\entity\notifycation_message_entity.dart
 * @LastEditTime: 2021-12-22 17:24:19
 */
class CustomMessageData {
  String? approvalTitle;
  String? title;
  String? workflowId;
  String? routePath;
  List<CustomMessageBody>? contentList;
  CustomMessageData({
    this.approvalTitle,
    this.title,
    this.routePath,
    this.workflowId,
    this.contentList,
  });
  CustomMessageData.fromJson(Map<String, dynamic> json) {
    approvalTitle = json["approvalTitle"];
    title = json["title"];
    workflowId = json['workflowId'];
    routePath = json['routePath'];
    if (json['contentList'] != null) {
      contentList = [];
      json['contentList'].forEach((v) {
        contentList!.add(new CustomMessageBody.fromJson(v));
      });
    }
  }
}

class CustomMessageBody {
  String? content;
  CustomMessageBody({this.content});
  CustomMessageBody.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }
}
