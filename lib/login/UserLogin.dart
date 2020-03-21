//账号密码登陆
import 'package:flutter/material.dart';
import 'package:yangjiegeng/router.dart';
import 'package:yangjiegeng/sqlite/SqlLite.dart';
import 'package:yangjiegeng/tool/EditView.dart';
import 'package:yangjiegeng/utils/HttpUtils.dart';

class UserLogin extends StatefulWidget{
  @override
  State createState() {
    return _UserLogin();
  }
}
class _UserLogin extends State<UserLogin>{
  TextEditingController nameController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _loginName(),
              ],
            ),
          ),
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage("images/beij.png"),
              fit: BoxFit.cover
            )
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _loginName(){
    return Container(
      margin: EdgeInsets.only(top: 105),
      padding: EdgeInsets.only(top: 30),
      width: 282,
      height: 299,
      child: Column(
        children: <Widget>[
          Image.asset("images/logo.png", width: 150,),
          EditView(
            width: 230,
            height: 55,
            marginTop: 10,
            marginBottom: 0,
            editController: nameController,
            labelText: " 输入账号",
            isPsw: false,
          ),//账号输入框
          EditView(
            width: 230,
            height: 55,
            marginTop: 5,
            marginBottom: 20,
            editController: passwordController,
            labelText: " 输入密码",
            isPsw: true,
          ),//密码输入框
          MaterialButton(
            child: Text("登 陆"),
            onPressed: (){
              _verification();
            },
            height: 39,
            minWidth: 230,
            color: Color.fromRGBO(252, 105, 133, 1.0),
            textColor: Colors.white,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
      ),
    );
  }



  _verification(){
    if(passwordController.text.length==0&&nameController.text.length==0){
      _dialog("请输入账号和密码");
    }else if(passwordController.text.length==0){
      _dialog("请输入密码");
    }else if(nameController.text.length==0){
      _dialog("请输入账号");
    }else{
      pd();
    }
  }
  _dialog(String text){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("提示"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  pd() async {
    var result = await HttpUtils.request(
        'user/login', method: HttpUtils.GET,
        data: {
          'username':nameController.text,
          'password':passwordController.text,
        }
    );
    print(result);
    if(result["Msg"]=="登陆成功"){
      int count=await SqlLite().add(result);
      print(count);
      Router.replace(context, Router.mainPage, "主页");
    }else if(result["Msg"]=="密码错误"){
      _dialog("账号或密码错误");
    }else if(result["Msg"]=="用户不存在"){
      _dialog("用户不存在");
    }else{
      _dialog("网络连接超时");
    }
  }
}