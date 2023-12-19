import 'package:flutter/material.dart';
import 'package:recycle_recover/signup_admin.dart';
import 'account_admin.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SinginAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SinginAdmin_State();
  }
}
//All three system users must enter their email and password
class SinginAdmin_State extends State<SinginAdmin> {
  @override
  late String Email;
  late String password;
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: Container(
            height: height,
            width: width,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, height * 0.1, 20, 0),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                          child: Image.asset("image/logo.jpg")),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                                    borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
                            keyboardType: TextInputType.emailAddress,
                          )
                      ),
                      TextField(
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
                                borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
                        keyboardType: TextInputType.visiblePassword,

                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child:Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                            child: ElevatedButton(
                                child: Text(
                                  "Sign In ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed))
                                        return Colors.black26;
                                      else
                                        return Color(0xf0115228);
                                    }),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                                onPressed: () async {
                                  try {
                                    var user = await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: Email, password: password);
                                    if (user != null)
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (_) {
                                            return account_admin();
                                          }));
                                  }
                                  catch (e) {
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
                                }
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have account ?",
                            style: TextStyle(color: Color(0xf0115228)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => singupAdmin()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Color(0xf0115228),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}