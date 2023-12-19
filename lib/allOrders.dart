import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/material_recived_factore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/factores.dart';
import 'model/user.dart' as usr;
import 'model/order.dart' as ordr;

class AllOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllOrders_State();
  }
}

class AllOrders_State extends State<AllOrders> {
  late String wood = "", glass = "", clothe = "", namefactor = "", plastic = "";
  List order = [], nameuser = [], address = [], userid = [];
  List<User> user = [];
  List<ordr.Order> orderlist = [];
  Factor factor = Factor();
  bool isLoaded = false;
  void getData() async {
    final factorid = await FirebaseAuth.instance.currentUser!.uid;
    print("$factorid");
    await FirebaseFirestore.instance
        .collection('factores')
        .where('id', isEqualTo: factorid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        factor = Factor.fromJson(element.data());
      });
    });
    CollectionReference userinfo =
        await FirebaseFirestore.instance.collection("user");
    CollectionReference materailinfo =
        FirebaseFirestore.instance.collection("AllOrders");
    await materailinfo
        .where('namefactor', isEqualTo: factor.username)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("++++++++++++++++++++++++++++++++++");
          print("${element.data()}");
          if (element.get('apply') == true) {
            print("${element.get('apply')} ");
            orderlist.add(ordr.Order.fromJson(
                element.data() as Map<String, dynamic>, element.id));
          }
        });
      });
    });
    for (int i = 0; i < orderlist.length; i++)
      await userinfo
          .where('id', isEqualTo: orderlist[i].iduser)
          .get()
          .then((value) {
        print("+++++++++++++++++++ ${value.docs.length}");
        value.docs.forEach((element) {
          setState(() {
            print("+++++++++++++++++++");

            orderlist[i].user =
                usr.User.fromJson(element.data() as Map<String, dynamic>);
          });
        });
      });
    isLoaded = true;
    setState(() {});
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Requests Archive",
            style: TextStyle(
                color: Color(0xf0115228),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: true,
          leading: Padding(
              padding: EdgeInsets.only(left: 1),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
              )),
        ),
        body: isLoaded
            ? orderlist.isNotEmpty
                ? ListView.builder(
                    itemCount: orderlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 40, 10, 10),
                              child: Text(
                                "Material Type : \n ${orderlist[index].material}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                "Amount : ${orderlist[index].amount} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: width * 0.1),
                              child: Text(
                                  "Username : ${orderlist[index].user!.username}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: width * 0.39, top: 10),
                              child: Text(
                                  "Location : ${orderlist[index].user!.address}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: width * 0.1, top: 10),
                              child: InkWell(
                                onTap: () {
                                  launchUrl(Uri(
                                      scheme: 'tel',
                                      path: '${orderlist[index].user!.phone}'));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "user Phone : ${orderlist[index].user!.phone}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: width * 0.39, top: 10),
                              child: Text(
                                  orderlist[index].applyfactor == true
                                      ? "Status : Accepted"
                                      : "Status : Rejected",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          orderlist[index].applyfactor == true
                                              ? Colors.green
                                              : Colors.red)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      );
                    })
                : Container(
                    child: Center(
                      child: Text(
                        "No Requests",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                    ),
                  )
            : Center(child: CircularProgressIndicator()));
  }
}
