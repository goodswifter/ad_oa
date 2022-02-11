import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/widgets/text_field/title_pwd_text_field.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-31 09:54:13
/// Description  : 通过密码修改
///

class PwdChangePage extends StatefulWidget {
  @override
  State<PwdChangePage> createState() => _PwdChangePageState();
}

class _PwdChangePageState extends State<PwdChangePage> {
  final String pwdTip = "密码需为8~20位，数字、英文和符号的至少两种组合。";
  String _currentPwd = "";
  String _newPwd = "";
  String _confirmPwd = "";
  bool isConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("密码修改"),
        backgroundColor: appThemeData.canvasColor,
      ),
      body: buildPwdList(),
    );
  }

  Widget buildPwdList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gaps.vGap24,
          TitlePwdTextField(
            title: "当前密码",
            hintText: "6~20位符号",
            onChanged: (text) {
              _currentPwd = text;
              isConfirm = isComfirm(_currentPwd, _newPwd, _confirmPwd);
            },
          ),
          TitlePwdTextField(
            title: "新密码",
            hintText: "8~20位符号",
            onChanged: (text) {
              _newPwd = text;
              isConfirm = isComfirm(_currentPwd, _newPwd, _confirmPwd);
            },
          ),
          TitlePwdTextField(
            title: "确认密码",
            hintText: "8~20位符号",
            onChanged: (text) {
              _confirmPwd = text;
              isConfirm = isComfirm(_currentPwd, _newPwd, _confirmPwd);
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(pwdTip, maxLines: 2),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ConfirmButton(
              onPressed: isConfirm
                  ? () async {
                      if (_newPwd != _confirmPwd) {
                        ToastUtil.showToast("两次密码不一致");
                      } else if (_newPwd == _currentPwd) {
                        ToastUtil.showToast("新密码不能与旧密码相同");
                      } else {
                        await UserRequest.modifyPwdByPwd(
                          oldPassword: _currentPwd,
                          newPassword: _newPwd,
                          success: (data) {
                            ToastUtil.showToast("修改密码成功");
                            Get.back();
                          },
                          failure: (error) {
                            print(error);
                          },
                        );
                      }
                    }
                  : null,
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.pwdPhoneChange),
            child: Text(
              "短信验证修改",
              style: TextStyles.textSize16,
            ),
          )
        ],
      ),
    );
  }

  bool isComfirm(String currentPwd, String newPwd, String confirmPwd) {
    if (currentPwd.isEmpty || newPwd.isEmpty || confirmPwd.isEmpty)
      return false;
    setState(() {});
    bool currentPwdIsValid = RegexUtil.isPwd6_20(currentPwd);
    bool newPwdIsValid = RegexUtil.isPwd8_20(newPwd);
    bool confirmPwdIsValid = RegexUtil.isPwd8_20(confirmPwd);
    return currentPwdIsValid && newPwdIsValid && confirmPwdIsValid;
  }
}
