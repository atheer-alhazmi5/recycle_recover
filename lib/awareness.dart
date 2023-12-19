import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/News.dart';

class awareness extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return awareness_State();
  }
}

class awareness_State extends State<awareness> {
  List awareness = [],imageurl=[]; // قائمتين ، كلهم فاضيين في البداية

  void getData() async { // ميثود اسمها getData جبلي البيانات من
    CollectionReference News =
        await FirebaseFirestore.instance.collection('Awareness');
    News.get().then((value) {
      value.docs.forEach((element) { // يضيف البيانات على القائمتين
        setState(() {
          awareness.add(element.data());
          imageurl.add(element.get('image'));
          print(imageurl);
        });
      });
    });
  }

  void initState() { // يهيئ الصفحة و يحدث حالتها بناء على البيانات اللي حصلنا عليها
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.01, top: height * 0.02),
                    child: Text(
                      "Awareness",
                      style: TextStyle(
                          color: Color(0xf0115228),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.01, top: height * 0.02),
                    child: Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                for (int i = 0; i < awareness.length; i++)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.02),
                          child:imageurl[i]==""
                              ?  Image.asset( // نتأكد هل يوجد صورة للعنصر الحالي
                            "image/second news.png", // ذا مافي يحط صورة من ملف Asset
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          ): Image.network( // لو حط عندي رابط ، تشتغل صورة من الانترنت
                            imageurl[i],
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          )
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.01, top: height * 0.01),
                            child: TextButton( // زر يعرض تفاصيل العنصر الحالي الموجود في قائمة awarness
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return Scaffold(
                                      body: SafeArea(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 60),
                                            child: Text(
                                              "${awareness[i]['news']}", // يعرض الخبر (الخبر النص )
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                                },
                                child: Text( //
                                  "${awareness[i]['title']}", // يجيب العنوان حق الخبر
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  )
              ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xf0115228),
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.near_me_outlined),
                onPressed: () {},
              ),
              label: "Awareness"),
          BottomNavigationBarItem(

              icon: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return news();
                  }));
                },
                icon: Icon(Icons.newspaper),
              ),
              label: "News"),

        ],
      ),
    );
  }
}
