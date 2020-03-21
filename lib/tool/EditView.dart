import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditView extends StatelessWidget {
  final double width;
  final double height;
  final double marginTop;
  final double marginBottom;
  final String labelText;
  final bool isPsw;
  final TextEditingController editController;
  EditView({this.width,this.height,this.isPsw,this.labelText,this.marginBottom,this.editController,this.marginTop});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: marginTop,bottom: marginBottom),
        child:Theme(
          data: new ThemeData(primaryColor: Color.fromRGBO(228, 87, 197, 1.0)),
          child: TextField(
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9.]")),//只允许输入字母
            ],
            cursorWidth: 1,
            cursorColor: Color.fromRGBO(228, 87, 197, 1.0),
            controller: editController,
            decoration: InputDecoration(
                labelText: labelText
            ),
            autofocus: false,
            obscureText: isPsw,
          ),
        )
    );
  }
}
