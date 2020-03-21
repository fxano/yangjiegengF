import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjiegeng/login/UserLogin.dart';
import 'package:yangjiegeng/owninfo/item.dart';
import 'package:yangjiegeng/router.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
import 'package:yangjiegeng/tool/TextOnClick.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';
import 'package:yangjiegeng/utils/JSON.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MyPage extends StatefulWidget{//我的页面

  @override
  _MyPageState createState() => new _MyPageState();
}
class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{

  String fans="";
  String follow="";
  String name="";
  String auto="";
  String url="";

  @override
  void initState() {
    super.initState();
      _getInfo();
  }//初始化

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child:Column(
                children: <Widget>[
                  _buildBody(),
                ],
              )
          ),
          backgroundColor: Color.fromRGBO(232, 232, 232, 1.0),
        ),
      theme: ThemeData(
        primarySwatch:Colors.pink,
      ),
    );
  }//绘制布局

  Widget _buildImage(){//用户头像
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          imageUrl: url,
        ),
      )
    );
  }//用户头像

  Widget _buildText(){//用户名称等
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 23,
            child:TextOnClick(
              text: name,
              size: 16,
              color: Colors.white,
              onPressed: (){
              },
            ),
          ),

//          Text(
//              "洋桔梗",
//            style: TextStyle(fontSize: 16,color: Colors.white),
//          ),
        Container(
          height: 18,
          child:Text(
            auto,
            style: TextStyle(fontSize: 12,color: Colors.white),
          ),
        ),
          Container(
            width: 100,
            height: 30,
            child:Row(
              children: <Widget>[
                TextOnClick(
                  text: "关注:"+'$follow',
                  size: 12,
                  color: Colors.white,
                  onPressed: (){
                      Router.push(context, Router.ownFollow, "我的关注");
                  },
                ),
                Expanded(child: Container()),
                TextOnClick(
                  text: "粉丝:"+'$fans',
                  size: 12,
                  color: Colors.white,
                  onPressed: (){
                    Router.push(context, Router.ownFans, "我的粉丝");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }//用户名称等

  Widget _buildBody(){
    return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: SafeArea(
              bottom:false,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 55,
                          height: 30,
                      ),
                      _buildImage(),
                      Container(
                        width: 50,
                        height: 50,
//                        margin:EdgeInsets.only(top: 5,right: 5),
                        child:IconButton(
                          icon: Image.asset("images/shezi.png"),
                          iconSize: 30,
                          onPressed:(){
                            Router.push(context, Router.settingPage, "123");//跳转到设置页面
                          }
                        )
                      ),
                    ],
                  ),
                  _buildText(),
                ],
              ),
            ),
            decoration: BoxDecoration(//背景图片
              image:DecorationImage(
                image: AssetImage("images/test.png"),
                fit: BoxFit.cover
              )
            ),
          ),
          Item(
            title: "我的发布",
            iconName: "images/release.png",
            onPressed: (){
              Router.push(context,Router.ownRelease, "456");
            },
          ),
          Item(
            title: "我的收藏",
            iconName: "images/collection1.png",
            onPressed: (){
              Router.push(context,Router.ownCollection, "456");
            },
          ),
          Item(
            title: "我的消息",
            iconName: "images/comment.png",
            onPressed: (){
              Router.push(context,Router.ownMessage, "456");
            },
          ),
          Item(
            title: "浏览记录",
            iconName: "images/browse.png",
            onPressed: (){
              Router.push(context,Router.ownBrowse, "456");
            },
          )
        ],
    );
  }//主布局

  _dialog(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("提示"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("您还未登陆"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("确定"),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(context,CupertinoPageRoute(builder: (context){
                    return UserLogin();
                  }));
                },
              )
            ],
          );
        }
    );
  }//dialog弹窗

  _getInfo() async {
    List<Map> count=await SqlLite().getQuery();
    if(count.length==0){
      _dialog();
    }else{
      var result=await HttpUtils.request(
          "user/get",method: HttpUtils.GET,
          data: {
            'uid':count[0]["userId"],
          }
      );
      JSON json = JSON.fromJsonInfo(result);
      name=json.name;
      auto=json.auto;
      fans=json.fans;
      follow=json.follow;
      url=json.url;
      setState(() {
      });
    }
  }//数据请求

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
