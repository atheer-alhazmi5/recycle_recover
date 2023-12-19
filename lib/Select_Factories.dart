import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'Complete.dart';
import 'package:flutter/services.dart';
import 'package:recycle_recover/Location_user.dart';
class Select_Factories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Select_Factories_State();
  }
}

class Select_Factories_State extends State<Select_Factories> {
  late String address = "";

  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          address = element.data()['address'];
        });
      });
    });
  }

  void initState() {

    getData();
    getnamefactor();
    getMat();
   // selectItem=name[0];
    super.initState();
  }

  var today = DateTime.now();
  DateTime now = DateTime.now();
  late List<String> nameFactor = ["nm","mjk"];
  String formattedDate =
  DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
  late double wood = 1.0,
      glass = 1.0,
      clothes = 1.0,
      plastic = 1.0;
  late int point = 0,
      amount;
  String? selectItem= "Select Factor";
  late String w = "",
      g = "",
      c = "",
      p = "",
      am,
      idFactor;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
List<String> name =[""];
  void getnamefactor() async
  {
    CollectionReference nameFactor = await FirebaseFirestore.instance
        .collection('factores');
   await nameFactor.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("${element.get('username')}");
          name.add("${element.get('username')}");
         // nameFactor.add(name);
        });
      });
    });
  }

  void getMat() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('material')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          wood = element.get('wood');
          plastic = element.get('plastic');
          glass = element.get('glass');
          clothes = element.get('clothes');
          print("$wood $clothes $plastic $glass");
          if (wood != 1.0) w = "Wood";
          if (plastic != 1.0) p = "Plastic";
          if (clothes != 1.0) c = "Clothes";
          if (glass != 1.0) g = "Glass";
          print("${element.id}");
          FirebaseFirestore.instance
              .collection('material')
              .doc("${element.id}")
              .delete();
        });
      });
    });
  }

  void addData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('recycleable').add({
      'material': [
        w,
        p,
        c,
        g,
      ],
      'iduser': userid,
      "amount": amount,
      "namefactor": selectItem,
      "apply" :false
    });
    await FirebaseFirestore.instance.collection('Order').add({
      'material': [
        w,
        p,
        c,
        g,
      ],
      'iduser': userid,
      "amount": amount,
      "namefactor": selectItem,
      "apply" :false,
      "applyfactor" :false
    });
  }

  void addPoint() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Order')
        .where('iduser', isEqualTo: userid)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          amount = element.get('amount') + amount;
          print("${element.get('amount')}");
        });
      });
    });
    await FirebaseFirestore.instance
        .collection('point').doc(userid).set({
      'id': userid,
      'point': amount * 20,
      'apply':false

    });
  }

  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Scheduling",
          style: TextStyle(
              color: Color(0xf0115228),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 1),
          child:  IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, top: height * 0.02),
              child: Text("Scheduling the recycling process",textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xf0115228),
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, top: height * 0.03),
              child: Text("Information about recycling process",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  )),
            ),
            Padding(
                padding:
                EdgeInsets.only(left: width * 0.05, top: height * 0.01),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Select Factory",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                    PopupMenuButton<String>(
                      initialValue:selectItem,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        for(int i=0;i< name.length;i++)
                        PopupMenuItem<String>(
                          value: '${name[i]}',
                          child: Text('${name[i]}'),
                        ),
                      ],
                      onSelected: (String value) {
                       setState(() {
                         selectItem =value;
                         print(selectItem);
                       });
                      },
                    ),
                    Text("$selectItem")
                  ],
                )),
            Padding(
                padding:
                EdgeInsets.only(left: width * 0.05, top: height * 0.01),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Address",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                    SizedBox(
                      width: 36,
                    ),
                    Container(
                        width: width * 0.5,
                        height: height * 0.07,
                        child: TextField(
                          obscureText: false,
                          enableSuggestions: true,
                          autocorrect: true,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              labelText: "$address",
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 4, style: BorderStyle.none))),
                          keyboardType: TextInputType.text,
                        )),
                  ],
                )),
            ElevatedButton(
                child: Text(
                  "Show The Map",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
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
                            borderRadius:
                            BorderRadius.circular(20)))),
                onPressed: () {
                  if (selectItem != null) {
                    addData();
                    addPoint();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return location();
                    }));
                  }
                }),

            Padding(
                padding:
                EdgeInsets.only(left: width * 0.05, top: height * 0.01),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Amount",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    Container(
                        width: width * 0.5,
                        height: height * 0.07,
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              am = val;
                              amount = int.parse(am);
                            });
                          },
                          obscureText: false,
                          enableSuggestions: true,
                          autocorrect: true,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 4, style: BorderStyle.none))),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          keyboardType: TextInputType.number,
                        )),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: width * 0.8,
                height: height * 0.35,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010),
                  lastDay: DateTime.utc(2040),
                  focusedDay: today,
                  rowHeight: height * 0.04,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                  onDaySelected: _onDaySelected,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: width * 0.1),
                child: Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  child: ElevatedButton(
                      child: Text(
                        "Send",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
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
                                  borderRadius:
                                  BorderRadius.circular(20)))),
                      onPressed: () {
                        if (selectItem != null) {
                          addData();
                          addPoint();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return Complete();
                          }));
                        }
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
