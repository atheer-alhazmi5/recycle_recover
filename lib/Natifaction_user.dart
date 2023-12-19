import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class natifaction_user extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return order_user_State();
  }
}

class order_user_State extends State<natifaction_user> {
  late String userid;
  List order=[];
  void getData() async {
    userid= await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userInfo =FirebaseFirestore.instance.collection('user');
    userInfo.where('id',isEqualTo: userid).get().then((value) => value.docs.forEach((element) {
      print(element.get('id'));
      userid=  element.get('id');
    }));
    CollectionReference mat=FirebaseFirestore.instance.collection("Order");
    await  mat.where('iduser',isEqualTo: userid).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("===================================");
          order.add(element.data());
        });
      });
    });
    for(int i=0;i<order.length;i++)
    {
      userInfo.where('id',isEqualTo: order[i]['iduser']).get().then((value) => value.docs.forEach((element) {
        setState(() {
          print(order[i]['iduser']);
          order[i]['username'] = element.get('username');
          order[i]['address']= element.get('address');
          order[i]['phone']= element.get('phone');
          if(order[i]['apply']==true)
            order[i]['apply']= 'Accepted From Admin';
          else order[i]['apply']= 'Waiting Accepted From Admin';
          if(order[i]['applyfactor']==true)
            order[i]['applyfactor']= 'Accepted From Factor';
          else order[i]['applyfactor']= 'Waiting Accepted From Factor';
          print(order);
        });
      }));
    }

  }

  void initState() {
    getData();
    super.initState();
  }
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Notification",
            style: TextStyle(
                color: Color(0xf0115228),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: true,
          leading: Padding(
              padding: EdgeInsets.only(left: 1),
              child: IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),)
          ),
        ),
        body: ListView.builder(itemCount:order.length, itemBuilder:(context,index){
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Text(
                    "Order: ${index+1}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Color(0xf0115221)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Text(
                    "Material Type : \n ${order[index]['material']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: width * 0.39),
                  child: Text("Factor name : ${order[index]['namefactor']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("Amount : ${order[index]['amount']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("UserName: ${order[index]['username']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("Address: ${order[index]['address']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("phone: ${order[index]['phone']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("From Admin: ${order[index]['apply']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                  child: Text("From Factor: ${order[index]['applyfactor']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ],
            ),
          );
        } )
    );
  }
}