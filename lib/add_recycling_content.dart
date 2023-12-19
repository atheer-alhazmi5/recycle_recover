import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add_recycling_content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return add_recycling_content_state();
  }
}

class add_recycling_content_state extends State<add_recycling_content> {
  // Define variables
  late String imageUrl,
      title = "",
      news = "",
      News_l = "Enter The News or Awareness",
      News_t =
          "Enter The Title of News or Awareness"; // يستخدمها عشان يدل عنصر جديد في القائمة
  bool uploading = false; // Is there an image uploaded or not
  int i = 0;
  late var image = null;
  var downloadurl = "";
  bool N = false, A = false; // to recognize news or awareness
  final picker =
      ImagePicker(); // Used to specify the image to be uploaded to the application

  //Add news to the database
  void addNews() async {
    final _Storage = FirebaseStorage.instance;
    downloadurl =
        await _Storage.ref() // To upload the URL of the possible image
            .child("News/$title")
            .getDownloadURL();
    CollectionReference News =
        FirebaseFirestore.instance.collection("News"); // to news collection
    News.add({
      "title": title,
      "news": news,
      "image": downloadurl
    }); //Adding value to the 3 fields in news collection
  }

//Add Awareness to the database
  void addAwareness() async {
    final _Storage = FirebaseStorage.instance;
    downloadurl =
        await _Storage.ref() // To upload the URL of the possible image
            .child("Awareness/$title")
            .getDownloadURL();
    CollectionReference awareness = FirebaseFirestore.instance
        .collection("Awareness"); // to Awareness collection
    awareness.add({
      "title": title,
      "news": news,
      "image": downloadurl
    }); //Adding value to the 3 fields in Awareness collection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // يسمح بالتمرير العمودي
        child: SafeArea(
          // ما تتداخل الصفحات مع حواف الجهاز
          child: Column(
            // يحطو العناصر داخل عمود اساسي
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // يرتب العناصر و يزبط الفراغات
                padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: image == null
                      ? Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("image/second news.png"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: IconButton(
                                  //
                                  icon: Icon(
                                      Icons.camera_alt), // يعرض زي الكاميرا
                                  iconSize: 37, // حجم الرمز
                                  color: Colors.white, // لون الرمز
                                  onPressed: () {
                                    // زر لمن ينضغط نستدعي دالة لفتح الصور في الجهاز
                                    getImagefromGallery(); // او يعرض صور من الصور
                                  }),
                            ),
                          ],
                        )
                      : Stack(
                          // عشان نحط العناصر فوق بعض
                          children: [
                            Container(
                              // يعرض الصورة المختارة من قبل اليوزر
                              width: double.infinity,
                              height: 250,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image), // عرض الصور المختارة
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt), // رمز الكاميرا
                                iconSize: 37, // حجم الرمز
                                onPressed: () {
                                  setState(() {
                                    getImagefromGallery(); // عند الضغط نروح للصور اللي في الجهاز
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                // نسوي extfield عشان ندخل عنوان الخبر
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    // عشان نحدث المغيرات وتخزين القيمة المدخلة
                    setState(() {
                      title = val; // نخزن القيمة المدخلة في title
                    });
                  },
                  cursorColor: Color(0xff115228),
                  style: TextStyle(
                    color: Color(0xf0115228), // تحديد لون النص
                  ),
                  decoration: InputDecoration(
                      // تصميم للادخال
                      labelStyle: TextStyle(color: Color(0xf0115228)),
                      labelText: News_t,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // شان تكون الكتابة ثابته غير متحركة
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none))), // ازالة الحدود
                  keyboardType:
                      TextInputType.visiblePassword, // حددنا نوع لوحة المفاتيح
                ),
              ),
              Padding(
                // testfield التاني حق الخبر
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  maxLines: null, // عدد غير محدود
                  onChanged: (val) {
                    setState(() {
                      news = val; // تخزين القيمة المدخلة في المغير news
                    });
                  },
                  cursorColor: Color(0xff115228),
                  style: TextStyle(
                    color: Color(0xf0115228),
                  ),
                  decoration: InputDecoration(
                      labelText: News_l,
                      labelStyle: TextStyle(color: Color(0xf0115228)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text("Choose News Or Awareness")),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Row(
                  // شان تكون العناصر افقية
                  children: [
                    Text("News"),
                    Checkbox(
                        value: N,
                        onChanged: (val) {
                          setState(() {
                            N = val!;
                            if (A == true)
                              A = false;
                            else
                              N = val;
                          });
                        }),
                    Text("Awareness"),
                    Checkbox(
                        value: A,
                        onChanged: (val) {
                          setState(() {
                            A = val!;
                            if (N == true)
                              N = false;
                            else
                              A = val;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    // تعديل التنسيق
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 55,
                    margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30.0)), //طراف دائرية
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                                          BorderRadius.circular(30)))),
                      onPressed: () async {
                        // عند الضغط
                        final _Storage = FirebaseStorage.instance;
                        setState(() {
                          uploading = true; // لمن نضغط ح يشتغل التحميل
                        });
                        if (news != "" && title != "") {
                          // نتحقق هذا خبر ولا عنوان
                          if (A == true) {
                            var snapshot = await _Storage.ref()
                                .child("Awareness/${title}")
                                .putFile(image)
                                .whenComplete(() {
                              setState(() {
                                uploading = false; // لمن ينتهي من رفع الصورة
                              });
                            });
                            addAwareness();
                          }
                          if (N == true) {
                            await _Storage.ref()
                                .child("News/$title")
                                .putFile(image)
                                .whenComplete(() {
                              setState(() {
                                uploading = false;
                              });
                              print("uploading Successfully");
                            });
                            addNews();
                          }

                          //    print(news);
                          //   print(title);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Done"),
                                content: Text("uploading Successfully"),
                                actions: [
                                  ElevatedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if (N == true || A == true) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(
                                      "Please Enter A News or Awareness and Select Image"),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content:
                                      Text("Please Choose News or Awareness"),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  )),
            ],
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
      });
    } else
      print("No image Selected");
  }
}
