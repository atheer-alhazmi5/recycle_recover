import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recycle_recover/add_location_factore.dart';
import 'package:recycle_recover/allOrders.dart';
import 'package:recycle_recover/new_request_factor.dart';
import 'Getstart_Page.dart';
import 'about_factore.dart';

class account_Factor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return account_State();
  }
}

class account_State extends State<account_Factor> {
  late String Name = "", bio = "";

  late var image = null;

  final picker = ImagePicker();
  bool uploading = false;
  late var downloadurl, imageUrl = "";
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('factores')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Name = element.get('username');
          bio = element.get('bio');
          imageUrl = element.get('image');
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
                      width * 0.3, height * 0.01, width * 0.3, height * 0.01),
                  child: Text(
                    "$Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xf0115228),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.1, 1, width * 0.1, 1),
                  child: Text(
                    "$bio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
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
                          padding: EdgeInsets.only(left: width * 0.07),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return aboutUs();
                                }));
                              },
                              child: Text(
                                "About Us",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 133),
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
                        Icons.location_on_outlined,
                        color: Color(0xf0115228),
                        size: width * 0.08,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: width * 0.07),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return add_Location();
                                }));
                              },
                              child: Text(
                                "Our Address",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 105),
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
                          padding: EdgeInsets.only(left: width * 0.07),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return new_Req();
                                }));
                              },
                              child: Text(
                                "New Request",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 100),
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
                        Icons.archive_outlined,
                        color: Color(0xf0115228),
                        size: width * 0.08,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: width * 0.07),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return AllOrders();
                                }));
                              },
                              child: Text(
                                "Requests Archive",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: 60),
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
                  padding: EdgeInsets.only(top: height * 0.2),
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
      final _Storage = FirebaseStorage.instance.ref().child("Factor/$userid");

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
        .collection('factores')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) async {
      var data = value.docs.first.data();

      // set image url to user profile
      await value.docs.first.reference.update({'image': url});

      setState(() {
        Name = data['username'];
        imageUrl = url;
      });
    });
  }
}
