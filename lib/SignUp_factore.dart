import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recycle_recover/account_factore.dart';
import 'package:recycle_recover/add_location_factore.dart';

class SignUp_factors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUp_factors_State();
  }
}

class SignUp_factors_State extends State<SignUp_factors> {
  late String userName,phone,password,Email,address,Verify,material,workhours,bio;
  // Insert data in the database of the system when registering a new Factories in the system
  addData() async {
    final factorised = await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference user = FirebaseFirestore.instance.collection("factores");
    user.add({
      "id": factorised,
      "username": userName,
      "email": Email,
      "phone": phone,
      "password": password,
      "address": address,
      "material":material,
      "workhours":workhours,
      "bio" : bio,
      "image" : ""

    });
  }
  @override
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
                    height: height * 0.2,
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
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          userName = val;
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
                          labelText: "Name",
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
                              phone = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Phone Number",
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          keyboardType: TextInputType.phone,
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 8, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              address = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.home,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Address",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              material = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.pages,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Material",
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
                              workhours = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.hourglass_empty_sharp,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Work Hours",
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, height * 0.01, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              bio = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.dashboard,
                                color: Color(0xf0115228),
                              ),
                              labelText: "Bio",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 8, 10),
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
                              Verify = val;
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
                              onPressed: ()async {
                                if(password==Verify)
                                try {
                                  var factor = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: Email, password: password);

                                  addData();
                                  if (factor != null)
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return account_Factor();
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
