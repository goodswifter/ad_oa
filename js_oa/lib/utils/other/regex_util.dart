class RegexUtil {
  /// 是否是邮箱
  static bool isEmail(String? email) {
    if (email == null) return false;
    RegExp regExp = RegExp(r'\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*');
    return regExp.hasMatch(email);
  }

  /// 密码为8~20位数字、英文、符号至少两种组合的字符
  static bool isPwd8_20(String? pwd) {
    if (pwd == null) return false;
    // 注意: 正则表达式内容中不能有空格
    // {8,20} 不能写成{8, 20}
    RegExp regExp = RegExp(
        r'^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){8,20}$');
    // RegExp regExp = RegExp(
    //     r'^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){8,20}$');
    return regExp.hasMatch(pwd);
  }

  static bool isPwd6_20(String? pwd) {
    if (pwd == null) return false;
    RegExp regExp = RegExp(
        r'^(?![0-9]+$)(?![a-zA-Z]+$)(?!([^(0-9a-zA-Z)]|[\\(\\)])+$)([^(0-9a-zA-Z)]|[\\(\\)]|[a-zA-Z]|[0-9]){6,20}$');
    return regExp.hasMatch(pwd);
  }

  static bool isPhone(String? phone) {
    if (phone == null) return false;
    RegExp regExp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return regExp.hasMatch(phone);
  }
}
