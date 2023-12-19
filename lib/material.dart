import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/Location_user.dart';
import 'package:recycle_recover/Select_Factories.dart';
import 'package:recycle_recover/home_page.dart';
import 'Account user.dart';
import 'News.dart';

class material extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return material_State();
  }
}

class material_State extends State<material> {
  double x = 1.0, y = 1.0, z = 1.0, n = 1.0;
  late String Name = "";
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Name = element.get('username');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Material Category",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xf0115228),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.white70,
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.05),
            child: ListView(
              children: [
                Text(
                  "Welcome $Name",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xf0115228),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text("Choose The Material Category",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xf0115228),
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                Row(
                  children: [
                    Container(
                        color: Colors.white,
                        width: width / 2,
                        child: ElevatedButton(
                            onPressed: () => setState(() {
                                  y == 1.0 ? y = 0.3 : y = 1.0;
                                }),
                            child: Opacity(
                              opacity: y,
                              child: Image.asset("image/3.png"),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.transparent;
                                else
                                  return Colors.white;
                              }),
                            ))),
                    Container(
                      color: Colors.white,
                      width: width / 2,
                      child: ElevatedButton(
                          onPressed: () => setState(() {
                                z == 1.0 ? z = 0.3 : z = 1.0;
                              }),
                          child: Opacity(
                            opacity: z,
                            child: Image.asset("image/2.png"),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.transparent;
                              else
                                return Colors.white;
                            }),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Row(
                    children: [
                      Container(
                          color: Colors.white,
                          width: width / 2,
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    n == 1.0 ? n = 0.3 : n = 1.0;
                                  }),
                              child: Opacity(
                                  opacity: n,
                                  child: Image.asset("image/4.png")),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.transparent;
                                  else
                                    return Colors.white;
                                }),
                              ))),
                      Container(
                        color: Colors.white,
                        width: width / 2,
                        child: ElevatedButton(
                            onPressed: () => setState(() {
                                  x == 1.0 ? x = 0.3 : x = 1.0;
                                }),
                            child: Opacity(
                              opacity: x,
                              child: Image.asset(
                                "image/1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.transparent;
                                else
                                  return Colors.white;
                              }),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Container(
                    width: width * 0.8,
                    height: height * 0.07,
                    child: ElevatedButton(
                        child: Text(
                          "Next ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {
                          if (x != 1 || y != 1 || z != 1 || n != 1) {
                            addMaterial();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return Select_Factories();
                            }));
                          }
                        }),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xf0115228),
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.maps_home_work_sharp),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.newspaper),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return news();
                  }));
                },
              ),
              label: "News"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return home_Page();
                  }));
                },
                icon: Icon(Icons.person_outline_outlined),
              ),
              label: "ِAbout us"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.perm_contact_calendar),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return account();
                  }));
                },
              ),
              label: "Profile"),
        ],
      ),
    );
  }

  void addMaterial() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("material")
        .add({'id': userid, 'wood': x, 'plastic': z, 'glass': n, 'clothes': y});
  }
}
