/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-30 16:51:22
 * @Description: 通讯录搜索页 状态管理器
 * @FilePath: \js_oa\lib\controller\contact\contact_search_page_controller.dart
 * @LastEditTime: 2021-12-08 17:38:33
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:js_oa/entity/contact/contact_detail_entity.dart';
import 'package:js_oa/entity/contact/contact_list_model.dart';
import 'package:js_oa/entity/contact/office_list_entity.dart';
import 'package:js_oa/entity/contact/user_type_entity.dart';
import 'package:js_oa/service/contact/contact_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactSearchPageController extends GetxController {
  /// textfield 删除按钮是否显示
  var showCancelIcon = false.obs;

  /// 搜索结果数据列表
  List<Items> data = [];

  /// 是否有筛选菜单显示
  bool isShow = false;

  /// 分所筛选菜单是否显示
  bool isFirmShow = false;

  /// 人员类别筛选菜单是否显示
  bool isUserTypeShow = false;

  /// indexStack布局控制当前下拉筛选框的类别 0：分所 1：人员类别
  int currentFilterPosition = 0;

  /// 分所菜单数据列表
  List<OfficeListEntity> cityList = [];

  /// 人员类别数据列表
  List<UserTypeItem> userTypeList = [];

  /// 分所框text
  String firmText = "分所";

  /// 人员类别筛选框text
  String userTypeText = "人员类别";

  /// 人员类别下拉页选中的item下标
  int userTypeCheckPosition = -1;

  /// 分所下拉页选中的item下标
  int firmCheckPosition = -1;

  ///刷新、加载更多控制器
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  ///当前页数
  int pageIndex = 1;

  ///分所筛选id
  String? mOrganizationUnitCode;

  /// 职位筛选ID
  int? mUserPositionId;

  ///搜索框筛选关键字
  String? keyWord;

  ///第一次加载页面
  bool isFirstTimeInit = true;

  @override
  void onInit() {
    super.onInit();
    requestFirmFilterData();
    requestUserTypeFilterData();
  }

  clearAllData() {
    data.clear();
    update(["contact_search_body"]);
  }

  getCityListLength() {
    return cityList.length;
  }

  getUserTypeListLength() {
    return userTypeList.length;
  }

  showOrHideFilterWidget(int position) {
    if (position == 0) {
      isUserTypeShow = false;
      isFirmShow = !isShow;
    } else {
      isFirmShow = false;
      isUserTypeShow = !isShow;
    }
    update(['firm_text']);
    update(['user_type_text']);
    currentFilterPosition = position;
    isShow = !isShow;
    update(["showFilter"]);
  }

  ///获取关键字搜索返回数据
  requestSearchContactData({
    String? organizationUnitCode,
    int? userPositionId,
    String? realName,
  }) async {
    refreshController.resetNoData();
    pageIndex = 1;
    if (userPositionId != null && userPositionId == -1) {
      mUserPositionId = null;
    } else if (userPositionId != null && userPositionId != -1) {
      mUserPositionId = userPositionId;
    }
    if (organizationUnitCode != null && "-1" == organizationUnitCode) {
      mOrganizationUnitCode = null;
    } else if (organizationUnitCode != null && "-1" != organizationUnitCode) {
      mOrganizationUnitCode = organizationUnitCode;
    }

    if (realName == null || "" == realName) {
      keyWord = null;
    } else if (realName != "-1") {
      keyWord = realName;
    }
    if (data.length > 20) {
      scrollController.jumpTo(0);
    }
    await _fetchData(
            pageIndex: pageIndex,
            realName: keyWord,
            canShowEasyLoading: false,
            organizationUnitCode: mOrganizationUnitCode,
            userPositionId: mUserPositionId)
        .then((value) {
      data = value;
      refreshController.refreshCompleted();
      update(["contact_search_body"]);
    });
  }

  ///加载更多
  onLoadMoreData() async {
    pageIndex++;
    await _fetchData(
            realName: keyWord,
            pageIndex: pageIndex,
            organizationUnitCode: mOrganizationUnitCode,
            canShowEasyLoading: false,
            userPositionId: mUserPositionId)
        .then((value) {
      data.addAll(value);
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      if (value.length == 0) {
        refreshController.loadNoData();
      }
      update(["contact_search_body"]);
    });
  }

  Future<List<Items>> _fetchData(
      {int pageIndex = 1,
      String? realName,
      String? organizationUnitCode,
      bool canShowEasyLoading = false,
      int? userPositionId}) async {
    return await ContactService.getInstance()
        .getContactList(
            pageIndex: pageIndex,
            pageSize: 20,
            realName: realName,
            canShowEasyLoading: canShowEasyLoading,
            organizationUnitCode: organizationUnitCode,
            userPositionId: userPositionId)
        .then((value) {
      isFirstTimeInit = false;
      return value;
    });
  }

  ///获取分所筛选信息
  requestFirmFilterData() async {
    await ContactService.getInstance().getOfficeList().then((value) {
      cityList = value;
    });
    cityList.insert(0, OfficeListEntity(id: -1, name: "全部", code: "-1"));
  }

  ///获取人员类别
  requestUserTypeFilterData() async {
    await ContactService.getInstance().getUserTypeList().then((value) {
      userTypeList = value;
      userTypeList.insert(0, UserTypeItem(name: "全部", id: -1));
    });
  }

  ///根据id获取联系人详情
  Future<ContactDetailEntity> requestContactDetailByid(String toUserId) async {
    ContactDetailEntity entity = await ContactService.getInstance()
        .getContactDetailById(toUserId: toUserId);
    return entity;
  }
}
