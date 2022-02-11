import 'package:f_shake_animation_widget/f_shake_animation_widget.dart';
import 'package:f_verification_box/f_verification_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/verification_code/verification_code_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/mine/phone/verification_entity.dart';
import 'package:js_oa/res/dimens.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/service/mine/verification_code_request.dart';
import 'package:js_oa/widgets/verification_code_button.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-09 17:25:40
/// Description  :
///

class CommonVerficationBox extends StatefulWidget {
  CommonVerficationBox({
    required this.account,
    this.onSubmitted,
    this.inputType = InputType.phone,
  });
  final OnSubmitted? onSubmitted;

  /// 账户名称
  final String account;

  /// 输入类型
  final InputType inputType;

  @override
  State<CommonVerficationBox> createState() => _CommonVerficationBoxState();
}

class _CommonVerficationBoxState extends State<CommonVerficationBox> {
  final VerificationCodeController vcCtrl = Get.find();

  /// 抖动动画控制器
  final ShakeAnimationController _shakeAnimationController =
      ShakeAnimationController();
  bool isVerifySuccess = true;
  bool isShowErrorTip = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildErrorTipWidget(),
        Container(
          width: 240,
          child: ShakeAnimationWidget(
              shakeAnimationController: _shakeAnimationController,
              shakeAnimationType: ShakeAnimationType.leftRight,
              isForward: false,
              shakeRange: 0.3,
              child: VerificationBox(
                type: VerificationBoxItemType.underline,
                textStyle: TextStyles.textBold24,
                showCursor: true,
                unfocus: false,
                borderWidth: 4,
                itemWidth: 30,
                count: 6,
                cursorColor: Colors.black,
                cursorWidth: 3,
                borderColor: isVerifySuccess ? Colors.black : Colors.red,
                onSubmitted: (text, clear) async {
                  widget.onSubmitted?.call(text, clear);
                  await VerificationCodeRequest.verifyVerificationCode(
                    phoneNumber: widget.account,
                    codeType: CodeType.modifyPhoneNumber,
                    verificationCode: text,
                    success: (data) {
                      if (data) {
                        isVerifySuccess = true;
                        isShowErrorTip = false;
                        Get.offAllNamed(AppRoutes.main);
                      } else {
                        isVerifySuccess = false;
                        isShowErrorTip = true;
                        _shakeAnimationController.start();
                        Future.delayed(
                          Duration(milliseconds: 800),
                          () {
                            isVerifySuccess = true;
                            setState(() {});
                          },
                        );
                        if (clear != null) clear();
                      }
                    },
                  );
                  setState(() {});
                },
                onChanged: (text) {
                  isShowErrorTip = false;
                  setState(() {});
                },
              )),
        ),
        Gaps.vGap15,
        VerificationCodeButton(
          autoOpen: true,
          startSecond: vcCtrl.modifyPhoneSecond(),
          isShowBorder: false,
          onTap: () async {
            await VerificationCodeRequest.getVerificationCode(
              phoneNumber: widget.account,
              codeType: CodeType.modifyPhoneNumber,
            );
          },
          countDownChanged: (second) => vcCtrl.modifyPhoneSecond.value = second,
        ),
      ],
    );
  }

  Widget buildErrorTipWidget() {
    return Container(
      height: 30,
      child: isShowErrorTip
          ? Text("验证码错误",
              style: TextStyle(
                color: Colors.red,
                fontSize: Dimens.font_sp16,
              ))
          : Gaps.empty,
    );
  }
}
