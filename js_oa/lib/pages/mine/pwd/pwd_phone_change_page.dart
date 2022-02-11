import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/service/mine/verification_code_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/text_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/verification_code_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-02 17:56:58
/// Description  :
///

class PwdPhoneChangePage extends StatefulWidget {
  @override
  State<PwdPhoneChangePage> createState() => _PwdPhoneChangePageState();
}

class _PwdPhoneChangePageState extends State<PwdPhoneChangePage> {
  bool _isVerificationCodeSuccess = false;
  bool _isShowVerificationCodeError = false;
  String _verificationCodeText = "";
  final LoginController loginCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("密码修改"),
        backgroundColor: appThemeData.canvasColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Gaps.vGap10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TextUtil.hideNumber(loginCtrl.userinfo().phoneNumber),
                    style: TextStyles.textBold22,
                  ),
                ),
                Gaps.vGap15,
                VerificationCodeTextField(
                    isShowError: _isShowVerificationCodeError,
                    errorTip: "验证码错误, 请重新输入",
                    onChanged: (text) {
                      _verificationCodeText = text;
                      _isVerificationCodeSuccess =
                          text.length > 3 && text.length < 7;
                      setState(() {});
                    },
                    verificationCodePressed: () {
                      VerificationCodeRequest.getVerificationCode(
                        phoneNumber: loginCtrl.userinfo().phoneNumber!,
                        success: (data) {},
                        failure: (error) {},
                      );
                    }),
                Gaps.vGap32,
                ConfirmButton(
                  title: "下一步，设置密码",
                  onPressed: _isVerificationCodeSuccess
                      ? () {
                          VerificationCodeRequest.verifyVerificationCode(
                            phoneNumber: loginCtrl.userinfo().phoneNumber!,
                            verificationCode: _verificationCodeText,
                            success: (data) {
                              if (data) {
                                Get.toNamed(AppRoutes.pwdPhoneChangeSetting,
                                    arguments: _verificationCodeText);
                              } else {
                                EasyLoading.showError("验证码错误或过期, 请重新输入");
                              }
                            },
                            failure: (error) {},
                          );
                        }
                      : null,
                ),
                Gaps.vGap10,
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "密码验证修改",
                    style: TextStyles.textSize16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
