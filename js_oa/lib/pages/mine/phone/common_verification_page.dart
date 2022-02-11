import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/pages/mine/phone/common_verification_box.dart';
import 'package:js_oa/pages/mine/phone/phone_title_widget.dart';
import 'package:js_oa/pages/mine/phone/verification_entity.dart';
import 'package:js_oa/utils/other/text_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-07 17:41:16
/// Description  :
//

class CommonVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VerificationEntity verificationEntity = Get.arguments;
    String account = verificationEntity.account;
    InputType inputType = verificationEntity.inputType;
    // 标题
    String title = "输入短信验证码";
    if (inputType == InputType.email) title = "输入邮箱验证码";

    String subtitle = "验证码已发送${TextUtil.hideNumber(account)}，请在下方输入框内输入6位数字验证码";
    return Scaffold(
      appBar: AppBar(backgroundColor: appThemeData.canvasColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PhoneTitleWidget(
              title: title,
              subtitle: subtitle,
            ),
            CommonVerficationBox(
              account: account,
              onSubmitted: (text, clear) {
                print(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
