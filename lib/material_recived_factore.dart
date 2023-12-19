import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/account_factore.dart';

class recived extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return recived_State();
  }

}
class recived_State extends State<recived>{

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       body:  Container(
         width: width,
         height: height,
         color: Colors.white,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Padding(
                 padding: EdgeInsets.only(top: height * 0.25, left: width * 0.025),
                 child: Text(
                   "Materials has been "
                       "received",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       color: Color(0xf0115228),
                       fontSize: 30,
                       fontWeight: FontWeight.bold),
                 )),
             Padding(
                 padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
                 child: Text(
                   "Thank you for helping our environment",
                   style: TextStyle(
                       color: Colors.black38,
                       fontSize: 17,
                       fontWeight: FontWeight.bold),
                 )),
             Padding(
               padding:  EdgeInsets.only(top: height * 0.06),
               child: Container(
                 width: width ,
                 height: height * 0.15,
                 child: Image.asset("image/yor're good to go.png"),
               ),
             ),

             Padding(
                 padding: EdgeInsets.only(top: height * 0.15),
                 child: Container(
                   width: width * 0.9,
                   height: height * 0.07,
                   child: ElevatedButton(
                       child: Text(
                         "OK",
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

                           return account_Factor();
                         }));
                       }),
                 )),
           ],
         ),
       ),
    );
  }

}