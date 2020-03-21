import 'package:flutter/material.dart';
class NewPage extends StatefulWidget{//发布页
  @override
  _NewPageState createState() => new _NewPageState();
}
class _NewPageState extends State<NewPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
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
