import 'package:flutter/material.dart';
import 'package:recycle_recover/material.dart';
import 'SingupUser.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingInUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Login_State();
  }
}

class Login_State extends State<SingInUser> {
  @override
//All three system users must enter their email and password
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
                  Padding( // enter email
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: TextField( //text Field where the users can enter their email
                      onChanged: (val) {
                        setState(() {
                          Email = val;//user can change the value entered in the text field, the system can access the updated value
                        });
                      },
                      cursorColor: Color(0xff115228),
                      style: TextStyle(
                        color: Color(0xf0115228),
                      ),
                      decoration: InputDecoration( // add email icon
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xf0115228),
                          ),
                          labelText: "Enter E-mail", // labeltext contain enter email to  To clarify
                          labelStyle: TextStyle(color: Color(0xf0115228)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never, // to make a fixed text
                          border: OutlineInputBorder( // Border properties
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
                      keyboardType: TextInputType.emailAddress, //That field only accepts email addresses as input
                    )
                  ),

                  TextField(
                    onChanged: (val) { //user can change the value entered in the text field, the system can access the updated value
                      setState(() {
                        password = val;
                      });
                    },
                    cursorColor: Color(0xff115228),
                    style: TextStyle(
                      color: Color(0xf0115228),
                    ),
                    decoration: InputDecoration( // add Passwoed icon
                        prefixIcon: Icon(
                          Icons.password,
                          color: Color(0xf0115228),
                        ),
                        labelText: "Enetr Password", // labeltext contain enter password text to clarify
                        labelStyle: TextStyle(color: Color(0xf0115228)),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never, // to make a fixed text
                        border: OutlineInputBorder( // border properties
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
                    keyboardType: TextInputType.visiblePassword, //The field accepts passwords as input
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                        child: ElevatedButton( // create
                          child: Text( //Create a button with a login text, giving it specific properties
                            "Sign In ",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(//the background color of the button is dark green, and when pressed, it's changes to black.
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.black26;
                                else
                                  return Color(0xf0115228);
                              }),
                              // email and password entered are validated and logged in if they are correct,
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
                                      return material(); // then the user is transferred to the main user interface, which is Meterial.
                                    }));
                            }
                            catch (e) { //This code controls the errors that can occur when logging in with Firebase, the error message is shown if any error occurs
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(//User's AlertDialog dialog containing the error message
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      ElevatedButton (//By clicking on the "OK" button, this box will be hidden and you will return to the previous screen
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
                                  builder: (_) => singUpUser()));
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
