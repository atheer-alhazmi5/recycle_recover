import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Account user.dart';
import 'account_factore.dart';

class aboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return aboutus_state();
  }
}

class aboutus_state extends State<aboutUs> {
  String id = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController workHourController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('factores')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("=============");
          usernameController.text = element.get('username');
          phoneController.text = element.get('phone');
          passwordController.text =
              rePasswordController.text = password = element.get('password');
          addressController.text = element.get('address');
          EmailController.text = element.get('email');
          materialController.text = element.get('material');
          workHourController.text = element.get('workhours');
          bioController.text = element.get('bio');
          id = element.id;
        });
      });
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  void update() async {
    if (password != passwordController.text) {
      try {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(
                    "Password must be at least 6 characters long and contain a number and a letter"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"))
                ],
              );
            });
        return;
        // TODO
      }
    }

    CollectionReference userinfo =
        FirebaseFirestore.instance.collection("factores");
    print("=================");
    print('$id');
    await userinfo.doc(id).update({
      "username": usernameController.text,
      "email": EmailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
      "password": passwordController.text,
      "material": materialController.text,
      "workhours": workHourController.text,
      "bio": bioController.text,
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Text("Your data has been updated successfully"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        }).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(
                color: Color(0xf0115228),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Container(
              color: Colors.white,
              height: height,
              width: width,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: height * 0.05),
                      child: Text("Personal Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, height * 0.04, 10, 10),
                      child: TextFormField(
                        controller: usernameController,
                        validator: (value) => value!.length < 6
                            ? 'Please enter valid your username'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline_outlined,
                              color: Color(0xf0115228),
                            ),
                            labelStyle: TextStyle(color: Color(0xf0115228)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none))),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, height * 0.01, 10, 10),
                      child: TextFormField(
                        validator: (value) => value!.length < 4
                            ? 'Please enter valid text'
                            : null,
                        controller: bioController,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.dashboard,
                              color: Color(0xf0115228),
                            ),
                            labelStyle: TextStyle(color: Color(0xf0115228)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none))),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        controller: EmailController,
                        validator: (value) => value!.length < 6 ||
                                !value.contains("@") ||
                                !value.contains(".com")
                            ? 'Please enter valid your address'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xf0115228),
                            ),
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
                      child: TextFormField(
                        controller: phoneController,
                        validator: (value) => value!.length < 9
                            ? 'Please enter valid mobile number'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Color(0xf0115228),
                            ),
                            labelStyle: TextStyle(color: Color(0xf0115228)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none))),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        controller: materialController,
                        validator: (value) => value!.length < 4
                            ? 'Please enter valid text'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pages,
                              color: Color(0xf0115228),
                            ),
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
                      child: TextFormField(
                        controller: workHourController,
                        validator: (value) => value!.length < 1
                            ? 'Please enter valid work hour'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.hourglass_empty_sharp,
                              color: Color(0xf0115228),
                            ),
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        controller: addressController,
                        validator: (value) => value!.length < 4
                            ? 'Please enter a valid address'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.home,
                              color: Color(0xf0115228),
                            ),
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
                      padding: EdgeInsets.only(
                          top: height * 0.02, bottom: height * 0.02),
                      child: Text("Change Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) => value!.length < 6
                            ? 'Please enter valid password'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xf0115228),
                            ),
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
                      child: TextFormField(
                        controller: rePasswordController,
                        validator: (value) => value != passwordController.text
                            ? 'Password does not match'
                            : null,
                        cursorColor: Color(0xff115228),
                        style: TextStyle(
                          color: Color(0xf0115228),
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xf0115228),
                            ),
                            labelText: "$password",
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
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: ElevatedButton(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  update();
                                }
                              }),
                        )),
                  ]))),
        )));
  }
}
