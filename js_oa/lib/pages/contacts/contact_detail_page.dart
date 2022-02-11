/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 08:59:34
 * @Description: 联系人详情
 * @FilePath: \js_oa\lib\pages\contacts\contact_detail_page.dart
 * @LastEditTime: 2021-12-31 15:24:57
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';
import 'package:photo_view/photo_view.dart';

class ContactDetailPage extends StatefulWidget {
  ContactDetailPage({Key? key}) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  String _name = "";
  String _faceUrl = "";
  String _imId = "";
  bool _sex = true;
  List<Map<String, dynamic>> _list = [];
  int type = 0;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? arguments = Get.arguments;
    if (arguments == null) {
      type = 1;
      MessageController messageController = Get.find();
      messageController
          .requestContactDetailByid(Get.parameters['id']!)
          .then((value) {
        _name = value.userName ?? "";
        _faceUrl = value.avatar ?? _name;
        _imId = value.id.toString();
        _sex = value.sex ?? true;
        String _phoneNumber = value.phoneNumber ?? "";
        String _organizationUnitName = value.organizationUnitName ?? "";
        String _organizationUnitFullName = value.organizationUnitFullName ?? "";
        String _email = value.email ?? "";
        _list.add({"姓名": _name});
        _list.add({"电话": _phoneNumber});
        _list.add({"职位": _organizationUnitName});
        _list.add({"部门": _organizationUnitFullName});
        _list.add({"邮箱": _email});
        _list.add({"发消息": ""});
        setState(() {});
      });
    } else {
      type = 0;
      _name = arguments['name'];
      _faceUrl = arguments['faceUrl'] ?? _name;
      _imId = arguments['im_Id'];
      _sex = arguments['sex'];
      final String _phoneNumber = arguments['phoneNumber'];
      final String _organizationUnitFullName =
          arguments['organizationUnitFullName'];
      final String _email = arguments['email'];
      final String _organizationUnitName = arguments['organizationUnitName'];
      _list.add({"姓名": _name});
      _list.add({"电话": _phoneNumber});
      _list.add({"职位": _organizationUnitName});
      _list.add({"部门": _organizationUnitFullName});
      _list.add({"邮箱": _email});
      _list.add({"发消息": ""});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: JSColors.background_grey_light,
        appBar: AppBar(
          toolbarHeight: 48,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: JSColors.black,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "个人信息",
            style: TextStyle(fontSize: 18, color: JSColors.black),
          ),
        ),
        body: ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildAvatarWidget();
              } else if (index == _list.length - 1) {
                return _buildSendButton();
              } else {
                String title = "";
                String content = "";
                _list[index].forEach((k, v) {
                  title = k;
                  content = v;
                });
                return _builDescription(title, content);
              }
            }));
  }

  void showPhoto(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return GestureDetector(
        child: SizedBox.expand(
          child: Hero(
            tag: _name,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: PhotoView(
                imageProvider: NetworkImage(_faceUrl),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      );
    }));
  }

  ///头像部分
  _buildAvatarWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: JSColors.hexToColor("ededed"), width: 0.7),
              top: BorderSide(
                  color: JSColors.hexToColor("ededed"), width: 0.7))),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: GestureDetector(
              onTap: () {
                showPhoto(context);
              },
              child: Hero(
                tag: _name,
                child: Avatar(
                  radius: 4.8,
                  width: 52,
                  height: 52,
                  avatar: _faceUrl,
                  userName: _name,
                ),
              ),
            ),
          ),
          Text(
            _name,
            style: TextStyle(color: JSColors.black, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.person,
              size: 20,
              color: _sex
                  ? Colors.blue.withOpacity(0.85)
                  : const Color.fromARGB(255, 231, 145, 142),
            ),
          )
        ],
      ),
    );
  }

  Widget _builDescription(String title, String description) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom:
                  BorderSide(color: JSColors.hexToColor("ededed"), width: 0.7),
            )),
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: JSColors.black, fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                description,
                style: TextStyle(color: JSColors.black, fontSize: 15),
              ),
            )
          ],
        ));
  }

  ///发送消息按钮
  Widget _buildSendButton() {
    return InkWell(
      onTap: () {
        if (type == 0) {
          Map<String, dynamic> argument = Map();
          argument['conversationID'] = "c2c_$_imId";
          argument['userID'] = _imId;
          argument['conversationName'] = _name;
          argument['unreadCount'] = 0;
          Get.toNamed(AppRoutes.conversation, arguments: argument);
        } else {
          Get.back();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        margin: const EdgeInsets.all(18),
        child: Text(
          "发消息",
          style: TextStyle(color: JSColors.white, fontSize: 16),
        ),
      ),
    );
  }
}
