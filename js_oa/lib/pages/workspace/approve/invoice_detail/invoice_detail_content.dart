import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/approve/invoice_detail/invoice_detail_content_info.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_bottom.dart';
import 'package:js_oa/pages/workspace/approve/workflow/workflow.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';

class InvoiceDetailContent extends StatefulWidget {
  final String? workflowId;
  final String? tag;
  final int? index;
  InvoiceDetailContent({Key? key, this.workflowId, this.tag, this.index})
      : super(key: key);

  @override
  _InvoiceDetailContentState createState() => _InvoiceDetailContentState();
}

class _InvoiceDetailContentState extends State<InvoiceDetailContent> {
  ApproveController controller = Get.put(ApproveController());
  WorkflowDetailEntity? data;
  @override
  void initState() {
    // WorkSpaceService workSpaceService = WorkSpaceService();
    WorkSpaceService().getWorkflowGetById(
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
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      InvoiceDetailContentInfo(detail: data!.groupInfos![0]),
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
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
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
          )
        : Container();
  }
}
