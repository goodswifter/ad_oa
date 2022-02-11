import 'package:flutter/material.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/router/fade_router.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/photo_view/photo_view_simple_screen.dart';

class PaymentDetailAttachment extends StatefulWidget {
  final GroupInfos? detail;
  PaymentDetailAttachment({Key? key, this.detail}) : super(key: key);

  @override
  _PaymentDetailAttachmentState createState() =>
      _PaymentDetailAttachmentState();
}

class _PaymentDetailAttachmentState extends State<PaymentDetailAttachment> {
  @override
  Widget build(BuildContext context) {
    if (widget.detail!.content!.attachment == null) {
      return Container();
    }
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.detail!.name!),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG,
                  image: widget.detail!.content!.attachment ?? "",
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(//tab_message_hl.png
                        R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG);
                  },
                  fit: BoxFit.cover,
                  width: 44,
                  height: 44,
                ),
                SizedBox(width: 16),
                Expanded(child: Text("情况说明")),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(new FadeRoute(
                        page: PhotoViewSimpleScreen(
                          imageProvider:
                              NetworkImage(widget.detail!.content!.attachment!),
                          heroTag: 'simple',
                        ),
                      ));
                    },
                    child: Text("预览"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
