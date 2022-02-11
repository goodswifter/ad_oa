/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 16:08:41
 * @Description: 索引数据控制器
 * @FilePath: \js_oa\lib\controller\contact\index_bar_detail_controller.dart
 * @LastEditTime: 2022-01-04 16:26:54
 */
import 'dart:collection';

import 'package:get/get.dart';
import 'package:js_oa/entity/contact/contact_list_model.dart';
import 'package:js_oa/service/contact/contact_service.dart';
import 'package:js_oa/utils/contact/contact_letter_util.dart';
import '../../pages/contacts/letter_list/index_bar_config_data.dart';
import '../../pages/contacts/letter_list/index_bar_options.dart';

typedef OverlayShowBuilder = Function();
typedef OnScrollPositionFun = Function(String tag);

class IndexBarDetailController extends GetxController {
  ///手势信息
  ///按下
  static const int actionDown = 0;

  ///抬起
  static const int actionUp = 1;

  ///下滑
  static const int actionUpdate = 2;

  ///下滑结束
  static const int actionEnd = 3;

  ///取消
  static const int actionCancel = 4;

  /// 触发手势的临时变量
  var value = 0.obs;

  ///当前手势动作
  int? action;

  ///当前触摸的index下标.
  int? index;

  ///当前触摸的字母tag.
  String? tag;

  ///当前手势相对父布局的Y坐标
  double? localPositionY;

  ///全屏幕手势的Y坐标
  double? globalPositionY;

  ///****************LetterIndexBar相关************************* */
  double floatTop = 0;
  String indexTag = "";
  int selectIndex = 0;
  int actionIndexBar = IndexBarDragDetails.actionEnd;

  ///*********************LetterListView相关******************************** */
  int itemCount = 1;
  List<Items> contactDatas = [];
  List<Items> top = [];
  List<String> letters = [];
  IndexBarDetailController(
      {this.option, this.itemHeight = kIndexBarItemHeight});
  final IndexBarOption? option;
  final double? itemHeight;
  OverlayShowBuilder? builder;
  OnScrollPositionFun? scrollPostionBuilder;
  List<double> heights = [];
  LinkedHashMap letterOffsetMap = LinkedHashMap();
  double contentTitleItemWithBuilderHeight = 52; //52
  double contentItemHeight = 62;
  double subItemHeight = 30;
  set setContentTitleItemWithBuilderHeight(double height) =>
      contentTitleItemWithBuilderHeight = height;

  double get getContentTitleItemWithBuilderHeight =>
      contentTitleItemWithBuilderHeight;

  set setContentItemHeight(double height) => contentItemHeight = height;

  set setSubItemHeight(double height) => subItemHeight = height;

  setOverlayShow(OverlayShowBuilder builder) {
    this.builder = builder;
  }

  setOnScrollPositionFun(OnScrollPositionFun builder) {
    this.scrollPostionBuilder = builder;
  }

  @override
  void onInit() {
    super.onInit();
    loadContactsData();
    ever(value, (value) {
      selectIndex = index!;
      indexTag = tag!;
      actionIndexBar = action!;
      floatTop =
          globalPositionY! + itemHeight! / 2 - option!.indexHintHeight / 2;
      if (builder != null) {
        builder!.call();
      }
      if (scrollPostionBuilder != null) {
        scrollPostionBuilder!.call(indexTag);
      }
    });
  }

  void loadContactsData() async {
    top.add(Items(
        tagIndex: TITLETAG,
        avatar: "assets/images/contact/3.0x/logo.png",
        userName: "搜索联系人",
        sex: true,
        organizationUnitName: "",
        organizationUnitFullName: "",
        realName: "搜索联系人"));
    ContactService.getInstance()
        .getContactList(pageSize: 300, canShowEasyLoading: true)
        .then((value) {
      if (value.length == 0) {
        letters = mBarData;
      }
      _handleList(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    letters.clear();
  }

  void _handleList(List<Items> list) {
    if (list.isEmpty) return;
    contactDatas = list;
    for (int i = 0; i < contactDatas.length; i++) {
      String realName =
          contactDatas[i].realName ?? contactDatas[i].userName!.trim();
      String pinyin = ContactLetterUtil.getFirstLetterName(realName);
      String tag = pinyin.substring(0, 1).toUpperCase();
      contactDatas[i].letterName = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        contactDatas[i].tagIndex = tag;
      } else {
        contactDatas[i].tagIndex = "#";
      }
      if (pinyin.length > 3) {
        String second = pinyin.substring(1, 2).toUpperCase();
        String third = pinyin.substring(2, 3).toUpperCase();
        if (RegExp("[A-Z]").hasMatch(second)) {
          contactDatas[i].secentLetter = second;
          contactDatas[i].thirdLetter = third;
        } else {
          contactDatas[i].secentLetter = "#";
          contactDatas[i].thirdLetter = "#";
        }
      }
    }

    contactDatas.sort((a, b) {
      if (a.getSuspensionTag() == "@" || b.getSuspensionTag() == "#") {
        return -1;
      } else if (a.getSuspensionTag() == "#" || b.getSuspensionTag() == "@") {
        return 1;
      } else {
        int sort = a.getSuspensionTag().compareTo(b.getSuspensionTag());
        if (sort == 0) {
          sort = a.getSecentLetter().compareTo(b.getSecentLetter());
          if (sort == 0) {
            sort = a.getThirdLetter().compareTo(b.getThirdLetter());
          }
        }
        return sort;
      }
    });

    contactDatas.insertAll(0, top);
    LinkedHashMap map = LinkedHashMap();
    contactDatas.forEach((element) {
      map[element.tagIndex] = element.tagIndex;
    });
    map.forEach((key, value) {
      letters.add(key);
    });
    option!.barData = letters;
    _getAllItemsHeights(contactDatas);
    update(["letterListView"]);
  }

  _getAllItemsHeights(List<Items> list) {
    List<String> strs = option!.barData;
    for (int i = 0; i < strs.length; i++) {
      double offset = 0;
      if (i == 0) {
        offset = 0;
      } else if (i == 1) {
        int index = 0;
        list.forEach((element) {
          String tagName = element.tagIndex!;
          if (tagName == strs[i - 1]) {
            index++;
          }
        });
        offset =
            contentTitleItemWithBuilderHeight + (contentItemHeight * index);
      } else {
        int index = 0;
        list.forEach((element) {
          String tagName = element.tagIndex!;
          if (tagName == strs[i - 1]) {
            index++;
          }
        });
        offset = heights[i - 1] + subItemHeight + (contentItemHeight * index);
      }
      String key = strs[i];
      heights.add(offset);
      letterOffsetMap[key] = offset;
    }
  }

  double getLetterClickToPosition(String tag) {
    return letterOffsetMap[tag];
  }
}
