import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjiegeng/tool/Bar.dart';

class OwnCollection extends StatefulWidget{
  @override
  _OwnCollection createState() => new _OwnCollection();
}
class _OwnCollection extends State<OwnCollection>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          child: Bar(
            text: "我的收藏",
          ),
          preferredSize: Size.fromHeight(45),
        )
    );
  }
}