import 'dart:convert';

import 'package:darurat_app/form_laporan_bantuan.dart';
import 'package:darurat_app/form_laporan_bencana.dart';
import 'package:darurat_app/informasi.dart';
import 'package:darurat_app/laporan-bantuan-bpbd.dart';
import 'package:darurat_app/laporan-bencana-bpbd.dart';
import 'package:darurat_app/profil_bpbd.dart';
import 'package:darurat_app/profile.dart';
import 'package:darurat_app/rute_alternatif.dart';
import 'package:darurat_app/rute_evakuasi.dart';
import 'package:darurat_app/services/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name;
  late String username;
  late String email;
  late String password;
  late String phone;
  late String address;

  late bool isBPBD = false;
  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user') != null ? jsonDecode(localStorage.getString('user')) : '';
    var bpbd = localStorage.getString('bpbd') != null ? jsonDecode(localStorage.getString('bpbd')) : '';
    print(bpbd);
    print(user);
    if (user != '') {
      print('user');
      setState(() {
        name = user['name'];
        isBPBD = false;
      });
    } else if(bpbd !=''){
      print('bpbd');
      setState(() {
        name = bpbd['username'];
        isBPBD = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
              padding : EdgeInsets.only(right: 20),
              child :
                  Row(
                    children:[
                      IconButton(icon: Icon(Icons.account_circle, color: Colors.blue,size: 35,), onPressed: () {
                        if(isBPBD==true){
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ProfilPageBPBD()
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ProfilePage()
                            ),
                          );
                        }

                      }),
                      IconButton(icon: Icon(Icons.exit_to_app, color: Colors.red,size: 35), onPressed: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      }),
                    ]
                  )
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    "images/logo_bojonegoro.png",
                    width: 150.0,
                    height: 150.0,
                  )),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (context) =>
                                              RuteAlternatif());
                                      Navigator.push(context, route);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SizedBox(
                                        width: 130,
                                        height: 120,
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "images/logo-jalan.png",
                                              width: 70.0,
                                              height: 70.0,
                                            ),
                                            Text('Rute Alternatif',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontFamily: 'Open Sans'))
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) =>
                                                RuteEvakuasi());
                                        Navigator.push(context, route);
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: 130,
                                          height: 120,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/logo-evakuasi.png",
                                                width: 70.0,
                                                height: 70.0,
                                              ),
                                              Text('Posko Evakuasi',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontFamily: 'Open Sans'))
                                            ],
                                          )),
                                        ),
                                      )),
                                ])),
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) =>
                                                RuteEvakuasi());
                                        Navigator.push(context, route);
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: 130,
                                          height: 120,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/logo-rute.png",
                                                width: 70.0,
                                                height: 70.0,
                                              ),
                                              Text('Rute Evakuasi',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontFamily: 'Open Sans'))
                                            ],
                                          )),
                                        ),
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        if(isBPBD==true){
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  LaporanBantuanBPBD());
                                          Navigator.push(context, route);
                                        } else {
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  LaporanBantuan());
                                          Navigator.push(context, route);
                                        }
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: 130,
                                          height: 120,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/logo-bantuan.png",
                                                width: 70.0,
                                                height: 70.0,
                                              ),
                                              Text('Bantuan',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontFamily: 'Open Sans'))
                                            ],
                                          )),
                                        ),
                                      )),
                                ])),
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        print(isBPBD);
                                        if(isBPBD==true){
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  LaporanBencanaBPBD());
                                          Navigator.push(context, route);
                                        } else if(isBPBD==false) {
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  LaporanBencana());
                                          Navigator.push(context, route);
                                        }
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: 130,
                                          height: 120,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/logo-longsor.png",
                                                width: 70.0,
                                                height: 70.0,
                                              ),
                                              Text('Laporan Bencana',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontFamily: 'Open Sans'))
                                            ],
                                          )),
                                        ),
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) => Informasi());
                                        Navigator.push(context, route);
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: 130,
                                          height: 120,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "images/logo-info.png",
                                                width: 70.0,
                                                height: 70.0,
                                              ),
                                              Text('Informasi',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontFamily: 'Open Sans'))
                                            ],
                                          )),
                                        ),
                                      )),
                                ]))
                      ]))
            ],
          ),
        ));
  }

}
