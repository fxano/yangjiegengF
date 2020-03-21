import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:yangjiegeng/router.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';
import 'package:yangjiegeng/utils/indexJson.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class HomePage extends StatefulWidget{  //首页
  @override
  _HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var index=0;//请求数据标识
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo(index);
    _indexImages(0);
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

  Widget _searchBar(){
    return Center(
        child:Container(
          height: 30,
          width: 300,
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton.icon(
                  onPressed:(){
                    Router.push(context, Router.searchPage, "123",);
                  },
                  icon:Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: Text(
                      "请输入关键词",style:TextStyle(color: Colors.white)
                  ),
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
  }//导航栏

  List imageList=List();//图片路径
  List title=List();//图片名称
  Widget _lunView(){
    if(imageList.length==0){
      return _getMoreWidget();
    }
    return Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Swiper(
          itemCount: imageList.length,
          itemBuilder: (context,index){
            return Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200,
                    child:Image.network(
                      imageList[index],
                      fit: BoxFit.cover ,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      title[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                  )
                ],
            );
          },
          pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
              color: Colors.white,
              activeColor: Colors.pinkAccent,
              size: 3,
              activeSize: 5,
            )
          ),
          autoplay: true,
          autoplayDelay: 6000,
          duration: 2000,
          onTap: (index){
            print("点击了第$index个");
//            Router.push(context, Router.infoPage,title[index]);
          },
        ),
      )
    );
  }//轮播图

  Widget _buildRow(Map item1,int i) {//自定义item
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Router.pushInfo(context, Router.infoPage, item1,0);
            },
            child:Container(//左侧
                width: 172,
                height: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 85,
                          child:ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            child: Image.network(
                              item1["url"],
                              fit:BoxFit.cover ,
                            ),
                          ) ,
                        ),
                        Positioned(
                          left: 10,
                          bottom: 2,
                          child: Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.star_border,size: 12,color: Colors.white,),
                                Text(item1["support"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//点赞
                        Positioned(
                          bottom: 2,
                          left: 50,
                          child:Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.playlist_add_check,size: 12,color: Colors.white,),
                                Text(item1["time"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//评论
                        Positioned(
                          bottom: 2,
                          right: 10,
                          child:Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.open_in_browser,size: 12,color: Colors.white,),
                                Text(item1["browse"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//浏览量
                      ],
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
                              item1["name"],
                              style:TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,),
                          ),//标题
                          Container(
                              padding: EdgeInsets.only(),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child:Text(
                                      item1["group"],
                                      style: TextStyle(fontSize: 12,color: Colors.grey),
                                    ),
                                    margin: EdgeInsets.only(top: 3),
                                  ),

                                  Icon(Icons.toc,color: Colors.grey,)
                                ],
                              )
                          )//分组
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
            ),
          ),
          GestureDetector(
            onTap: (){
              Router.pushInfo(context, Router.infoPage, item1,1);
            },
            child:Container(//右侧
                width: 172,
                height: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 85,
                          child:ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            child: Image.network(
                              item1["url1"],
                              fit:BoxFit.cover ,
                            ),
                          ) ,
                        ),
                        Positioned(
                          left: 10,
                          bottom: 2,
                          child: Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.star_border,size: 12,color: Colors.white,),
                                Text(item1["support1"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//点赞
                        Positioned(
                          bottom: 2,
                          left: 50,
                          child:Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.playlist_add_check,size: 12,color: Colors.white,),
                                Text(item1["time1"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//评论
                        Positioned(
                          bottom: 2,
                          right: 10,
                          child:Container(
                            child:Row(
                              children: <Widget>[
                                Icon(Icons.open_in_browser,size: 12,color: Colors.white,),
                                Text(item1["browse1"],style: TextStyle(fontSize: 12,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),//浏览量
                      ],
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
                              item1["name1"],
                              style:TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,),
                          ),//标题
                          Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child:Text(
                                      item1["group1"],
                                      style: TextStyle(fontSize: 12,color: Colors.grey),
                                    ),
                                    margin: EdgeInsets.only(top: 3),
                                  ),

                                  Icon(Icons.toc,color: Colors.grey,)
                                ],
                              )
                          )//分组
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
            ),
          ),
        ],
      ),
    );

  }//自定义item

  ScrollController _scrollController=ScrollController();//listView控制器
  var isLoading=true;//是否能加载数据
  List list = new List(); //列表要展示的数据
  Map<String,dynamic> item=Map<String,dynamic>();
  Widget _buildSuggestions() {
    return ListView.builder(
        controller:_scrollController,
        physics:const BouncingScrollPhysics(),
        itemCount:list.length+2,
        itemBuilder: (BuildContext _context, int i) {
          if(i<=list.length){
            if(i==0){
              return _lunView();
            }
            var index=i-1;
            return _buildRow(item['$index'],i);
          }
          if(isLoading){
            return _getMoreWidget();
          }
          return _noMore();
        });
  }//list列表视图

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
          backgroundColor: Color.fromRGBO(232, 232, 232, 1.0),
          appBar:PreferredSize(
            child:AppBar(
              title: _searchBar(),
              backgroundColor: Color.fromRGBO(254, 106, 127, 1.0),
            ),
            preferredSize: Size.fromHeight(45),
          ),
          body:RefreshIndicator(
            color: Colors.pinkAccent,
            onRefresh: _onRefresh,
            child:Center(
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
            ),
        )
      ),
        theme: ThemeData.light(),
    );
  } //绘制布局

  Future<Null> _onRefresh() async{
    var fresh=10;
    var result=await HttpUtils.request(
        "object/getIndex",method: HttpUtils.GET,
        data: {
          'uid':fresh,
        }
    );
    IndexJson jj=IndexJson.fromJson(result);
    print(list.length);
    setState(() {
      if(jj.infoMap.length==0){
        isLoading=false;
      }
      for(var i=0;i<jj.infoMap.length;i++){
        item['$i']=jj.infoMap['$i'];
      }
      list=List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString());
    });
  }//刷新数据

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
        isLoading=false;
      }else{
        if(uid!=0){
          for(var i=0;i<jj.infoMap.length;i++){
            var mm=uid+i;
            item['$mm']=jj.infoMap['$i'];
          }
          list.addAll(List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString()));
        }else{
          for(var i=0;i<jj.infoMap.length;i++){
            item['$i']=jj.infoMap['$i'];
          }
          list=List.generate(jj.infoMap.length, (i) => jj.infoMap['$i'].toString());
        }
      }
    });
  }//数据请求

  Future _indexImages(int uid) async{
    var result=await HttpUtils.request(
        "object/getIndexImages",method: HttpUtils.GET,
        data: {
          'uid':uid,
        }
    );
    IndexJson jj=IndexJson.fromJson(result);
    setState(() {
      Map<String,dynamic> images=Map<String,dynamic>();
      imageList.addAll(List.generate(jj.infoMap.length, (index) {
        images=jj.infoMap['$index'];
        return images["url"];
      }));
      title.addAll(List.generate(jj.infoMap.length, (index) {
        images=jj.infoMap['$index'];
        return images["name"];
      }));
    });
  }//请求主页轮播图

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }//页面废弃时调用

}