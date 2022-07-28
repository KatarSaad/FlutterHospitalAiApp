import 'package:flutter/material.dart';

class Utils {

   static final  GlobalKey<ScaffoldMessengerState>  messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    //final messengerKey = GlobalKey<ScaffoldMessengerState>();

    if (text == null) return;
    final snackBar = SnackBar(

      content: Text(text,style: TextStyle(fontSize: 40),),
      backgroundColor: Colors.red,

    );

      messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
}
