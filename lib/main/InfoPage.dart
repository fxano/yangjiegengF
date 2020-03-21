import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yangjiegeng/login/UserLogin.dart';
import 'package:yangjiegeng/sqlite/Sql.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';

class InfoPage extends StatefulWidget{//文章详情页面
  final dynamic title;
  final int index;
  InfoPage({Key key,this.title,this.index}):super(key:key);//接受参数
  @override
  _InfoPage createState() => new _InfoPage();
}
class _InfoPage extends State<InfoPage>{

  Map<String,dynamic> info=Map<String,dynamic>();//存放文章数据
  var color=Colors.white;//控制导航栏 标题颜色
  FocusNode blankNode = FocusNode();//定义焦点
  TextEditingController controller=TextEditingController();//输入框控制器
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:PreferredSize(
          child:
          AppBar(
            elevation: 0,
            brightness: Brightness.light,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              widget.title["name"],
              style: TextStyle(
                color: color
              ),
            ),
            iconTheme: IconThemeData(
                color: Colors.pinkAccent,
                opacity: 0.8,
            ),
          ),
          preferredSize: Size.fromHeight(45),
        ),
      body:GestureDetector(
        onTap: (){
          print("点击了别的地方");
          blankNode.unfocus();
        },
        child:Column(
          children: <Widget>[
            Flexible(
              child: _buildBody(),
            ),
            _buildEdit()
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }//绘制布局

  bool isOff=true;//判断是否隐藏
  Widget _buildEdit(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5.0,
            blurRadius: 10,
          )
        ]
      ),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Offstage(
              offstage: !isOff,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Theme(
                    data: new ThemeData(primaryColor: Colors.pinkAccent),
                    child:Container(
                      width: 200,
                      height: 40,
                      padding: EdgeInsets.only(top: 6,left: 5,right: 5),
                      child: TextField(

                        controller: controller,
                        onTap: (){
                          FocusScope.of(context).requestFocus(blankNode);
                          setState(() {
                            isOff=false;
                          });
                        },
                        style: TextStyle(
                            fontSize: 16
                        ),
                        cursorColor: Colors.purpleAccent,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,top: 3,bottom: 2),
                            isDense: true,
                            hintText: "说点什么吧",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: (){
                      print("点击了评论");
                    },
                    icon: Icon(Icons.message),
                  ),
                  IconButton(
                    onPressed: (){
                      print("点击了收藏");
                    },
                    icon: Icon(Icons.star_border),
                  ),
                  IconButton(
                    onPressed: (){
                      print("点击了喜欢");
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: isOff,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Theme(
                    data: new ThemeData(primaryColor: Colors.pinkAccent),
                    child:Container(
                      width: 270,
                      height: 40,
                      padding: EdgeInsets.only(top: 6,),
                      child: TextField(
                        focusNode: blankNode,
                        controller: controller,
                        onTap: (){
                          setState(() {
                          });
                        },
                        style: TextStyle(
                            fontSize: 16
                        ),
                        cursorColor: Colors.purpleAccent,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,top: 3,bottom: 2,right: 10),
                            isDense: true,
                            hintText: "说什么吧",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    child: Text("发送"),
                    textColor: Colors.white,
                    onPressed: (){
                      blankNode.unfocus();
                      _send();
                      print("点击了发送");
                    },
                    color: Color.fromRGBO(252, 105, 133, 1.0),
                    height: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }//输入框

  ScrollController _scrollController=ScrollController();//scrollView控制器
  Widget _buildBody(){
    if(info.length==0){
      return _getMoreWidget();
    }
    return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              width: double.infinity,
              height: 45,
              child: Text(
                info["name"],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),//文章标题
            Container(
              margin: EdgeInsets.only(right: 10,left: 10),
              width: double.infinity,
              height: 16,
              child: Row(
                children: <Widget>[
                  Text(
                    info["group"],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    " - "
                  ),
                  Text(
                    info["time"]+"号",
                    style: TextStyle(
                      fontSize: 12,

                    ),
                  ),
                  Text(
                      " - "
                  ),
                  Text(
                    info["browse"]+"浏览",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),//文章发表日期
            GestureDetector(
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                            info["url"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),//头像
                    Container(
                      width: 100,
                      height: 50,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 5,
                            child: Text(
                              info["userName"],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.pinkAccent
                              ),
                            ),
                          ),//用户名
                          Positioned(
                            bottom: 5,
                            child: Text(
                              info["fans"]+"粉丝",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),//粉丝数量
                        ],
                      ),
                    ),//个人信息
                    Expanded(
                      child: Container(

                      ),
                    ),//占位
                    Container(
                      width:60,
                      height: 30,
                      child: MaterialButton(
                        child: Text("关注"),
                          textColor: Colors.white,
                          onPressed: (){
                            print("点击了按钮");
                          },
                        color: Color.fromRGBO(252, 105, 133, 1.0),
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    ),//关注按钮
                  ],
                ),//用户信息
                decoration: BoxDecoration(
                  color: Colors.white
                ),
              ),
              onTap: (){
                print("点击了框框");
              },
            ),//用户信息
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10,right: 10),
              child:Text(
                info["content"],
                style: TextStyle(
                  fontSize: 16,

                ),
              ),
            ),//文章内容
            _comment(),
          ],
        ),
    );
  }//文章布局
  var index=0;//请求数据标识
  var isLoading=true;//是否能加载数据
  List<Map> list=List();//评论数据
  Widget _comment(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 50,
                child:Text(
                  "评论",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 50,
                child:Text(
                  "按时间",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),//评论按钮
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length+1,
              itemBuilder: (BuildContext context,int i){
                if(i<list.length){
                  return _buildItem(list[i]);
                }
                if(isLoading){
                  return _getMoreWidget();
                }
                return _noMore();
              })
        ],
      ),
    );
  }//评论listView

  Widget _buildItem(Map comment){
    return GestureDetector(
      onTap: (){
        print("点击了评论");
        Navigator.push(context, CupertinoPageRoute(builder:(context){
          return SqflitePage();
        } ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.network(
                        comment["url"],
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),//头像
                    Container(
                      width: 240,
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              comment["username"]
                          ),
                          Text(
                            comment["time"],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                              comment["content"]
                          ),
                        ],
                      ),
                    ),//用户信息
                  ],
                )
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              iconSize: 20,
              onPressed: (){
                print("点击了点赞");
              },
            )
          ],
        ),
      ),
    );
  }//自定义item

  Widget _getMoreWidget() {
    return Center(
        child:Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          child:CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor:AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
          ),
        )
    );
  }//加载更多时显示的组件,给用户提示

  Widget _noMore(){
    return Center(
        child:Container(
          child: Text(
            "我是有底线的",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        )
    );
  }//没有更多时显示的组件

  Future _getInfo(String objectId) async{
    info=await HttpUtils.request(
      "object/getLibrary",method: HttpUtils.GET,
      data: {
        'objectId':widget.title[objectId],
      }
    );
    setState(() {
    });
  }//文章数据请求

  Future _getComment(int uid,String objectId)async{
    index+=10;
    var item=await HttpUtils.request(
      "object/getComment",method: HttpUtils.GET,
      data: {
        'uid':uid,
        'objectId':widget.title[objectId]
      }
    );
    setState(() {
      if(item.length==0){
        isLoading=false;
      }else{
        if(uid!=0){
          list.addAll(List.generate(item.length, (index) => item['$index']));
        }else{
          list=List.generate(item.length, (index) => item['$index']);
        }
      }
    });
  }//评论数据请求

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
  }
  void _send() async{
    List<Map> index=await SqlLite().getQuery();
    if(index.length==0){
      _dialog();

    }

    list.addAll(List.generate(1, (index) => {
      "url":"http://192.168.2.223:8888/images/caoling.jpg",
      "username":"123",
      "time":"2020-3-21",
      "content":"哈哈哈哈哈哈",
      "userId":"1",
      "objectId":"1",
    }));
  }

  @override
  void initState() {
    super.initState();
    String objectId="objectId";
    if(widget.index==1){
      objectId="objectId1";
    }
    _getInfo(objectId);
    _getComment(index,objectId);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        print('滑动到了最底部');
        if(isLoading){
          _getComment(index,objectId);
        }
      }
      setState(() {

        if (_scrollController.offset > 40) {
          color=Colors.black;
        }else{
          color=Colors.white;
        }
      });
    });
    blankNode.addListener(() {
      if(!blankNode.hasFocus){
        setState(() {
          isOff=true;
        });
      }
    });
  }//初始化

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    blankNode.dispose();

    super.dispose();
  }//销毁控制器
}