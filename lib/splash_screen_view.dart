import 'dart:async';
import 'dart:ui';

import 'package:darurat_app/form_laporan_bantuan.dart';
import 'package:darurat_app/informasi.dart';
import 'package:darurat_app/login.dart';
import 'package:darurat_app/register.dart';
import 'package:darurat_app/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:darurat_app/home.dart';

class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState(){
    super.initState();
    startSpashScreen();
  }
  startSpashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_){
          return Laporan();
        })
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child:
          Padding(
            padding: const EdgeInsets.only(left: 30, right:30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                        Image.asset(
                          "images/logo_bojonegoro.png",
                          width: 200.0,
                          height: 200.0,
                        )
                  ],
            ),
          )
      )
    );
  }
}