import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/SingInUser.dart';

import 'SingupUser.dart';
import 'const.dart';

class sing_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return sing_Page_State();
  }
}

class sing_Page_State extends State<sing_Page> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Colors.white,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.2, 0, height * 0.3),
          child: Container(
            width: width,
            child: Image.asset("image/sing.jpg"),
          )),
      Positioned(
        child: Button(context, "Sign In",SingInUser()),
        bottom: height /5,
        right: width * 0.1,
        left: width * 0.1,
      ),
          Positioned(
            child: Button(context, "Sign Up",singUpUser()),
            bottom: height /9,
            right: width * 0.1,
            left: width * 0.1,
          ),
    ]));
  }
}
