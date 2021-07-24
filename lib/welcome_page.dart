import 'package:darurat_app/login.dart';
import 'package:darurat_app/login_bpbd.dart';
import 'package:darurat_app/register.dart';
import 'package:darurat_app/register_bpbd.dart';
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
    return DefaultTabController(
        length: 2,
        child:
        Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.black, fontFamily: 'Roboto')),
            backgroundColor: Color(0xffffffff),
            bottom: TabBar(
              tabs: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('BPBD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff1f4ea9),
                            fontFamily: 'Roboto'))),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('User',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff1f4ea9),
                            fontFamily: 'Roboto'))),
              ],
            )),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Masuk Sebagai BPBD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff1f4ea9),
                      fontFamily: 'Roboto')),
              const SizedBox(height: 10),
              Container(
                  child: Image.asset(
                "images/logo-welcome.png",
                width: 200.0,
                height: 200.0,
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
                                builder: (context) => LoginBPBD());
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
                                builder: (context) => RegisterBPBD());
                            Navigator.push(context, route);
                          },
                          child: const Text('REGISTER'),
                        ),
                      ]))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Masuk Sebagai User',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff1f4ea9),
                      fontFamily: 'Roboto')),
              const SizedBox(height: 10),
              Container(
                  child: Image.asset(
                    "images/logo-welcome.png",
                    width: 200.0,
                    height: 200.0,
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
        ]))
    );
  }
}
