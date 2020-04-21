import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:longyuan/app.dart';
import 'package:longyuan/life.dart';
import 'package:longyuan/news.dart';
import 'package:longyuan/mine.dart';
import 'package:longyuan/router/router.dart';

//import 'common/access_control_filter.dart';

void main() => runApp(LongYuan());

class LongYuan extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '龙渊',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: "SongTiHeavy",
          primaryColor: Color(0xFFff857a),
          accentColor: Colors.deepOrangeAccent,
          primaryColorDark: Colors.black54,
          backgroundColor: Color(0xFFFFF7F8),
          bottomAppBarColor: Color(0xFFFFF7F8),
          buttonColor: Color(0xFFFFF7F8),
          appBarTheme: AppBarTheme(color: Colors.white)),
      home: LongYuanFrame(title: 'Flutter Demo Home Page'),
      // 国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
      ],
      locale: Locale('zh'),
      // 路由
      routes: router,
    );
  }
}

class LongYuanFrame extends StatefulWidget {
  LongYuanFrame({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LongYuanFrameState createState() => _LongYuanFrameState();
}

class _LongYuanFrameState extends State<LongYuanFrame> {
  Widget _body;
  int _index = 0;

  void initData() {
    //页面初始化时要干的事
    _body = IndexedStack(
      children: <Widget>[
        App(),
        Life(),
        App(),
        News(),
        Mine(),
      ],
      index: _index,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();

    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            bottomAppBarItem(
              index: 0,
              icon: Icons.apps,
              title: '应用',
            ),
            bottomAppBarItem(
              index: 1,
              icon: Icons.forum,
              title: '讨论',
            ),
            bottomAppBarItem(
              index: 2,
              isShow: false,
            ),
            bottomAppBarItem(
              index: 3,
              icon: Icons.business,
              title: '资讯',
            ),
            bottomAppBarItem(
              index: 4,
              icon: Icons.perm_identity,
              title: '我的',
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () => {},
        child: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget bottomAppBarItem({
    @required int index, // 序列
    IconData icon, // 图标
    String title, // 标签
    bool isShow = true, // 是否需要显示
  }) {
    //设置默认未选中的状态
    double size = 13;
    Color color = Colors.black87;

    if (_index == index) {
      //选中的话
      size = 15;
      color = Theme.of(context).primaryColor;
    }
    TextStyle style = TextStyle(
      fontSize: size,
    );
    Widget child;
    if (isShow) {
      child = Container(
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 25.0,
                height: 23.0,
                child: Icon(
                  icon,
                  color: color,
                  size: size * 1.7,
                ),
              ),
              Text(
                title,
                style: style,
              )
            ],
          ),
          onTap: () {
            if (_index != index) {
              setState(() {
                _index = index;
              });
            }
          },
        ),
      );
    }

    //构造返回的Widget
    return SizedBox(
      height: 49,
      width: MediaQuery.of(context).size.width / 5,
      child: child,
    );
  }
}
