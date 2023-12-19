import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'account_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class singupAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return singupAdmin_state();
  }
}

class singupAdmin_state extends State<singupAdmin> {
  @override
  late String Email;
  late String password;
  late String username;
  late String address,VerifyPassword;
// Insert data in the database of the system when registering a new Admin in the system
  addData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference user = FirebaseFirestore.instance.collection("admin");
    user.add({
      "id": userid,
      "username": username,
      "email": Email,
      "password" :password,
      "image": ""
    });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Container(
                color: Colors.white,
                height: height,
                width: width,
                child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: height * 0.25,
                        width: double.infinity,
                        child: Image.asset("image/logo.jpg"),
                      ),
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xf0115228)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline_outlined,
                                color: Color(0xf0115228),
                              ),
                              labelText: "User Name",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[A-z]'))
                          ],
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              Email = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              VerifyPassword = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Verify Password",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: ElevatedButton(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                                          borderRadius:
                                          BorderRadius.circular(30)))),
                              onPressed: () async {
                                if(password==VerifyPassword)
                                try {
                                  var user = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: Email, password: password);

                                  addData();
                                  if (user != null)
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return account_admin();
                                    }));
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          ElevatedButton (
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                else showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("The Password isn't the same verify password"),
                                      actions: [
                                        ElevatedButton (
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          )),
                    ])))));
  }
}