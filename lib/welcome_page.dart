import 'package:darurat_app/login.dart';
import 'package:darurat_app/register.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final ButtonStyle styleRegister = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9), // background
      onPrimary: Colors.white, // foreground
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    );
    final ButtonStyle styleLogin = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      onPrimary: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      side: BorderSide(color: Color(0xff1f4ea9)),
    );
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image.asset(
            "images/logo-welcome.png",
            width: 400.0,
            height: 400.0,
          )),
          Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => Login());
                        Navigator.push(context, route);
                      },
                      style: styleLogin,
                      child: const Text('LOGIN'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: styleRegister,
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => Register());
                        Navigator.push(context, route);
                      },
                      child: const Text('REGISTER'),
                    ),
                  ]))
        ],
      ),
    ));
  }
}
