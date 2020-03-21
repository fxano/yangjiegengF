import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconName;
  final String title;
  Item({this.title,this.iconName,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              width: 20,
              height: 20,
              child:Image.asset(iconName),
            ),
            Text(title,style: TextStyle(fontSize: 14)),
            Expanded(child: Container()),
            Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 10),
                child:Image.asset("images/more.png")
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5)
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}