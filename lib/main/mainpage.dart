import 'package:flutter/material.dart';
import 'package:yangjiegeng/follow/followpage.dart';
import 'package:yangjiegeng/main/homepage.dart';
import 'package:yangjiegeng/owninfo/mypage.dart';
import 'package:yangjiegeng/release/newpage.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
import 'navigation_icon_view.dart';

class MainPage extends StatefulWidget{//底部导航栏
  @override
  State<MainPage> createState()=>_MainState();
}

class _MainState extends State<MainPage> with TickerProviderStateMixin{
  final pageController=PageController();//控制器
  int _currentIndex=0;//下标
  List<NavigationIconView> _navigation;//图标list
  List<StatefulWidget> _pageList;//页面list

  @override
  void initState(){
      super.initState();
      SqlLite().createDb();
      _navigation=<NavigationIconView>[
        NavigationIconView(
          icon: Icon(Icons.home),
          title: Text("首页"),
          vsync:this,
        ),
        NavigationIconView(
          icon: Icon(Icons.playlist_add),
          title: Text("发布"),
          vsync: this,
        ),
        NavigationIconView(
          icon: Icon(Icons.favorite_border),
          title: Text("关注"),
          vsync: this,
        ),
        NavigationIconView(
          icon: Icon(Icons.perm_identity),
          title: Text("我的"),
          vsync: this,
        )
      ];
      _pageList=<StatefulWidget>[
          HomePage(),
          NewPage(),
          FollowPage(),
          MyPage()
      ];
  }//初始化

  void onTap(int index){
    pageController.jumpToPage(index);
  }//点击事件

  void onPageChange(int index){
    setState(() {
      _currentIndex=index;
    });
  }//页面发生改变

  @override
  void dispose() {
    super.dispose();
  }//页面被废弃时调用

  @override
  Widget build(BuildContext context){
    final BottomNavigationBar bar = BottomNavigationBar(
      items: _navigation.map((NavigationIconView iconView)=>iconView.item).toList(),
      currentIndex: _currentIndex,
      fixedColor: Color.fromRGBO(254, 106, 127, 1.0),
      type: BottomNavigationBarType.fixed,
      onTap:onTap ,
    );//底部导航栏按钮
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          children:_pageList,
        ),
        bottomNavigationBar: bar,
      ),
    );
  }//绘制布局

}