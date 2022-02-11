import 'package:intl/intl.dart';

class FormatTime {
  static String timeStr(String? time) {
    if (time == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse(time).toLocal());
  }
}
