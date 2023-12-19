import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class newsDelete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return newsDelete_State();
  }
}


class newsDelete_State extends State<newsDelete> {
  List news=[],imageurl=[];
  void getData() async
  {
    CollectionReference News=  await FirebaseFirestore.instance
        .collection('News');
    CollectionReference Awareness=  await FirebaseFirestore.instance
        .collection('Awareness');
    News.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          news.add(element.data());
          imageurl.add(element.get('image'));
          print(imageurl);
        });
      });
    });
    Awareness.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          news.add(element.data());
          imageurl.add(element.get('image'));
          print(imageurl);
        });
      });
    });
  }
  void delete(String id) async
  {
    bool flage=false;
    CollectionReference news =
    await FirebaseFirestore.instance.collection("News");
    CollectionReference Awareness=  await FirebaseFirestore.instance
        .collection('Awareness');
    await FirebaseFirestore.instance
        .collection('News')
        .where('title' ,isEqualTo: id)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print(id);
          flage=true;
          id = element.id;
          print(id);
        });
      });
    });
    await FirebaseFirestore.instance
        .collection('Awareness')
        .where('title' ,isEqualTo: id)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print(id);
          id = element.id;
          flage=false;
          print(id);
        });
      });
    });
    if(flage==true)
      {
        print("${id}");
        news.doc(id).delete();
      }
    else Awareness.doc(id).delete();

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                  EdgeInsets.only(left: width * 0.01, top: height * 0.01),
                  child: Text(
                    "News And Awareness",
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
              for (int i = 0; i <news.length; i++)
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: imageurl[i]==""
                              ?  Image.asset(
                            "image/second news.png",
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          ):
                          Image.network(
                            imageurl[i],
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.01, top: height * 0.01),
                          child: TextButton(
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
                                            "${news[i]['news']}",
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
                              child: Text(
                                "${news[i]['title']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Container(
                        height: 80,
                        child: Center(
                          child: ElevatedButton(
                              onPressed: ()  {
                                delete(news[i]['title']);
                                news.removeAt(i);
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
                      )
                    ],
                  ),
                )

            ],
          ),

        ),
      ),
    );
  }
}