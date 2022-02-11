import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/verification_code/verification_code_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/pages/mine/phone/phone_title_widget.dart';
import 'package:js_oa/pages/mine/phone/verification_entity.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/mine/verification_code_request.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/phone_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-07 16:37:42
/// Description  :
///

class PhoneModifyPage extends StatefulWidget {
  @override
  State<PhoneModifyPage> createState() => _PhoneModifyPageState();
}

class _PhoneModifyPageState extends State<PhoneModifyPage> {
  final vcCtrl = Get.put(VerificationCodeController());
  bool isPhone = false;
  String newPhone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appThemeData.canvasColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PhoneTitleWidget(title: "绑定新的手机号码"),
            PhoneTextField(
              hintText: "请输入新手机号码",
              autofocus: true,
              onChanged: (text) {
                isPhone = text.length == 11;
                newPhone = text;
                setState(() {});
              },
            ),
            Gaps.vGap24,
            ConfirmButton(
              title: "下一步",
              onPressed: isPhone ? () => nextFn(newPhone) : null,
            )
          ],
        ),
      ),
    );
  }

  void nextFn(String newPhone) {
    if (RegexUtil.isPhone(newPhone)) {
      if (vcCtrl.modifyPhoneSecond() > 0) {
        Get.toNamed(
          AppRoutes.phoneVerification,
          arguments: VerificationEntity(
            account: newPhone,
            inputType: InputType.phone,
          ),
        );
      } else {
        VerificationCodeRequest.getVerificationCode(
          phoneNumber: newPhone,
          codeType: CodeType.modifyPhoneNumber,
          success: (data) {
            Get.toNamed(
              AppRoutes.phoneVerification,
              arguments: VerificationEntity(
                account: newPhone,
                inputType: InputType.phone,
              ),
            );
          },
          failure: (error) {
            print(error);
          },
        );
      }
    } else {
      ToastUtil.showToast("手机号输入格式不正确");
    }
  }
}
