import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/verification_code/verification_code_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/mine/verification_code_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/phone_text_field.dart';
import 'package:js_oa/widgets/text_field/verification_code_text_field.dart';

class ForgetPwdPage extends StatefulWidget {
  @override
  State<ForgetPwdPage> createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {
  final VerificationCodeController vcCtrl = Get.find();
  String _phoneText = "";
  String _verificationCodeText = "";
  bool _isShowPhoneError = false;
  bool _isStartTimer = false;
  bool _isShowVerificationCodeError = false;
  bool _isNext = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("忘记密码"),
        backgroundColor: appThemeData.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.vGap10,
            PhoneTextField(
              defaultText: _phoneText,
              onChanged: (text) {
                _phoneText = text;
                _isShowPhoneError = false;
                _isNext = RegexUtil.isPhone(text) &&
                    _verificationCodeText.length == 6;
                if (text.length == 11) {
                  _isShowPhoneError = !RegexUtil.isPhone(_phoneText);
                  _isStartTimer = !_isShowPhoneError;
                } else {
                  _isStartTimer = false;
                }
                setState(() {});
              },
              isShowError: _isShowPhoneError,
              errorTip: "手机号码格式错误",
            ),
            Gaps.vGap24,
            VerificationCodeTextField(
              isShowError: _isShowVerificationCodeError,
              errorTip: "验证码错误, 请重新输入",
              isStartTimer: _isStartTimer,
              startSecond: vcCtrl.forgetPwdSecond(),
              verificationCodePressed: () {
                _isShowPhoneError = !RegexUtil.isPhone(_phoneText);
                if (_isStartTimer) {
                  VerificationCodeRequest.getVerificationCode(
                    phoneNumber: _phoneText,
                    codeType: CodeType.password,
                    success: (data) {
                      EasyLoading.showToast('验证码已发送');
                    },
                    failure: (error) {
                      EasyLoading.showError(error);
                    },
                  );
                }
                setState(() {});
              },
              countDownChanged: (second) {
                vcCtrl.forgetPwdSecond.value = second;
              },
              onChanged: (text) {
                _verificationCodeText = text;
                _isShowVerificationCodeError = false;
                _isNext = RegexUtil.isPhone(_phoneText) && text.length == 6;
                setState(() {});
              },
            ),
            Gaps.vGap50,
            ConfirmButton(
              title: "下一步",
              onPressed: _isNext ? () => nextFn() : null,
            ),
            Gaps.vGap50,
          ],
        ),
      ),
    );
  }

  void nextFn() {
    VerificationCodeRequest.verifyVerificationCode(
      phoneNumber: _phoneText,
      verificationCode: _verificationCodeText,
      codeType: CodeType.password,
      success: (data) {
        Get.toNamed(AppRoutes.forgetPwdModify, arguments: {
          "phoneNumber": _phoneText,
          "verificationCode": _verificationCodeText
        });
      },
      failure: (error) {
        EasyLoading.showError(error);
      },
    );
  }
}
