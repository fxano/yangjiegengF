import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjiegeng/tool/Bar.dart';

class OwnBrowse extends StatefulWidget{
  @override
  _OwnBrowse createState() => new _OwnBrowse();
}
class _OwnBrowse extends State<OwnBrowse>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          child: Bar(
            text: "浏览记录",
          ),
          preferredSize: Size.fromHeight(45),
        )
    );
  }
}