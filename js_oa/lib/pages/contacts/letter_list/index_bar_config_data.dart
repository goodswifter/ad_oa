/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:37:12
 * @Description: 索引 相关数据配置
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\index_bar_config_data.dart
 * @LastEditTime: 2021-11-15 09:47:07
 */
class IndexBarDragDetails {
  static const int actionDown = 0;
  static const int actionUp = 1;
  static const int actionUpdate = 2;
  static const int actionEnd = 3;
  static const int actionCancel = 4;

  int? action;
  int? index;
  String? tag;

  double? localPositionY;
  double? globalPositionY;

  IndexBarDragDetails({
    this.action,
    this.index,
    this.tag,
    this.localPositionY,
    this.globalPositionY,
  });
}

///默认的顶部自定义布局的tag标签
const String TITLETAG = "↑";

///默认的全26字母索引 无网络数据后显示
const List<String> mBarData = const [
  TITLETAG,
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
  '#'
];
