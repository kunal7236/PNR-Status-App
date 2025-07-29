
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pnr_status/widget/ui_helper.dart';
import 'searchpage.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> SearchPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child:UiHelper.CustomImage(img: 'splash-train.png'),
        ),
      ),
    );
  }
}