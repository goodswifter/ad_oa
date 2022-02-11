/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:13:30
 * @Description: 字母索引list 内容部分 数据区域
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\letter_list_content_widget.dart
 * @LastEditTime: 2021-12-07 15:47:23
 */
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/contact/contact_list_model.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';

import 'index_bar_config_data.dart';
import '../../../controller/contact/index_bar_detail_controller.dart';

typedef LetterWholeItemWidgetBuilder = SliverStickyHeader Function(
    BuildContext context);

typedef LetterSubItemBuilder = Widget Function(BuildContext context);

typedef LetterContentTitleItemBuilder = Widget Function(
    BuildContext context, Items contentTitleitem);

typedef LetterContentItemBuilder = SliverList Function(
    BuildContext context, int index);

class LetterListContentView extends StatefulWidget {
  final LetterWholeItemWidgetBuilder? wholeItemBuilder;
  final LetterSubItemBuilder? subItemBuilder;
  final LetterContentItemBuilder? contentItemBuilder;
  final LetterContentTitleItemBuilder? contentTitleItemBuilder;
  final double subItemWithBuilderHeight;

  /// 'A','B','C' 栏的高度
  final double contentItemWithBuilderHeight; //普通item项的高度
  final double? contentTitleItemWithBuilderHeight;

  ///顶部自定义布局的高度
  final Widget topSearchWidget;
  final List<String> data;

  LetterListContentView(
      {Key? key,
      this.wholeItemBuilder,
      this.subItemBuilder,
      this.data = mBarData,
      this.subItemWithBuilderHeight = 30,
      this.contentTitleItemBuilder,
      this.contentItemWithBuilderHeight = 62,
      this.contentTitleItemWithBuilderHeight,
      this.topSearchWidget = const SizedBox(),
      this.contentItemBuilder})
      : super(key: key);

  @override
  _LetterListContentViewState createState() => _LetterListContentViewState();
}

