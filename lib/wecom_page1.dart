
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/welcom_page2.dart';

class welcom_page1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return welcom_page1_State();
  }

}
class welcom_page1_State extends State<welcom_page1>
{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //لملائمة جميع الشاشات
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column( // لوضع العناصر في عمود
            children: [
          SafeArea( //لتبدأ الواجهة من تحت شريط الإشعار
            child: Container( //وضعنا الصورة بكونتينر لكي يسهل علينا التحكم بها
              child: Image.asset( // نستطيع إضافة صورة من عدة اماكن هنا استخدمنا هذه الطريقة حيث انشأنا مجلد يحتوي جميع الصور وعرناه ضمن مسار في pusspec.yaml ضمن asset
                "image/What is recycling point.jpg",
                fit: BoxFit.cover, //خاصية للصورة لكي تغطي جميع اجزاء المساحة التي حددناها
              ),
              width: width,
              height: height * 0.5,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),//نضيف مسافة من اليمين واليسار والأسفل والأعلى للنص
              child: Text(
                "          What's \n   Recycling point ?",
                style: TextStyle( // خواص النص
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xf0115228)),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "An application that facilitates users' access to factories to facilitate the recycling process",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black26),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Container(
                width: width / 2,
                height: 50,
                child: ElevatedButton( //اضفنا زر بحيث يقبل اي عنصر كابن مثل  الأيقونات والنصوص وغيرها
                  child: Text(
                    "Next  ->",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle( //خواص النص
                      backgroundColor: MaterialStateProperty.resolveWith((states) { // لون خلفية الزر عند الضغط عليه يصبح فضي وعند التحرير من الضغط يرجع للونه الإفتراضي
                        if (states.contains(MaterialState.pressed))
                          return Colors.black26;
                        else
                          return Color(0xf0115228);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>( //الحواف نجعلها مدورة للزر
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)))),
                  onPressed: ()  { // عند الضغط عليه سننتقل للواجة التالية
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return welcom_page2();
                    }
                    ));
                  },
                )),
          ),
        ])) ;
  }

}