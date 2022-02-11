///
/// Author       : zhongaidong
/// Date         : 2021-12-02 14:35:29
/// Description  :
///

enum UploadFileType {
  avatar, // 个人头像
  payment, // 缴费
}

extension UploadFileTypeExtension on UploadFileType {
  String get value => ['avatar', 'payment'][index];
}