class _LetterListContentViewState extends State<LetterListContentView>
    with WidgetsBindingObserver {
  final IndexBarDetailController _controller = Get.find();
  late final ScrollController _customScrollController;
  final StickyHeaderController _scrollController = StickyHeaderController();
  double _offset = 0.0;
  double _temp = 0.0;
  bool _isCanChange = false;
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if (widget.contentTitleItemWithBuilderHeight != null) {
      _controller.setContentTitleItemWithBuilderHeight =
          widget.contentTitleItemWithBuilderHeight!;
    } else {
      // 如果没有传入顶部自定义布局的高度 通过传递的topSearchWidget或者contentTitleItemBuilder构造器解析出高度
    }
    _controller.setContentItemHeight = widget.contentItemWithBuilderHeight;
    _controller.setSubItemHeight = widget.subItemWithBuilderHeight;
    _customScrollController = ScrollController();
    _customScrollController.addListener(() {
      if (_temp != _offset && _isCanChange) {
        if (_offset == 0.0) {
          _controller.selectIndex = 0;
        } else {
          if (_offset > _temp) {
            _controller.selectIndex++;
          } else if (_offset < _temp) {
            _controller.selectIndex--;
          }
        }
        _temp = _offset;
        _controller.update(["index_bg_color"]);
      }
    });
    _scrollController.addListener(() {
      _isCanChange = true;
      _offset = _scrollController.stickyHeaderScrollOffset;
    });
    _controller.setOnScrollPositionFun((tag) {
      double resultOffset = _controller.getLetterClickToPosition(tag);
      _isCanChange = false;
      _customScrollController.animateTo(resultOffset,
          duration: Duration(microseconds: 200), curve: Curves.decelerate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexBarDetailController>(
        id: "contacts",
        builder: (controller) {
          return CustomScrollView(
            controller: _customScrollController, //,
            physics: BouncingScrollPhysics(),
            slivers: getSliverContactWidgets(controller),
          );
        });
  }

  List<Widget> getSliverContactWidgets(IndexBarDetailController controller) {
    if (!(controller.contactDatas.length > 0)) return const [];
    List<SliverStickyHeader> list = [];
    widget.data.forEach((element) {
      SliverStickyHeader itemWidget;
      if (widget.wholeItemBuilder == null) {
        itemWidget = SliverStickyHeader(
          controller: _scrollController,
          header: _buildSliverSubItemHeader(element),
          sliver: _buildSliverDataSlivers(element, controller),
        );
      } else {
        itemWidget = widget.wholeItemBuilder!(context);
      }
      list.add(itemWidget);
    });
    return list;
  }

  Widget _buildSliverSubItemHeader(String tagStr) {
    late Widget header;
    if (widget.subItemBuilder == null) {
      header = tagStr == TITLETAG
          ? widget.topSearchWidget
          : Container(
              height: widget.subItemWithBuilderHeight,
              width: double.infinity,
              color: Color(0xFFF3F4F5),
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                tagStr,
                softWrap: false,
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            );
    } else {
      header = widget.subItemBuilder!(context);
    }
    return header;
  }

  SliverList _buildSliverDataSlivers(
      String tagStr, IndexBarDetailController controller) {
    late SliverList sliverList;
    int childCount = 0;
    List<Items> list = [];
    controller.contactDatas.forEach((element) {
      String tag = element.tagIndex!;
      if (tagStr == tag) {
        childCount++;
        list.add(element);
      }
    });
    sliverList = SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (widget.contentItemBuilder == null) {
            return _buildContentWidget(list[index], index);
          } else {
            sliverList = widget.contentItemBuilder!(context, index);
          }
          return null;
        },
        childCount: childCount,
      ),
    );
    return sliverList;
  }

  Widget _buildContentWidget(Items item, int index) {
    String name = item.realName ?? " ";
    String phoneNumber = item.phoneNumber ?? "";
    String tag = item.tagIndex!;
    String? avatar = item.avatar;
    String imId = item.imId ?? "";
    String email = item.email ?? "";
    bool? sex = item.sex;
    String organizationUnitName = item.organizationUnitName ?? "";
    String organizationUnitFullName = item.organizationUnitFullName ?? "";
    return Container(
      color: Colors.white,
      height: widget.contentItemWithBuilderHeight,
      child: InkWell(
        onTap: () {
          Map<String, dynamic> map = Map();
          map['faceUrl'] = avatar;
          map['name'] = name;
          map['phoneNumber'] = phoneNumber;
          map['im_Id'] = imId;
          map['email'] = email;
          map['sex'] = sex;
          map['organizationUnitFullName'] = organizationUnitFullName;
          map['organizationUnitName'] = organizationUnitName;
          if ("搜索联系人" != name) {
            Get.toNamed(AppRoutes.contactsDetail, arguments: map);
          } else {
            Get.toNamed(AppRoutes.contactsSearch);
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Avatar(
                  width: 42,
                  height: 42,
                  radius: 4.8,
                  avatar: (item.avatar == null || item.avatar == "")
                      ? name.trim()
                      : item.avatar!,
                  userName: name,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: JSColors.hexToColor("ededed"),
                              width: 0.7,
                              style: BorderStyle.solid))),
                  child: TITLETAG == tag
                      ? _builderContentTitleItem(name, item)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: Text(name,
                                  style: TextStyle(
                                      color: JSColors.hexToColor("111111"),
                                      height: 1)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: Text(
                                phoneNumber,
                                style: TextStyle(
                                  color: JSColors.textWeakColor,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builderContentTitleItem(String name, Items contentTitleItem) {
    return widget.contentTitleItemBuilder == null
        ? Container(
            height: 68,
            alignment: Alignment.centerLeft,
            child: Text(name.trim(),
                style: TextStyle(
                    color: JSColors.hexToColor("111111"),
                    height: 1,
                    fontSize: 15)),
            padding: const EdgeInsets.only(top: 11, right: 11, bottom: 11),
          )
        : widget.contentTitleItemBuilder!(context, contentTitleItem);
  }
}
