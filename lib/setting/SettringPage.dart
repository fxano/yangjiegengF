import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjiegeng/owninfo/item.dart';
import 'package:yangjiegeng/router.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
import 'package:yangjiegeng/tool/Bar.dart';

class SettingPage extends StatefulWidget{//设置页


  @override
  State createState() {
    return _SettingPage();
  }
}
class _SettingPage extends State<SettingPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        child: Bar(
          text: "设置",
        ),
        preferredSize: Size.fromHeight(45),
      ),
      body: Column(
        children: <Widget>[
          Item(
            iconName:"images/more.png",
            title: "退出登陆",
            onPressed: (){
              SqlLite().delete();
              Router.removeAll(context, Router.userLogin, "账号密码登陆");
            },

          )
        ],
      ),
    );
  }
}