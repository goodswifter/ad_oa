import 'package:flutter/material.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';

class FinaceFlow {
  WorkflowSteps? flowStepInfo;

  FinaceFlow({this.flowStepInfo});

  Widget initUI() {
    FetchThemeColor featchColor = FetchThemeColor();
    // print("flowStepInfo!.auditStatus!");
    // print("flowStepInfo!.auditStatus!");
    // print(flowStepInfo!.auditStatus!);

    Color themeColor = featchColor.configColor(flowStepInfo!.auditStatus!);
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: themeColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(flowStepInfo!.title ?? "暂无")),
                      featchColor.icon!,
                    ],
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: approvePeoples(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -6.0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: themeColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> approvePeoples() {
    List<Widget> flows = [];
    for (ApproveUsers user in flowStepInfo!.users!) {
      flows.add(people(user));
    }
    return flows;
  }

  Widget people(ApproveUsers user) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  child: Image.network(
                    user.avatar ?? '',
                    errorBuilder: (context, obj, trace) {
                      return Image.asset(
                          R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG);
                    },
                  ),
                ),
                Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: user.isApproved! ? Colors.green : null))
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(user.realName ?? "暂无"),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class FetchThemeColor {
  Color? color;
  Widget? icon = Container();
  // FetchThemeColor({this.color, this.icon});
//  未审批 Handling = 0
//  审批通过 Completed = 1
//  审批拒绝 Negative = 2
//  已撤销 Revoked = 3
//  等待审核 UnHandle = 4
//  非审核节点 NotHandleNode = 5
  Color configColor(int status) {
    switch (status) {
      case 0:
        icon = Icon(
          Icons.access_time,
          size: 20,
          color: Colors.amber,
        );
        color = Colors.amber;
        return Colors.amber;
      case 1:
        icon = Icon(
          Icons.check_circle_outlined,
          size: 20,
          color: Colors.green,
        );
        color = Colors.green;
        return Colors.green;
      case 2:
        icon = Icon(
          Icons.highlight_off,
          size: 20,
          color: Colors.red,
        );
        color = Colors.red;
        return Colors.red;
      case 3:
        icon = Icon(
          Icons.highlight_off,
          size: 20,
          color: Colors.red,
        );
        color = Colors.red;
        return Colors.red;
      case 4:
        //kong
        icon = Container();
        color = Colors.grey;
        return Colors.grey;
      case 5:
        icon = Icon(
          Icons.check_circle_outlined,
          size: 20,
          color: Colors.green,
        );
        color = Colors.green;
        return Colors.green;
      default:
        //kong
        icon = Container();
        color = Colors.grey;
        return Colors.grey;
    }
  }
}
