import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/workspace_layout_entity.dart';
import 'package:js_oa/pages/workspace/widgets/approve_bar.dart';
import 'package:js_oa/pages/workspace/workspace_content_cell.dart';
// import 'package:js_oa/pages/workspace/workspace_content_cell.dart';
import 'package:js_oa/res/gaps.dart';

class WorkContent extends StatefulWidget {
  WorkContent({Key? key}) : super(key: key);

  @override
  _WorkContentState createState() => _WorkContentState();
}

class _WorkContentState extends State<WorkContent> {
  List<WorkspaceLayoutEntity> data = [];
  @override
  void initState() {
    WorkSpaceService().getWorkSpaceGetMyLayout(
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
    return Container(
      child: Column(
        children: [
          Gaps.line,
          ApproveBar(),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return WorkContentCell(work: data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
