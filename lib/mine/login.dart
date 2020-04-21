import 'package:flutter/material.dart';

///
/// 登录页
///
class Login extends StatefulWidget {
  final Function successCallback;

  const Login({
    Key key,
    this.successCallback,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
