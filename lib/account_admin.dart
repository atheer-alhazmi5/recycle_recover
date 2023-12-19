import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recycle_recover/about%20user.dart';
import 'package:recycle_recover/add_recycling_content.dart';
import 'package:recycle_recover/approval_factor.dart';
import 'package:recycle_recover/approval_user.dart';
import 'package:recycle_recover/delete_News.dart';
import 'package:recycle_recover/notification_admin.dart';
import 'Getstart_Page.dart';
import 'about_admin.dart';

class account_admin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return account_admin_State();
  }
}

class account_admin_State extends State<account_admin> {
  late String Name = "";
  late String imageUrl = "";
  late var image = null;
  late var downloadUrl;
  final picker = ImagePicker();
  bool uploading = false;
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('admin')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Name = element.get('username');
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
                      width * 0.3, height * 0.01, width * 0.3, height * 0.1),
                  child: Text(
                    "$Name",
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
                                  return aboutAdmin();
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
                                  return notification();
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xf0115228),
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.perm_contact_calendar),
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return add_recycling_content();
                  }));
                },
              ),
              label: "Add News"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return newsDelete();
                  }));
                },
              ),
              label: "Delete News"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return approval_Factor();
                  }));
                },
                icon: Icon(Icons.pattern_sharp),
              ),
              label: "Factories"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return approval_User();
                  }));
                },
                icon: Icon(Icons.add_moderator_outlined),
              ),
              label: "Users"),
        ],
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
      final _Storage = FirebaseStorage.instance.ref().child("Admin/$userid");

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
        .collection('admin')
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
