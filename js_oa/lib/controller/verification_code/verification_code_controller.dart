import 'package:get/get.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-11-19 10:51:26
/// Description  :
///

class VerificationCodeController extends GetxController {
  /// 忘记密码倒计时数
  var forgetPwdSecond = 0.obs;
  /// 验证码登录倒计时数
  var vcLoginSecond = 0.obs;
  /// 修改手机号倒计时数
  var modifyPhoneSecond = 0.obs;

}
