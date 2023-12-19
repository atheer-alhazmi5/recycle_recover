import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/wecom_page1.dart';
import 'package:recycle_recover/AreYou.dart';
import 'Getstart_Page.dart';

class welcom_page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return welcom_page2_State();
  }
}

class welcom_page2_State extends State<welcom_page2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SafeArea(
        child: Container(
          child: Image.asset(
            "image/Why recycling.png",
            fit: BoxFit.fill,
          ),
          width: width,
          height: height * 0.5,
        ),
      ),
      Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Why Recycling ?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xf0115228)),
          )),
      Padding(
          padding: EdgeInsets.all(23),
          child: Text(
            "To preserve the environment and natural resources to enhance sustainability and provide appropriate waste management",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black26,
            ),
          )),



      Row( // اضفنا صف لنضع الزرين بجانب بعضهما البعض
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: width / 3,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  "back",
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xf0115228);
                      else
                        return Colors.white;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                    return welcom_page1();
                  }));
                },
              )),
          SizedBox(width: 20 ,),
          Container(
              width: width / 3,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.black26;
                      else
                        return Color(0xf0115228);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return get_Start();
                  }));
                },
              ),
              ),

        ],


      )


    ])

    );

  }
}
