import 'package:flutter/material.dart';

class Bar extends StatelessWidget{
  final String text;
  Bar({this.text});

  @override
  Widget build(BuildContext context) {
      return AppBar(
        backgroundColor: Color.fromRGBO(254, 106, 127, 1.0),
        centerTitle: true,
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
    );
  }
}