import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

///
/// 当调试模式打开时打印
///
void printWhenDebug(Object object) {
  if (Global.debug) {
    print(object);
  }
}

///
/// 当前环境
///
enum Env {
  dev,
  pro,
}

class Global {
  static SharedPreferences _prefs;
  static Dio dio;
  static Map profile = {};
  static bool debug = false;
  ///
  /// 当前环境
  ///
  static const Env env = Env.dev;


  ///
  /// 根域名
  ///
  static const Map baseUrlList = {
    Env.dev: 'http://safe.doylee.cn',
    // Env.dev:   'http://192.168.31.189/campus_safety',
    Env.pro: 'http://10.111.2.158',
  };

  ///
  /// 接口根路由
  ///
  static String baseUrl = baseUrlList[env];

  // 网络缓存对象
  static DioCacheManager netCache = DioCacheManager(
    CacheConfig(
      baseUrl: baseUrl,
    ),
  );

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    dio = new Dio();
    // 添加拦截器
    dio.interceptors.add(netCache.interceptor);

    // 初始化用户信息
    var _profile = _prefs.getString("user_info");
    if (_profile != null) {
      try {
        print('开始读取用户信息...');
        profile = jsonDecode(_profile);
        print('用户信息读取成功');
      } catch (e) {
        print(e);
      }
    }
  }

  // 持久化Profile信息
  static Future<bool> saveProfile({@required Map userInfo}) {
    profile = userInfo;
    final userJson = jsonEncode(userInfo);
    return _prefs.setString("user_info", userJson);
  }

  /// 读取持久化Profile信息
  static Future<Map> getProfile() {
    return jsonDecode(_prefs.getString("user_info"));
  }
}
