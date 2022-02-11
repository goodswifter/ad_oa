/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-09 15:52:00
 * @Description: 联系人模块网络请求服务
 * @FilePath: \js_oa\lib\service\contact\contact_service.dart
 * @LastEditTime: 2021-12-08 17:38:25
 */

import 'package:get/get.dart';
import 'package:js_oa/entity/contact/contact_detail_entity.dart';
import 'package:js_oa/entity/contact/contact_list_model.dart';
import 'package:js_oa/entity/contact/office_list_entity.dart';
import 'package:js_oa/entity/contact/user_type_entity.dart';
import 'package:js_oa/utils/http/dio_new.dart';

import 'contact_api.dart';
import 'request_entity/contact_list_input.dart';
import 'request_entity/user_type_input.dart';

class ContactService {
  static ContactService? _instance;
  late final HttpClient _httpClient;

  ContactService._internal() {
    _httpClient = Get.find();
  }
  factory ContactService.getInstance() => _getInstance();

  static _getInstance() {
    if (_instance == null) {
      _instance = ContactService._internal();
    }
    return _instance;
  }

  ///请求联系人列表数据
  Future<List<Items>> getContactList(
      {int pageIndex = 1,
      int pageSize = 300,
      String? realName,
      String? organizationUnitCode,
      bool canShowEasyLoading = false,
      int? userPositionId}) async {
    GetContactListInput request = GetContactListInput(
        pageIndex: pageIndex,
        pageSize: pageSize,
        realName: realName,
        organizationUnitCode: organizationUnitCode,
        positionId: userPositionId);
    List<Items> list = [];
    await _httpClient
        .get(ContactApi.getContactPageList,
            queryParameters: request.toJson(),
            isShowEasyLoading: canShowEasyLoading)
        .then((value) {
      if (value.ok) {
        ContactListModel model = ContactListModel.fromJson(value.data);
        if (model.items != null) {
          for (Items item in model.items!) {
            list.add(item);
          }
        }
        return list;
      }
    });
    return list;
  }

  ///请求人员类别分类
  Future<List<UserTypeItem>> getUserTypeList() async {
    List<UserTypeItem> list = [];
    UserTypeInput request = UserTypeInput(pageIndex: 1, pageSize: 10);
    return await _httpClient
        .get(ContactApi.userTypeList,
            queryParameters: request.toJson(), isShowEasyLoading: false)
        .then((value) {
      if (value.ok) {
        UserTypeEntity userType = UserTypeEntity.fromJson(value.data);
        if (userType.items != null) {
          list = userType.items!;
        }
      }
      return list;
    });
  }

  ///请求分所列表数据
  Future<List<OfficeListEntity>> getOfficeList() async {
    List<OfficeListEntity> list = [];
    return await _httpClient
        .get(ContactApi.officeList, isShowEasyLoading: false)
        .then((value) {
      if (value.ok) {
        for (var item in value.data) {
          list.add(OfficeListEntity.fromJson(item));
        }
      }
      return list;
    });
  }

  ///请求联系人详情
  Future<ContactDetailEntity> getContactDetailById(
      {required String toUserId}) async {
    ContactDetailEntity entity = ContactDetailEntity();
    return await _httpClient
        .get(ContactApi.getUserInfoForContact + "$toUserId",
            isShowEasyLoading: false)
        .then((value) {
      if (value.ok) {
        entity = ContactDetailEntity.fromJson(value.data);
      }
      return entity;
    });
  }
}
