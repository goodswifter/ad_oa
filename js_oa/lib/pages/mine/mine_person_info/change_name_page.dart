import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/colors.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/account_title_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-10-21 15:57:13
/// Description  :
///

class ChangeNamePage extends StatelessWidget {
  final LoginController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    String name = Get.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("修改姓名"),
        backgroundColor: appThemeData.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap24,
            AccountTitleTextField(
              title: "修改姓名",
              defaultText: name,
              hintText: "请输入姓名",
              autofocus: true,
              maxLength: 16,
              onChanged: (text) => name = text,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "请输入真实姓名, 限4~16个字符, 一个汉字为2个字符",
                style: TextStyle(color: Colours.text),
              ),
            ),
            Gaps.vGap10,
            ConfirmButton(
              onPressed: () {
                UserRequest.modifyRealName(
                  name: name,
                  success: (data) {
                    EasyLoading.showSuccess('修改姓名成功');
                    Get.back();
                  },
                  failure: (error) {
                    EasyLoading.showError(error);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
