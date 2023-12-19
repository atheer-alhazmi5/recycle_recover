import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recycle_recover/Natifaction_user.dart';
import 'package:recycle_recover/Order_user.dart';
import 'package:recycle_recover/about%20user.dart';
import 'Getstart_Page.dart';

class account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return account_State();
  }
}

class account_State extends State<account> {
  late String Name = "";
  late int amount = 0, point = 0;
  late String imageUrl = "";
  var downloadUrl;
  late var image = null;
  late var id;
  final picker = ImagePicker();
  bool uploading = false;

  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("$userid");
          Name = element.get('username');
          imageUrl = element.get('image') ?? "";

          print(element.id);
          id = element.id;
        });
      });
    });
    await FirebaseFirestore.instance
        .collection('point')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("$userid");
          bool apply = element.get('apply');
          if (apply == true) point = element.get('point');
          print(point);
        });
      });
    });
  }

  void initState() {
    // getImageurl();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: width * 0.3,
                    right: width * 0.3,
                  ),
                  child: Center(
                    child: imageUrl == ""
                        ? Stack(
                            children: [
                              Container(
                                width: 130.0,
                                height: 130.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("image/img_1.png"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 90),
                                child: IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    iconSize: 37,
                                    onPressed: () {
                                      setState(() {
                                        getImagefromGallery();
                                      });
                                    }),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageUrl),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 90),
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  iconSize: 37,
                                  onPressed: () {
                                    setState(() {
                                      getImagefromGallery();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.3, 0, width * 0.3, height * 0.05),
                  child: Text(
                    "$Name\n ${point}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xf0115228),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Color(0xf0115228),
                        size: width * 0.08,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return aboutMe();
                                }));
                              },
                              child: Text(
                                "About Me",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 115),
                        child: Icon(
                          LineAwesomeIcons.angle_right,
                          color: Color(0xf0115228),
                          size: width * 0.08,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.opacity_rounded,
                        color: Color(0xf0115228),
                        size: width * 0.08,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return order_user();
                                }));
                              },
                              child: Text(
                                "My Order",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 120),
                        child: Icon(
                          LineAwesomeIcons.angle_right,
                          color: Color(0xf0115228),
                          size: width * 0.08,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Color(0xf0115228),
                        size: width * 0.08,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return natifaction_user();
                                }));
                              },
                              child: Text(
                                "Notification",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 95),
                        child: Icon(
                          LineAwesomeIcons.angle_right,
                          color: Color(0xf0115228),
                          size: width * 0.08,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: Container(
                    width: width,
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: width * 0.08,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: width * 0.07),
                            child: TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) {
                                    return get_Start();
                                  }));
                                },
                                child: Text(
                                  "Sign Out",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImagefromGallery() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
        uploading = true;
      });

      final userid = await FirebaseAuth.instance.currentUser!.uid;
      final _Storage = FirebaseStorage.instance.ref().child("User/$userid");

      UploadTask uploadTask = _Storage.putFile(image);

      uploadTask.whenComplete(() async {
        try {
          final url = await _Storage.getDownloadURL();

          setImageUrl(url);
        } catch (onError) {
          print("Error in uploading image $onError");
        }
      });
    } else
      print("No image Selected");
  }

  void setImageUrl(String url) async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) async {
      var data = value.docs.first.data();

      // set image url to user profile
      await value.docs.first.reference.update({'image': url});

      setState(() {
        id = data['id'];
        Name = data['username'];
        point = data['point'];
        imageUrl = url;
      });
    });
  }
}
