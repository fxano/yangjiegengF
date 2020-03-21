//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:yangjiegeng/tool/Bar.dart';
//
//class OwnFollow extends StatefulWidget{
//  @override
//  _OwnFollow createState() => new _OwnFollow();
//}
//class _OwnFollow extends State<OwnFollow>{
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar:PreferredSize(
//          child: Bar(
//            text: "我的关注",
//          ),
//          preferredSize: Size.fromHeight(45),
//        )
//    );
//
//  }
//}
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';
import 'package:yangjiegeng/utils/indexJson.dart';
class OwnFollow extends StatefulWidget{  //首页
  @override
  _OwnFollow createState() => new _OwnFollow();
}
class _OwnFollow extends State<OwnFollow>{
  var index=0;//请求数据表示
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo(index);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        if(isLoading){
          _getInfo(index);
        }
      }
    });
  }//初始化


  Widget lunView(){
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        children: <Widget>[
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
//        color: Color.fromRGBO(255, 65, 92, 1.0)
          image:DecorationImage(
              image:AssetImage('images/test.png'),
              fit: BoxFit.cover
          )
      ),
    );
  }//轮播图

//自定义item

  ScrollController _scrollController=ScrollController();//listView控制器
  var isLoading=true;//是否能加载数据
  List list = new List(); //列表要展示的数据
  Widget _buildSuggestions() {
    return GridView.builder(
      controller:_scrollController,
      itemCount: list.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (BuildContext context,int index){
        if(index<list.length){
          return getItemContainer(index);
        }
        if(isLoading){
          return _getMoreWidget();
        }
        return _noMore();

      },

//        physics:const BouncingScrollPhysics(),

//        itemBuilder: (BuildContext _context, int i) {
//          if(i<list.length){
//            if(i==0){
//              return lunView();
//            }
//            print(i);
//            var item1=list[i].toString();
//            return _buildRow(item1, item1);
//          }
//          if(isLoading){
//            return _getMoreWidget();
//          }
//          return _noMore();
//        }
        );
  }//list列表视图
  Widget getItemContainer(int item){
    return Container(//右侧
//        width: 172,
//        height: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width:45,
                    margin: EdgeInsets.only(left: 10,bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.vibration,size: 14,color: Colors.white,),
                        Text("1234",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width:65,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.video_label,size: 14,color: Colors.white,),
                        Text("1234",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 35,
                      margin: EdgeInsets.only(right: 10,bottom: 5),
                      child:Text(
                        "5:29",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12,color: Colors.white),
                      )
                  )
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/test.png"),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),topRight: Radius.circular(10)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,top: 6),
              height: 64,
              width: 155,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height:40,
                    child:Text(
                      '$item',
                      style:TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,),
                  ),
                  Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "123",
                            style: TextStyle(fontSize: 15,color: Colors.grey),
                          ),
                          Icon(Icons.toc,color: Colors.grey,)
                        ],
                      )
                  )
                ],
              ),
            ),
          ],
        ),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
        )
    );
  }
  Widget _noMore(){
    return Text(
        "没有更多了"
    );
  }//没有更多时显示的组件

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }//加载更多时显示的组件,给用户提示

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color.fromRGBO(232, 232, 232, 1.0),
          appBar:PreferredSize(
          child: Bar(
            text: "我的关注",
          ),
          preferredSize: Size.fromHeight(45),
        ),
          body:Center(
            child: Column(
              children: <Widget>[
                Expanded(
                    child:Container(
                      width: 350,

                      child: _buildSuggestions(),
                    )
                )
              ],
            ),
          )
      );
  } //绘制布局

  Future _getInfo(int uid) async {
    index+=10;
    var result=await HttpUtils.request(
        "object/getIndex",method: HttpUtils.GET,
        data: {
          'uid':uid,
        }
    );
    IndexJson jj=IndexJson.fromJson(result);
    print(list.length);
    setState(() {
      if(jj.infoMap.length==0){
        isLoading=false;
      }
      if(uid!=0){
        list.addAll(List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString()));
      }else{
        list=List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString());
      }
    });
  }//数据请求

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}

