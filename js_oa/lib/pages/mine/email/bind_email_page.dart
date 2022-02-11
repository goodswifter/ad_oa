import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/mine/phone/phone_title_widget.dart';
import 'package:js_oa/pages/mine/phone/verification_entity.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/account_icon_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-07 16:37:42
/// Description  :
///

class BindEmailPage extends StatefulWidget {
  @override
  State<BindEmailPage> createState() => _BindEmailPageState();
}

class _BindEmailPageState extends State<BindEmailPage> {
  bool _isMail = false;
  String _newEmail = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PhoneTitleWidget(title: "绑定邮箱账号"),
            AccountIconTextField(
              hintText: "请输入邮箱账号",
              autofocus: true,
              onChanged: (text) {
                _isMail = RegexUtil.isEmail(text);
                _newEmail = text;
                setState(() {});
              },
            ),
            Gaps.vGap24,
            ConfirmButton(
              title: "下一步",
              onPressed: _isMail ? () => nextFn(_newEmail) : null,
            )
          ],
        ),
      ),
    );
  }

  void nextFn(String email) {
    if (RegexUtil.isEmail(email)) {
      Get.toNamed(
        AppRoutes.phoneVerification,
        arguments:
            VerificationEntity(inputType: InputType.email, account: email),
      );
    } else {
      ToastUtil.showToast("邮箱输入格式不正确");
    }
  }
}
