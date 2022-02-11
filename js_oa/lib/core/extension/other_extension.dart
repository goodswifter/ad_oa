///
/// Author       : zhongaidong
/// Date         : 2021-11-09 15:55:26
/// Description  :
///

enum Sex {
  woman,
  man,
}

extension SexExtension on Sex {
  String get value => ['女', '男'][index];
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head,
}

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
