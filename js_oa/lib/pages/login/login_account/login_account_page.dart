import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/pages/login/user_protocol/user_protocol_widget.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/login/login_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/load_image.dart';
import 'package:js_oa/widgets/text_field/account_icon_text_field.dart';
import 'package:js_oa/widgets/text_field/icon_pwd_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-18 14:08:14
/// Description  : 账户密码登录界面
///

class LoginAccountPage extends StatefulWidget {
  @override
  State<LoginAccountPage> createState() => _LoginAccountPageState();
}

class _LoginAccountPageState extends State<LoginAccountPage> {
  String _accountText = "";
  String _pwdText = "";
  bool _isLogin = false;
  bool _isSelectedUserProtocol = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text("验证码登录"),
            ),
          ),
        ],
        backgroundColor: appThemeData.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap32,
            LoadImage(R.ASSETS_IMAGES_LOGIN_LG_LOGO_PNG),
            Gaps.vGap50,
            AccountIconTextField(
              onChanged: (text) {
                _accountText = text;
                _isLogin = _accountText.length > 1 && _pwdText.length >= 6;
                setState(() {});
              },
            ),
            Gaps.vGap24,
            IconPwdTextField(
              onChanged: (text) {
                _pwdText = text;
                _isLogin = _accountText.length > 1 && _pwdText.length >= 6;
                setState(() {});
              },
              counterPressed: () => Get.toNamed(AppRoutes.forgetPwd),
            ),
            UserProtocolWidget(
              onChanged: (value) => _isSelectedUserProtocol = value,
            ),
            ConfirmButton(
              title: "登录",
              onPressed: _isLogin
                  ? () async {
                    if (_isSelectedUserProtocol) {
                      LoginRequest.getUserAuthToken(
                        account: _accountText,
                        password: _pwdText,
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
            Gaps.vGap32,
          ],
        ),
      ),
    );
  }
}
