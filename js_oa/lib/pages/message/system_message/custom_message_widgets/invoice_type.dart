/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-15 16:21:11
 * @Description: 开票类型的自定义ui
 * @FilePath: \js_oa\lib\pages\message\system_message\custom_message_widgets\invoice_type.dart
 * @LastEditTime: 2021-12-22 17:43:48
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/im/entity/notifycation_message_entity.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';

class InvoiceTypeMsgWidget extends StatelessWidget {
  final V2TimCustomElem elem;
  const InvoiceTypeMsgWidget({Key? key, required this.elem}) : super(key: key);

  List<Widget> _buildDescContentWidget(List<CustomMessageBody>? list) {
    List<Widget> widgets = [];
    if (list == null || list.length == 0) {
      return [];
    } else {
      list.forEach((element) {
        widgets.add(Container(
          height: 0.1,
          color: JSColors.textWeakColor,
        ));
        widgets.add(Container(
          margin: const EdgeInsets.all(3),
          child: Text(
            element.content ?? "",
            style: TextStyle(fontSize: 14, color: JSColors.textWeakColor),
          ),
        ));
      });
      return widgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> result = json.decode(elem.data!.toString());
    CustomMessageData bean = CustomMessageData.fromJson(result);
    String workflowid = bean.workflowId ?? "";
    String routeString = bean.routePath ?? AppRoutes.invoiceDetail;
    List<CustomMessageBody>? contentList = bean.contentList;

    return InkWell(
      onTap: () {
        Map<String, dynamic> arguments = Map();
        arguments['workflowId'] = workflowid;
        arguments['tag'] = "1";
        Get.toNamed(routeString, arguments: arguments);
      },
      child: Card(
        elevation: 0.2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(3),
                child: Text(
                  bean.approvalTitle!,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(3),
                child: Text(
                  bean.title!,
                  style: TextStyle(fontSize: 16, color: JSColors.black),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildDescContentWidget(contentList),
              ),
              Container(
                height: 0.1,
                color: JSColors.textWeakColor,
              ),
              Container(
                margin: const EdgeInsets.only(left: 3, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "查看详情",
                      style: TextStyle(
                          fontSize: 12, color: JSColors.textWeakColor),
                    )),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: JSColors.textWeakColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
