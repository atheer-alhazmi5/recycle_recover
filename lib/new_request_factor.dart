import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/material_recived_factore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/factores.dart';
import 'model/user.dart' as usr;
import 'model/order.dart' as ordr;

class new_Req extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new_Req_State();
  }
}

class new_Req_State extends State<new_Req> {
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
        log(element.data().toString());
        factor = Factor.fromJson(element.data());
      });
    });
    CollectionReference userinfo =
        await FirebaseFirestore.instance.collection("user");
    CollectionReference materailinfo =
        FirebaseFirestore.instance.collection("Order");
    await materailinfo
        .where('namefactor', isEqualTo: factor.username)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("++++++++++++++++++++++++++++++++++");
        print(element.data().toString());
        userid.add(element.get('iduser'));

        orderlist.add(ordr.Order.fromJson(
            element.data() as Map<String, dynamic>, element.id));
        print("Order List : " + orderlist.first.toJson().toString());
      });
    });
    log("Order List : " + orderlist.toString());
    for (int i = 0; i < orderlist.length; i++)
      await userinfo
          .where('id', isEqualTo: orderlist[i].iduser)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          orderlist.removeAt(i);
        } else
          value.docs.forEach((element) {
            print("+++++++++++++++++++");
            log(element.data().toString());

            orderlist[i].user =
                usr.User.fromJson(element.data() as Map<String, dynamic>);
          });
      });
    isLoaded = true;
    setState(() {});
  }

  deleteOrder(int index) async {
    CollectionReference materailinfo =
        FirebaseFirestore.instance.collection("Order");

    await FirebaseFirestore.instance
        .collection("AllOrders")
        .doc(orderlist[index].id)
        .set(orderlist[index].toJson());

    await materailinfo.doc(orderlist[index].id).delete();
    setState(() {
      orderlist.removeAt(index);
    });
  }

  void addpoint(int index) async {
    CollectionReference point = FirebaseFirestore.instance.collection('point');
    CollectionReference orders = FirebaseFirestore.instance.collection("Order");
    await point
        .where('id', isEqualTo: orderlist[index].iduser)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.id);
              point.doc(element.id).update({"apply": true});
            }));
    await orders.doc(orderlist[index].id).update({"applyfactor": true});

    setState(() {
      orderlist[index].applyfactor = true;
    });
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
            "New Request",
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
                              padding: EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  orderlist[index].applyfactor!
                                      ? SizedBox()
                                      : Container(
                                          color: Colors.white,
                                          height: height / 9,
                                          width: width / 3,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                if (orderlist[index]
                                                        .user!
                                                        .username !=
                                                    null) {
                                                  addpoint(index);
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (_) {
                                                    return recived();
                                                  }));
                                                }
                                              },
                                              child: Image.asset("image/t.jpg"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) {
                                                  if (states.contains(
                                                      MaterialState.pressed))
                                                    return Colors.transparent;
                                                  else
                                                    return Colors.white;
                                                }),
                                              ))),
                                  Container(
                                    color: Colors.white,
                                    height: height / 9,
                                    width: orderlist[index].applyfactor!
                                        ? (width - 100)
                                        : (width / 3),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          deleteOrder(index);
                                        },
                                        child: Image.asset("image/false.jpg"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Colors.transparent;
                                            else
                                              return Colors.white;
                                          }),
                                        )),
                                  ),
                                ],
                              ),
                            ),
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
