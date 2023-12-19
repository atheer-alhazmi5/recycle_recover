import 'package:flutter/material.dart';
import 'package:recycle_recover/AreYou.dart';

class get_Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getStart_state();
  }
}

class getStart_state extends State<get_Start> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
              child: Image.asset(
                "image/logo.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Text(
                "Let's make \n recycling a habit",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xf0115228),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.65,
                margin: EdgeInsets.fromLTRB(30, 40, 30, 40),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: ElevatedButton(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.black26;
                          else
                            return Color(0xf0115228);
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Areyou();
                      }));
                    }))
          ],
        ),
      ),
    ));
  }
}
