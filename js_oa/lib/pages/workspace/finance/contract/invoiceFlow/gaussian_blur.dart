// Widget invoiceInfo() {
//     return Obx(() {
//       return Container(
//         height: 166,
//         padding: EdgeInsets.all(16),
//         width: double.infinity,
//         color: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   ConstrainedBox(
//                       constraints: BoxConstraints.expand(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "开票名称：${controller.invoiceInfo.value.name ?? "暂无"}",
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "开户行：${controller.invoiceInfo.value.bank ?? "暂无"}",
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "银行账户：${controller.invoiceInfo.value.bankAccount ?? "暂无"}",
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "地址：${controller.invoiceInfo.value.address ?? "暂无"}",
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "电话：${controller.invoiceInfo.value.tel ?? "暂无"}",
//                           ),
//                         ],
//                       )),
//                   Center(
//                     child: ClipRect(
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(
//                             sigmaX: controller.invoiceInfo.value.name == null
//                                 ? 3.0
//                                 : 0,
//                             sigmaY: controller.invoiceInfo.value.name == null
//                                 ? 3.0
//                                 : 0),
//                         child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(
//                                   controller.invoiceInfo.value.name == null
//                                       ? 0.1
//                                       : 0),
//                             ),
//                             child: Center(
//                               child: controller.invoiceInfo.value.name == null
//                                   ? Text('选择客户查看发票信息',
//                                       style:
//                                           Theme.of(context).textTheme.headline6)
//                                   : SizedBox(),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }