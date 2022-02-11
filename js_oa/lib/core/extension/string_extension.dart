///
/// Author       : zhongaidong
/// Date         : 2021-10-22 11:09:59
/// Description  :
///

extension StringExtension on String? {
  String get nullSafe => this ?? '';

  bool get isEmptyOrNull => this == null || this!.isEmpty;
}
