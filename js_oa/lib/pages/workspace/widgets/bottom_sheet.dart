import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  BottomSheet({Key? key}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("BottomSheet"),
      ),
      body: new Column(
        children: <Widget>[
          new Builder(builder: (BuildContext context) {
            return new ElevatedButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return new Container(
                        child: new Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              new ListTile(
                                leading: new Icon(Icons.chat),
                                title: new Text("对话框列表1"),
                                onTap: () {},
                              ),
                              new ListTile(
                                leading: new Icon(Icons.help),
                                title: new Text("对话框列表2"),
                                onTap: () {},
                              ),
                              new ListTile(
                                leading: new Icon(Icons.settings),
                                title: new Text("对话框列表3"),
                                onTap: () {},
                              ),
                              new ListTile(
                                leading: new Icon(Icons.more),
                                title: new Text("对话框列表4"),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: new Text("BottomSheet"),
            );
          }),

          //showModalBottomSheet与BottomSheet的区别是 BottomSheet充满屏幕，ModalBottomSheet半屏
          new ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return new Container(
                      child: new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Column(
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.chat),
                              title: new Text("对话框列表1"),
                              onTap: () {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.help),
                              title: new Text("对话框列表2"),
                              onTap: () {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.settings),
                              title: new Text("对话框列表3"),
                              onTap: () {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.more),
                              title: new Text("对话框列表4"),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: new Text("ModalBottomSheet"),
          ),
        ],
      ),
    );
  }
}
