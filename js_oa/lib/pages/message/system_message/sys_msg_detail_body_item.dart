/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-15 16:07:00
 * @Description: 
 * @FilePath: \js_oa\lib\pages\message\system_message\sys_msg_detail_body_item.dart
 * @LastEditTime: 2021-12-15 16:46:58
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/utils/date/chat_date_transform_util.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_text_elem.dart';

import 'custom_message_widgets/invoice_type.dart';

class SysMessageBodyItemWidget extends StatelessWidget {
  final V2TimMessage message;
  const SysMessageBodyItemWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.msgID == null || message.msgID == '') {
      return const SizedBox();
    }
    return Column(
      children: [
        Text(
          ChatDateTransformUtils.getNewChatTime(
              timesamp: message.timestamp!,
              timesampType: DateTimeMessageType.chatContent),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11, color: JSColors.textWeakColor, height: 1.6),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: _buildCustomWidget(),
        )
      ],
    );
  }

  _buildCustomWidget() {
    switch (message.elemType) {
      case 1:
        V2TimTextElem textElem = message.textElem!;
        return Card(
          elevation: 0.2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            child: Text(textElem.text ?? ""),
          ),
        );
      case MessageElemType.V2TIM_ELEM_TYPE_CUSTOM:
        V2TimCustomElem elem = message.customElem!;
        return InvoiceTypeMsgWidget(
          elem: elem,
        );
    }
  }
}
