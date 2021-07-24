import 'dart:async';
import 'dart:ui';

import 'package:darurat_app/form_laporan_bantuan.dart';
import 'package:darurat_app/informasi.dart';
import 'package:darurat_app/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:darurat_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isAuth = false;
  @override
  void initState(){
    super.initState();
    startSpashScreen();
    _checkIfLoggedIn();

  }
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  startSpashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      if(isAuth==true){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_){
              return HomePage();
            })
        );
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_){
              return WelcomePage();
            })
        );
      }
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