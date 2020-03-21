import 'package:flutter/material.dart';
import 'package:yangjiegeng/tool/Bar.dart';

class OwnRelease extends StatefulWidget{
  @override
  _OwnRelease createState() => new _OwnRelease();
}
class _OwnRelease extends State<OwnRelease>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          child: Bar(
            text: "我的发布",
          ),
          preferredSize: Size.fromHeight(45),
        )
    );
  }
}