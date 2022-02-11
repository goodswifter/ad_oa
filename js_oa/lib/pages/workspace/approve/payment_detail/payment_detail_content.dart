import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_attachment.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_bottom.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_contract.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_pay_info.dart';
import 'package:js_oa/pages/workspace/approve/workflow/workflow.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';
// import 'package:shimmer/shimmer.dart';

class PaymentDetailContent extends StatefulWidget {
  final String? workflowId;
  final String? tag;
  final int? index;
  PaymentDetailContent({Key? key, this.workflowId, this.tag, this.index})
      : super(key: key);

  @override
  _PaymentDetailContentState createState() => _PaymentDetailContentState();
}

class _PaymentDetailContentState extends State<PaymentDetailContent> {
  ApproveController controller = Get.put(ApproveController());
  WorkflowDetailEntity? data;
  @override
  void initState() {
    WorkSpaceService workSpaceService = WorkSpaceService();
    workSpaceService.getWorkflowGetById(
      widget.workflowId!,
      success: (value) {
        setState(() {
          data = value;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data!.title!,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 8),
                            Text(data!.subTitle!),
                            SizedBox(height: 8),
                            Text(
                              ApproveStatusUntil.getApproveStatusStr(
                                          data!.approveStatus)
                                      .ststusStr ??
                                  "暂无",
                              style: TextStyle(
                                  color: ApproveStatusUntil.getApproveStatusStr(
                                          data!.approveStatus)
                                      .color),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Text(data!.groupInfos![0].name!),
                      ),
                      PaymentDetailPayInfo(detail: data!.groupInfos![0]),
                      PaymentDetailAttachment(detail: data!.groupInfos![1]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Text(data!.groupInfos![2].name!),
                      ),
                      PaymentDetailContract(
                          detail: data!.groupInfos![2].content!),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("进展流程"),
                            SizedBox(height: 8),
                            WorkFlow(flowInfo: data!.workflowInfo),
                          ],
                        ),
                      ),
                      // InvoiceDetailContentInfo(),
                      // Card(),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      //   child: WorkFlow(flowInfo: data!.workflowInfo),
                      // ),
                    ],
                  ),
                ),
              ),
              //如果是已处理隐藏View
              // bottomWidget(controller.indata.tag!),
              PaymentDetailBottom(
                  //除了待审核的其余的都是自己已发起的
                  tag: widget.tag != ""
                      ? widget.tag
                      : (controller.indata.tag ?? "3"),
                  data: data,
                  index: widget.index)
            ],
            // ),
          )
        : Container();
  }
}
