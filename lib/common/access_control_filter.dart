import 'package:flutter/material.dart';
import 'global.dart';
import 'package:longyuan/mine/login.dart';


typedef ACFCallback = Future Function(Map userInfo);

///
/// 登录状态检查
///
class AccessControlFilter extends StatefulWidget {
  /// 头部
  final AppBar appBar;

  /// 标题
  final String title;

  /// 内容组件
  final Widget child;

  /// 未登录的显示
  final Widget didNotLoginWidget;

  const AccessControlFilter({
    Key key,
    this.appBar,
    this.title,
    @required this.child,
    this.didNotLoginWidget,
  }) : super(key: key);

  @override
  _AccessControlFilterState createState() => _AccessControlFilterState();
}

class _AccessControlFilterState extends State<AccessControlFilter> {
  /// 登录状态
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();

    this._updateUserState();
  }

  @override
  void didUpdateWidget(AccessControlFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._updateUserState();
  }

  /// 更新用户信息
  void _updateUserState({data}) {
//    final Map userInfo = data != null ? data : UserInfo().userInfo;
//    final bool isLogin = userInfo != null && userInfo.length != 0;
//    setState(() {
//      _isLogin = isLogin;
//    });
  }

  /// 未登录的显示
  Widget _didNotLoginWidget() {
    // 如果传入的未登录情况下显示的组件，则采用传入的
    if (widget.didNotLoginWidget != null) return widget.didNotLoginWidget;

    // 缺省的未登录情况下的显示
    return Center(
      child: RaisedButton(
        color: Colors.blueAccent,
        textTheme: ButtonTextTheme.primary,
        child: Text('请先登录'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Login(
                  successCallback: (Map data) {
                    _updateUserState(data: data);
                    printWhenDebug('登录成功');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar != null
          ? widget.appBar
          : AppBar(
        title: Text(widget.title != null ? widget.title : ""),
        centerTitle: true,
      ),
      body: this._isLogin ? widget.child : this._didNotLoginWidget(),
    );
  }
}
