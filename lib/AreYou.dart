import 'package:flutter/material.dart';
import 'package:recycle_recover/Sing_page.dart';
import 'package:recycle_recover/signiIn_factore.dart';
import 'package:recycle_recover/signin_admin.dart';
import 'const.dart';
class Areyou extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Areyou_State();
  }
}

class Areyou_State extends State<Areyou> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.4),
            child: Container(
              width: double.infinity,
              height: height,
              child: Image.asset("image/logo.jpg"),
            )),
        Positioned(
            bottom: height * 0.45,
            left: width * 0.2,
            right:width * 0.2 ,
            child: Text(
              "ARE YOU",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xf0115228)),
            )),
        Positioned(
          child: Button(context , "Admin",SinginAdmin()), //عرفنا تابع موجود في ملف const نمرر له المان الذي نحن فيهو اسم الزر و الإنتقاللأي صفحة
          bottom: height * 0.3,
          right: width * 0.20,
          left: width *0.20,
        ),
        Positioned(
          child: Button(context , "User",sing_Page()),
          bottom: height * 0.20,
          right: width * 0.20,
          left: width *0.20,
        ),
        Positioned(
          child: Button(context , "Factories",SignIn_Factore()),
          bottom: height * 0.11,
          right: width * 0.20,
          left: width *0.20,
        ),
      ],
    ));
  }
}


