import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class approval_User extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return approval_User_State();
  }
}

class approval_User_State extends State<approval_User> {
  List users = [];
  Future getData() async {
    CollectionReference user =
        await FirebaseFirestore.instance.collection("user");
    user.get().then((value) {
      value.docs.forEach((element) {
       setState(() {
         users.add(element.data());
       });
      });
    });
  }
  void delete(String id) async
  {
    CollectionReference user =
    await FirebaseFirestore.instance.collection("user");
    await FirebaseFirestore.instance
        .collection('user')
        .where('id' ,isEqualTo: id)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          id = element.get('id');
          print("${element.id}");
          user.doc(element.id).delete();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 1),
          child: IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),)
        ),
        title: Text("Users",
            style: TextStyle(
                color: Color(0xf0115228),
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final item= users[index];
          return FutureBuilder(
            builder:(context, snapshot) {
            return snapshot!=null? Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  print("${users[index]['id']}");
                  delete("${users[index]['id']}");
                  users.removeAt(index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: (){
                    setState(() {
                      delete("${users[index]['username']}");
                    });
                  },
                  tileColor: Colors.teal,
                  title: Text(
                    "username: ${users[index]['username']}\n \nPhone: ${users[index]['phone']}"
                        "\n \nEmail: ${users[index]['email']}"
                        "\n \nAddress: ${users[index]['address']}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ): CircularProgressIndicator(); }
            );
        },
      ),
    );
  }
}
