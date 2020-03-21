import 'package:flutter/material.dart';
class FollowPage extends StatefulWidget{//关注页
  @override
  _FollowPageState createState() => new _FollowPageState();
}
class _FollowPageState extends State<FollowPage> {
  Widget searchBar(){
    return Center(
      child:Container(
      height: 30,
      width: 300,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton.icon(
              icon:Icon(
                Icons.search,
                color: Colors.white,
                size: 16,
              ),
              label: Text(
                  "请输入关键词",style:TextStyle(color: Colors.white)
              ),
              onPressed: (){
                print("点击了搜索按钮");
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
        color:Color.fromRGBO(255, 65, 92, 1.0),
      ),
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar:PreferredSize(
            child:AppBar(
              title: searchBar(),
              backgroundColor: Color.fromRGBO(254, 106, 127, 1.0),
            ),
            preferredSize: Size.fromHeight(45),
          ),
          body: Center(
              child: null
          ),
        ),
      theme: ThemeData(
        primarySwatch:Colors.pink,
      ),
    );
  }
}
