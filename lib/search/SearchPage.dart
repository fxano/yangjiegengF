import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{//搜索页


  @override
  State createState() {
    return _SearchPage();
  }
}
class _SearchPage extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:SafeArea(
          child: Column(


          children: <Widget>[
            TextField(
              autofocus: true,
            )
          ],
        ),
      ),
    )

    );
  }
}