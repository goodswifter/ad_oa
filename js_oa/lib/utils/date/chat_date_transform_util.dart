/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-07 14:27:41
 * @Description: 聊天/会话页面  时间格式转化
 * @FilePath: \js_oa\lib\utils\date\chat_date_transform_util.dart
 * @LastEditTime: 2021-11-24 17:42:00
 */
enum DateTimeMessageType {
  conversationList, //会话列表右侧时间戳
  chatContent //对话详情 时间戳提示
}

class ChatDateTransformUtils {
  static String getNewChatTime(
      {required int timesamp, required DateTimeMessageType timesampType}) {
    String result = "";
    String symbolYear = "年";
    String symbolMonth = "月";
    String symbolDay = "日";
    if (timesampType == DateTimeMessageType.conversationList) {
      symbolYear = "/";
      symbolMonth = "/";
      symbolDay = "";
    }
    int time = timesamp * 1000;
    DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(time);
    DateTime now = DateTime.now();
    int yearNow = now.year;
    int yearMessage = messageTime.year;
    if (yearMessage == yearNow) {
      //同一年
      int monthMessage = messageTime.month;
      int monthNow = now.month;
      if (monthNow == monthMessage) {
        //同一月
        int dayMessage = messageTime.day;
        int dayNow = now.day;
        if (dayMessage == dayNow) {
          //同一天
          int hourMessage = messageTime.hour;
          int hourNow = now.hour;
          if (hourMessage == hourNow) {
            //同一小时
            result =
                "${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
            if (timesampType == DateTimeMessageType.conversationList) {
              if ((messageTime.minute != now.minute)) {
                int temp = (now.minute) - (messageTime.minute);
                result = "$temp分钟前";
              } else if (messageTime.minute == now.minute) {
                result = "刚刚";
              }
            }
          } else {
            //非同一小时
            String dayTime = "";
            if (hourMessage >= 0 && hourMessage < 6) {
              dayTime = "凌晨";
            } else if (hourMessage >= 6 && hourMessage < 12) {
              dayTime = "上午";
            } else if (hourMessage == 12) {
              dayTime = "中午";
            } else if (hourMessage > 12 && hourMessage < 18) {
              dayTime = "下午";
            } else if (hourMessage >= 18) {
              dayTime = "晚上";
            }
            result =
                "$dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
          }
        } else {
          //同月不同天
          int paddingDay = (dayNow - dayMessage).abs();
          if (paddingDay <= 6) {
            //差6天以内 有可能在同一周
            switch (paddingDay) {
              case 1:
                result =
                    "昨天 ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
                if (timesampType == DateTimeMessageType.chatContent) {
                  String dayTime = _getDayTimeByHour(messageTime.hour);
                  result =
                      "昨天$dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
                }
                break;
              case 2:
              case 3:
              case 4:
              case 5:
              case 6:
                result =
                    "${messageTime.month}$symbolMonth${messageTime.day}$symbolDay";
                if (timesampType == DateTimeMessageType.chatContent) {
                  String dayTime = _getDayTimeByHour(messageTime.hour);
                  result =
                      "${messageTime.month}$symbolMonth${messageTime.day}$symbolDay $dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
                }
                break;
              default:
            }
          } else {
            //同月 大于6天  一定不同周
            result =
                "${messageTime.month}$symbolMonth${messageTime.day}$symbolDay";
            if (timesampType == DateTimeMessageType.chatContent) {
              String dayTime = _getDayTimeByHour(messageTime.hour);
              result =
                  "${messageTime.month}$symbolMonth${messageTime.day}$symbolDay $dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
            }
          }
        }
      } else {
        ///同年不用月
        result =
            "${messageTime.year}$symbolYear${messageTime.month}$symbolMonth${messageTime.day}$symbolDay";
        if (timesampType == DateTimeMessageType.chatContent) {
          String dayTime = _getDayTimeByHour(messageTime.hour);
          result =
              "${messageTime.year}$symbolYear${messageTime.month}$symbolMonth${messageTime.day}$symbolDay $dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
        }
      }
    } else {
      ///不同年
      result =
          "${messageTime.year}$symbolYear${messageTime.month}$symbolMonth${messageTime.day}$symbolDay";
      if (timesampType == DateTimeMessageType.chatContent) {
        String dayTime = _getDayTimeByHour(messageTime.hour);
        result =
            "${messageTime.year}$symbolYear${messageTime.month}$symbolMonth${messageTime.day}$symbolDay $dayTime ${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}";
      }
    }
    return result;
  }

  static String _getDayTimeByHour(int hour) {
    String dayTime = "";
    if (hour >= 0 && hour < 6) {
      dayTime = "凌晨";
    } else if (hour >= 6 && hour < 12) {
      dayTime = "上午";
    } else if (hour == 12) {
      dayTime = "中午";
    } else if (hour > 12 && hour < 18) {
      dayTime = "下午";
    } else if (hour >= 18) {
      dayTime = "晚上";
    }
    return dayTime;
  }
}
