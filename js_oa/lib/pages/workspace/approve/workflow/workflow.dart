// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/pages/workspace/approve/workflow/finace_flow.dart';

class WorkFlow extends StatefulWidget {
  final WorkflowInfo? flowInfo;
  WorkFlow({Key? key, this.flowInfo}) : super(key: key);

  @override
  _WorkFlowState createState() => _WorkFlowState();
}

class _WorkFlowState extends State<WorkFlow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: flowWidgets(widget.flowInfo),
        ),
      ),
    );
  }

  List<Widget> flowWidgets(WorkflowInfo? flowInfo) {
    List<Widget> flows = [];
    flows.add(TopWidget());
    for (WorkflowSteps item in flowInfo!.workflowSteps!) {
      if (item.users != null && item.users!.length > 0) {
        flows.add(ApprovePeopleWidget(flowStep: item));
      }
    }
    flows.add(ResultWidget(flowStep: flowInfo.workflowSteps!.last));
    return flows;
  }
}

class TopWidget extends StatefulWidget {
  final int auditStatus;
  TopWidget({Key? key, this.auditStatus = 0}) : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 44,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
              width: 3,
              color: Colors.green,
            )),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("录入信息")),
              Icon(
                Icons.check_circle_outlined,
                size: 20,
                color: Colors.green,
              )
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
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

class ApprovePeopleWidget extends StatefulWidget {
  final WorkflowSteps? flowStep;
  ApprovePeopleWidget({Key? key, this.flowStep}) : super(key: key);

  @override
  _ApprovePeopleWidgetState createState() => _ApprovePeopleWidgetState();
}

class _ApprovePeopleWidgetState extends State<ApprovePeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return FinaceFlow(flowStepInfo: widget.flowStep).initUI();
  }
}

class ResultWidget extends StatefulWidget {
  final WorkflowSteps? flowStep;
  ResultWidget({Key? key, this.flowStep}) : super(key: key);

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    Color themeColor =
        FetchThemeColor().configColor(widget.flowStep!.auditStatus!);
    return Stack(
      alignment: AlignmentDirectional.topStart,
      clipBehavior: Clip.none,
      children: [
        Container(
          // height: 44,
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("完成")),
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
    );
  }
}
