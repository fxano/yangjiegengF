import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yangjiegeng/main/mainpage.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
class MyApp extends StatelessWidget {//主入口
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "洋桔梗",
      debugShowCheckedModeBanner: false,
      home: MainPage()
    );
  }
}