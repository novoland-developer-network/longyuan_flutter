import 'package:flutter/material.dart';

class LayoutScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;

  LayoutScaffold({
    Key key,
    @required this.appBar,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text title = this.appBar.title;

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            title.data,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          bottom: this.appBar.bottom,
        ),
        preferredSize:
            this.appBar.preferredSize == null ? 60 : this.appBar.preferredSize,
      ),
      body: this.body,
    );
  }
}
