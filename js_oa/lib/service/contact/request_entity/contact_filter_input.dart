/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-09 15:46:18
 * @Description: 根据关键字筛选联系人请求实体
 * @FilePath: \js_oa\lib\service\contact\request_entity\contact_filter_input.dart
 * @LastEditTime: 2021-11-23 15:32:27
 */
class FilterContactInput {
  String? keyWord;
  int pageIndex;
  int pageSize;
  static const String pageIndexParameter = "PageIndex";
  static const String pageSizeParameter = "PageSize";
  static const String keyWordParameter = "Keyword";
  FilterContactInput(
      {this.keyWord, required this.pageIndex, required this.pageSize});
}
