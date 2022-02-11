import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/entity/workspace_layout_entity.dart';
import 'package:js_oa/pages/workspace/finance/contract/contract_content.dart';

class ContractPage extends StatefulWidget {
  ContractPage({Key? key}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController? _tabController = TabController(length: 2, vsync: this);
    WorkspaceLayoutItem item = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name!),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          tabs: [
            Tab(
              text: "我的案件",
            ),
            Tab(
              text: "${item.name!}记录",
            ),
          ],
        ),
      ),
      body: ContractContent(
        tabController: _tabController,
        financeType: item.workflowCode,
      ),
    );
  }
}
