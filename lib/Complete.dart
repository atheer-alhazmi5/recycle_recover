import 'package:flutter/material.dart';
import 'package:recycle_recover/material.dart';

import 'home_page.dart';

class Complete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Complete_State();
  }
}

class Complete_State extends State<Complete> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: height * 0.25, left: width * 0.025),
                child: Text(
                  "You're good to go!",
                  style: TextStyle(
                      color: Color(0xf0115228),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.only(top: height * 0.01, left: width * 0.025),
                child: Text(
                  "Thank you for helping our environment",
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding:  EdgeInsets.only(top: height * 0.05),
              child: Container(
                width: width ,
                height: height * 0.15,
                child: Image.asset("image/yor're good to go.png"),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: height * 0.1),
                child: Container(
                  width: width * 0.9,
                  height: height * 0.07,
                  child: ElevatedButton(
                      child: Text(
                        "Home Page",
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return material();
                        }));
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
