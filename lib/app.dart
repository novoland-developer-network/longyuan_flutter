import 'package:flutter/material.dart';
import 'package:longyuan/layout/LayoutScaffold.dart';

///
/// 应用页
///
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutScaffold(
      appBar: AppBar(
        title: Text('应用'),
      ),
      body: null,
    );
  }
}
