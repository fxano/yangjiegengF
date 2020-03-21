import 'package:flutter/material.dart';

class TextOnClick extends StatelessWidget{
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final double size;
  TextOnClick({this.text,this.color,this.size,this.onPressed});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style:TextStyle(
            fontSize: size,
            color: color),
      )
    );
  }
}