import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';
import 'package:yangjiegeng/utils/indexJson.dart';

//class OwnFans extends StatefulWidget{
//  @override
//  _OwnFans createState() => new _OwnFans();
//}
//class _OwnFans extends State<OwnFans>{
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar:PreferredSize(
//          child: Bar(
//            text: "我的粉丝",
//          ),
//          preferredSize: Size.fromHeight(45),
//        )
//    );
//
//  }
//}
/*
 * Created by 李卓原 on 2018/9/13.
 * email: zhuoyuan93@gmail.com
 *
 */

class OwnFans extends StatefulWidget {
//  OwnFans({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<OwnFans> {
  List list = new List(); //列表要展示的数据
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = true; //是否正在加载数据
  Map<String,dynamic> item=Map<String,dynamic>();
  int index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getData();
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
  }

  /// 初始化list数据 加延时模仿网络请求
  Future getData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list = List.generate(15, (i) => '哈喽,我是原始数据 $i');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("widget.title"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: list.length + 1,
          controller: _scrollController,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < list.length) {
      return ListTile(
        title: Text(list[index]),
      );
    }
    if(isLoading){
      return _getMoreWidget();
    }
      return noMore();
  }

  /// 下拉刷新方法,为list重新赋值

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
      setState(() {
        index=10;
        isLoading=true;
        list = List.generate(10, (i) => '哈喽,我是新刷新的 $i');
      });
    });
  }


  /// 加载更多时显示的组件,给用户提示
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
  }
  Widget noMore(){
    return Text(
      "没有更多了"
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  Future _getInfo(int uid) async {
    index+=10;
    var result=await HttpUtils.request(
        "object/getIndex",method: HttpUtils.GET,
        data: {
          'uid':uid,
        }
    );
    IndexJson jj=IndexJson.fromJson(result);
    setState(() {
      if(jj.infoMap.length==0){
//        list.addAll(List.generate(1, (i) => "没有更多了"));
        isLoading=false;
      }
      if(uid!=0){
        list.addAll(List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString()));
      }else{
        list=List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString());
      }
    });
  }
}

