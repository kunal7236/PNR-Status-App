import 'package:flutter/material.dart';

class UiHelper {
 static CustomImage({required String img}){
   return Image.asset('assets/images/$img');
 }
 static CustomText({required String txt}){
   return Text(txt,style: TextStyle(
     fontSize: 15,
     fontWeight: FontWeight.bold,
   ),
   );
 }
}