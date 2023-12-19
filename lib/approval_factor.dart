import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class approval_Factor extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return approval_Factor_State();
  }

}
class approval_Factor_State extends State<approval_Factor>{
  List factor = [];

  void getData() async {
    CollectionReference user =
    await FirebaseFirestore.instance.collection("factores");
    user.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          factor.add(element.data());
        });
      });
    });
  }
  void delete(String idFactor) async
  {
  late String id;
    CollectionReference user =
    await FirebaseFirestore.instance.collection("factores");
   user.where('id' ,isEqualTo: idFactor)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
           id = element.get('id');
           print("${element.id}");
           user.doc(element.id).delete();
        });
      });
    });
CollectionReference location =await FirebaseFirestore.instance.collection('Location_Factor');
  location.where('id' ,isEqualTo: idFactor)
      .get().then((value) {
    value.docs.forEach((element) {
      setState(() {
        id = element.get('id');
        print("${element.id}");
        location.doc(element.id).delete();
      });
    });
  });

  }

  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 1),
        child:  IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
          Icons.keyboard_backspace,
          color: Colors.black,
        ),)
      ),
      title: Text("Factories",
          style: TextStyle(
              color: Color(0xf0115228),
              fontSize: 30,
              fontWeight: FontWeight.bold)),
    ),
      body: ListView.builder(
        itemCount: factor.length,
        itemBuilder: (context, index) {
          final item= factor[index];
          return FutureBuilder(builder:(context, snapshot) {
            return  Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
               setState(() {
                 print("${factor[index]['id']}");
                 delete("${factor[index]['id']}");
                 factor.removeAt(index);
               });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(

                  tileColor: Colors.teal,
                  title: Text(
                    "username: ${factor[index]['username']}\n \nPhone: ${factor[index]['phone']}"
                        "\n \nEmail: ${factor[index]['email']}"
                        "\n \nAddress: ${factor[index]['address']}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },);
        },
      ),);
  }

}