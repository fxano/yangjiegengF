import 'package:flutter/cupertino.dart';
import 'package:yangjiegeng/login/UserLogin.dart';
import 'package:yangjiegeng/main/InfoPage.dart';
import 'package:yangjiegeng/main/mainpage.dart';
import 'package:yangjiegeng/owninfo/OwnCollection.dart';
import 'package:yangjiegeng/owninfo/OwnFans.dart';
import 'package:yangjiegeng/owninfo/OwnFollow.dart';
import 'package:yangjiegeng/owninfo/OwnMessage.dart';
import 'package:yangjiegeng/owninfo/OwnBrowse.dart';
import 'package:yangjiegeng/owninfo/OwnRelease.dart';
import 'package:yangjiegeng/search/SearchPage.dart';
import 'package:yangjiegeng/setting/SettringPage.dart';


class Router{//路由管理
  static const searchPage="app://SearchPage";
  static const settingPage="app://SettingPage";
  static const ownRelease="app://OwnRelease";
  static const ownBrowse="app://OwnBrowse";
  static const ownMessage="app://OwnMessage";
  static const ownCollection="app://OwnCollection";
  static const ownFans="app://OwnFans";
  static const ownFollow="app://OwnFollow";
  static const userLogin="app://UserLogin";
  static const mainPage="app://MainPage";
  static const infoPage="app://InfoPage";
  var route;

  Router.push(BuildContext context, String url, dynamic params,) {//跳转到新页面
    Navigator.push(context, CupertinoPageRoute(builder: (context) {

      if(url==searchPage){
        route=SearchPage();//搜索界面
      }else if(url==settingPage){
        route=SettingPage();//设置界面
      }else if(url==ownRelease){
        route=OwnRelease();//我的发布
      }else if(url==ownBrowse){
        route=OwnBrowse();//浏览记录
      }else if(url==ownMessage){
        route=OwnMessage();//我的消息
      }else if(url==ownCollection){
        route=OwnCollection();//我的收藏
      }else if(url==ownFans){
        route=OwnFans();
      }else if(url==ownFollow){
        route=OwnFollow();
      }else if(url==userLogin){
        route=UserLogin();
      }else if(url==mainPage){
        route=MainPage();
      }
      return route;
    }));
  }
  Router.replace(BuildContext context,String url,dynamic params){//进入新页面 并把此页面从栈中移除
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
      if(url==mainPage){
        route=MainPage();
      }else if(url==userLogin){
        route=UserLogin();
      }
      return route;
    }));
  }
  Router.removeAll(BuildContext context,String url,dynamic params){//推送到新页面 并将栈中其他页面移除
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context){
      return UserLogin();
    }), (route) => false);
}
  Router.pushInfo(BuildContext context,String url,dynamic params,int index){
    Navigator.push(context, CupertinoPageRoute(builder: (context){
      return InfoPage(title: params,index: index);
    }));
  }
}