import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget{

  static TextStyle boldTextFieldStyle(){

    return const TextStyle(
      
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold ,
      fontFamily: 'Poppins');
      
  }



   static TextStyle LightTextFeildStyle(){

    return const TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.normal ,
      fontFamily: 'Poppins');
  }


   static TextStyle semiBooldTextFieldStyle(){

    return const TextStyle(
      color: Color.fromARGB(255, 31, 154, 255),
      fontSize: 15.0,
      fontWeight: FontWeight.bold ,
      fontFamily: 'Poppins');
  }

}