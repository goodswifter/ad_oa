import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/title_pwd_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-22 09:55:50
/// Description  :
///

class ForgetPwdModifyPage extends StatefulWidget {
  @override
  State<ForgetPwdModifyPage> createState() => _ForgetPwdModifyPageState();
}

class _ForgetPwdModifyPageState extends State<ForgetPwdModifyPage> {
  final String _pwdTip = "密码需为8~20位，数字、英文和符号的至少两种组合。";

  String _newPwd = "";

  String _confirmPwd = "";

  bool _isConfirm = false;

  @override
  Widget build(BuildContext context) {
    Map arguments = Get.arguments;
    String _phoneNumber = arguments["phoneNumber"];
    String _verificationCode = arguments["verificationCode"];
    return Scaffold(
      appBar: AppBar(
        title: Text("密码修改"),
        backgroundColor: appThemeData.canvasColor,
      ),
      body: buildPwdList(code: _verificationCode, phoneNumber: _phoneNumber),
    );
  }

  Widget buildPwdList({required String phoneNumber, required String code}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gaps.vGap24,
          TitlePwdTextField(
            title: "新密码",
            hintText: "8~20位符号",
            onChanged: (text) {
              _newPwd = text;
              _isConfirm = isComfirm(_newPwd, _confirmPwd);
            },
          ),
          TitlePwdTextField(
            title: "确认密码",
            hintText: "8~20位符号",
            onChanged: (text) {
              _confirmPwd = text;
              _isConfirm = isComfirm(_newPwd, _confirmPwd);
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(_pwdTip, maxLines: 2),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ConfirmButton(
              onPressed: _isConfirm
                  ? () {
                      if (_newPwd != _confirmPwd) {
                        ToastUtil.showToast("两次密码不一致");
                      } else {
                        UserRequest.modifyPwdByCode(
                          code: code,
                          phoneNumber: phoneNumber,
                          password: _newPwd,
                          success: (data) {
                            Get.offNamedUntil(
                              AppRoutes.loginAccount,
                              (route) =>
                                  route.settings.name == AppRoutes.loginAccount,
                            );
                            ToastUtil.showToast("修改密码成功");
                          },
                          failure: (error) {},
                        );
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  bool isComfirm(String newPwd, String confirmPwd) {
    if (newPwd.isEmpty || confirmPwd.isEmpty) return false;
    bool newPwdIsValid = RegexUtil.isPwd8_20(newPwd);
    bool confirmPwdIsValid = RegexUtil.isPwd8_20(confirmPwd);
    setState(() {});
    return newPwdIsValid && confirmPwdIsValid;
  }
}
