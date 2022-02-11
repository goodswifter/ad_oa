import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/verification_code/verification_code_controller.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/login/account_login_param.dart';
import 'package:js_oa/service/login/login_request.dart';
import 'package:js_oa/service/mine/verification_code_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/load_image.dart';
import 'package:js_oa/widgets/text_field/phone_text_field.dart';
import 'package:js_oa/widgets/text_field/verification_code_text_field.dart';

import '../user_protocol/user_protocol_widget.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-15 16:45:06
/// Description  : 验证码登录界面
///

class LoginVCPage extends StatefulWidget {
  @override
  State<LoginVCPage> createState() => _LoginVCPageState();
}

class _LoginVCPageState extends State<LoginVCPage> {
  final vcCtrl = Get.put(VerificationCodeController());
  String _phoneText = "";
  String _verificationCodeText = "";
  bool _isShowPhoneError = false;
  bool _isStartTimer = false;
  bool _isShowVerificationCodeError = false;
  bool _isLogin = false;
  bool _isSelectedUserProtocol = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoutes.loginAccount),
              child: Text('密码登录'),
            ),
          ),
        ],
        backgroundColor: appThemeData.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.vGap32,
            LoadImage(R.ASSETS_IMAGES_LOGIN_LG_LOGO_PNG),
            Gaps.vGap50,
            PhoneTextField(
              defaultText: _phoneText,
              onChanged: (text) {
                _phoneText = text;
                _isShowPhoneError = false;
                _isLogin = RegexUtil.isPhone(text) &&
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
              verificationCodePressed: () async {
                _isShowPhoneError = !RegexUtil.isPhone(_phoneText);
                if (_isStartTimer) {
                  await VerificationCodeRequest.getVerificationCode(
                      phoneNumber: _phoneText,
                      codeType: CodeType.login,
                      success: (user) {
                        EasyLoading.showToast('验证码已发送');
                      },
                      failure: (error) {
                        EasyLoading.showError(error);
                      });
                }
                setState(() {});
              },
              countDownChanged: (time) => vcCtrl.vcLoginSecond.value = time,
              onChanged: (text) {
                _verificationCodeText = text;
                _isShowVerificationCodeError = false;
                _isLogin = RegexUtil.isPhone(_phoneText) && text.length == 6;
                setState(() {});
              },
            ),
            UserProtocolWidget(
              onChanged: (value) => _isSelectedUserProtocol = value,
            ),
            ConfirmButton(
              title: '登录',
              onPressed: _isLogin
                  ? () async {
                      if (_isSelectedUserProtocol) {
                        LoginRequest.getUserAuthToken(
                          account: _phoneText,
                          password: _verificationCodeText,
                          loginType: LoginType.verificationCode,
                          success: (user) async {
                            await EasyLoading.showSuccess("登录成功");
                            Get.offAllNamed(AppRoutes.main);
                          },
                          failure: (error) {
                            EasyLoading.showError(error!.message);
                          },
                        );
                      } else {
                        EasyLoading.showToast('请先阅读并同意协议');
                      }
                    }
                  : null,
            ),
            Gaps.vGap50,
          ],
        ),
      ),
    );
  }
}
