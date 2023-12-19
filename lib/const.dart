import 'package:flutter/material.dart';
import 'package:recycle_recover/home_page.dart';

ElevatedButton Button(BuildContext context, String txt, onTap) {
  return ElevatedButton(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed))
            return Colors.black26;
          else
            return Color(0xf0115228);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    child: Text(
      txt,
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return onTap;
      }));
    },
  );
}

TextField constTextfeild(
    String text, IconData icon, bool isPassword, int t, controller) {
  var type;
  if (t == 1)
    type = TextInputType.name;
  else if (t == 2)
    type = TextInputType.emailAddress;
  else if (t == 3)
    type = TextInputType.phone;
  else if (t == 4) type = TextInputType.streetAddress;

  return TextField(
    onChanged: (val) {
      controller =val  ;
    },
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Color(0xff115228),
    style: TextStyle(
      color: Color(0xf0115228),
    ),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Color(0xf0115228),
        ),
        labelText: text,
        labelStyle: TextStyle(color: Color(0xf0115228)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: type,
  );
}

