/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-02 15:57:18
 * @Description: 语音通话页面
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\rtc_calling\calling_widget.dart
 * @LastEditTime: 2021-12-16 17:29:07
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/voice_call/voice_call_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp_util/sp_util.dart';

class CallingPage extends StatefulWidget {
  CallingPage({
    Key? key,
  }) : super(key: key);

  @override
  _CallingPageState createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  late final String faceUrl;
  late final String name;
  late final String toUser;
  late final bool? isInviter;
  late final String inviteId;
  late final int roomid;
  VoiceCallController voiceCallController = Get.put(VoiceCallController());
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    name = arguments['name'];
    faceUrl = arguments['faceUrl'];
    isInviter = arguments['isInviter'];
    toUser = arguments['toUser'];
    if (isInviter == null) {
      inviteId = arguments['inviteId'];
      roomid = arguments['roomid'];
      voiceCallController.indexStackType.value = 1;
      _requestMicrophonePermission();
    } else if (isInviter!) {
      _sendRtcInvited();
    } else if (!isInviter!) {
      inviteId = arguments['inviteId'];
      roomid = arguments['roomid'];
      _requestMicrophonePermission();
      _acceptInvitation();
    }
    voiceCallController.setOnRejectListener(() {
      voiceCallController.releaseRes();
      Get.back();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _requestMicrophonePermission() async {
    await Permission.microphone.request();
  }

  _sendRtcInvited() async {
    voiceCallController.indexStackType.value = 0;
    dynamic user = SpUtil.getObject("userinfo");
    UserEntity userInfo = UserEntity.fromJson(user);
    String myName = userInfo.realName ?? userInfo.userName!;
    String myAvatar = userInfo.avatar ?? userInfo.userName!;
    voiceCallController.call(
        toUser: toUser, inviterName: myName, inviterAvatar: myAvatar);
  }

  _acceptInvitation() async {
    await voiceCallController.accept(inviteID: inviteId, roomid: roomid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: GestureDetector(
        onHorizontalDragCancel: null,
        onHorizontalDragDown: null,
        onHorizontalDragEnd: null,
        onHorizontalDragStart: null,
        onHorizontalDragUpdate: null,
        onVerticalDragCancel: null,
        onVerticalDragDown: null,
        onVerticalDragEnd: null,
        onVerticalDragStart: null,
        onVerticalDragUpdate: null,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              //构建背景图
              _buildBgWidget(size),
              //构建高斯模糊层
              _buildBlurBg(),
              //构建通话按钮
              _buildCallingButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBgWidget(Size size) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Image.network(
        faceUrl,
        fit: BoxFit.fill,
        errorBuilder: (context, error, s) {
          return Image.asset(
            'assets/images/message/titian.jpg',
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  _buildBlurBg() {
    return Container(
      color: Color.fromARGB(149, 0, 0, 0),
    );
  }

  _buildCallingButtons() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: JSColors.white.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 45,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: PhysicalModel(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      faceUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, s) {
                        return Image.asset(
                          'assets/images/message/titian.jpg',
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Obx(() => Text(
                        voiceCallController.content.value,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(78),
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Obx(() => IndexedStack(
                    index: voiceCallController.indexStackType.value,
                    children: [
                      _buildIntiteSuccessedBottomWidget(),
                      _buildUnAcceptBottomWidget()
                    ],
                  ))),
        ],
      ),
    );
  }

  ///构建接通后 或是 邀请者的底部布局
  _buildIntiteSuccessedBottomWidget() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.volume_down),
              Text(
                "静音",
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
          Expanded(
              child: InkWell(
            onTap: () async {
              if (isInviter == null || !isInviter!) {
                await voiceCallController.hangup(inviteID: inviteId);
              } else {
                await voiceCallController.hangup(toUser: toUser);
              }

              EasyLoading.dismiss();
              Get.back();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(45)),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
              ),
            ),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.speaker),
              Text(
                "免提",
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
        ],
      ),
    );
  }

  ///构建还未接通时  底部的布局
  _buildUnAcceptBottomWidget() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              voiceCallController.reject(inviteID: inviteId).then((value) {
                EasyLoading.dismiss();
                Get.back();
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(45)),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _acceptInvitation();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(45)),
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
