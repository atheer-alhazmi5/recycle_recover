import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return notification_State();
  }
}

class notification_State extends State<notification> {
  late String  wood="",glass="",clothe="",plastic="",userid;
  List order=[],nameuser=[],address=[],nameFactor=[],amount=[];
  void getData() async {
    CollectionReference userInfo =FirebaseFirestore.instance.collection('user');
    CollectionReference mat=FirebaseFirestore.instance.collection("recycleable");
  await  mat.get().then((value) {
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
          print(order);
        });
      }));
    }

  }
  void update(int id, int i) async{
    CollectionReference mat=FirebaseFirestore.instance.collection("recycleable");
    CollectionReference orders=FirebaseFirestore.instance.collection("Order");
    if(i==0)
      {
        mat.get().then((value) => value.docs.forEach((element) {
          setState(() {
            print(order);
            print(element.id);
            mat.doc(element.id).update({
              'apply': true
            });
          });
        }));
        orders.get().then((value) => value.docs.forEach((element) {
          setState(() {
            print(order);
            print(element.id);
            orders.doc(element.id).update({
              'apply': true
            });
          });
        }));
      }
    else{
      mat.where('amount',isEqualTo: id).get().then((value) => value.docs.forEach((element) {
        setState(() {
          print(order[i]['iduser']);
          print(element.id);
          mat.doc(element.id).update({
            'apply': true
          });
        });
      }));
      orders.where('amount',isEqualTo: id).get().then((value) => value.docs.forEach((element) {
        setState(() {
          print(order);
          print(element.id);
          orders.doc(element.id).update({
            'apply': true
          });
        });
      }));
    }

}
  void delete(int id,int i) async{
    CollectionReference mat=FirebaseFirestore.instance.collection("recycleable");
    if(i==0)
      {
        mat.where('amount',isEqualTo: id).get().then((value) => value.docs.forEach((element) {
          setState(() {
            print(order);
            print(element.id);
            mat.doc(element.id).delete();
          });
        }));
      }
    mat.where('amount',isEqualTo: id).get().then((value) => value.docs.forEach((element) {
      setState(() {
        print(order[i]['iduser']);
        print(element.id);
        mat.doc(element.id).delete();
      });
    }));
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
                  padding:  EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Container(
                          color: Colors.white,
                          width: width / 3,
                          height: height/9,
                          child: ElevatedButton(
                              onPressed: ()  {
                                 update(order[index]['amount'],index);
                                 order.removeAt(index);
                              },
                              child:Image.asset("image/t.jpg"),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.transparent;
                                  else
                                    return Colors.white;
                                }),
                              ))),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        color: Colors.white,
                        width: width / 3,
                        height: height/9,
                        child: ElevatedButton(
                            onPressed: ()  {
                              delete(order[index]['amount'],index);
                              order.removeAt(index);
                            },
                            child:Image.asset("image/false.jpg"),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.transparent;
                                else
                                  return Colors.white;
                              }),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } )
    );
  }
}