import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recycle_recover/Account%20user.dart';
import 'package:recycle_recover/News.dart';
import 'package:recycle_recover/material.dart';
import 'dart:core';

class home_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return home_Pagestate();
  }
}

class home_Pagestate extends State<home_Page> {
   late  String Name="" ;
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

     await FirebaseFirestore.instance
         .collection('user')
         .where('id' ,isEqualTo: userid)
         .get().then((value) {
       value.docs.forEach((element) {
         setState(() {
           Name = element.get('username');
         });
       });
     });

  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: width,
                height: height / 9,
                child: Padding(
                    padding: EdgeInsets.only(left: 30, top: height * 0.04),
                    child: Row(
                      children: [
                        Text(
                          "Welcome $Name",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xf0115228),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 200, 10),
                  child: Text(
                    "About Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Text(
                    "We are female students of Taibah University, College of Computer Science and Engineering and we are committed with our graduation project to making the world a cleaner and more sustainable place. We believe that recycling is one of the simplest and most effective ways to protect our environment and preserve our planet for future generations. That's why we've created this app to make recycling easier and more accessible for everyone."
                    "Our mission is to empower individuals and communities to take action against waste and pollution by providing them with the tools and resources they need to recycle more effectively. With our app, you can easily locate recycling centers near you, learn about different types of recyclable materials, and get tips on how to reduce your environmental impact."
                    "We also believe that collaboration is key to achieving our goals. That's why we partner with local businesses, organizations, and governments to promote recycling and sustainable practices in our communities. Together, we can create a cleaner, healthier, and more sustainable world for all.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xf0115228),
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),

    );
  }
}
