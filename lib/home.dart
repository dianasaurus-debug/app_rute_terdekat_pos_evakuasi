import 'package:darurat_app/form_laporan_bantuan.dart';
import 'package:darurat_app/form_laporan_bencana.dart';
import 'package:darurat_app/informasi.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: 200.0,
                height: 200.0,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Card(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/logo-evakuasi.png",
                                        width: 70.0,
                                        height: 70.0,
                                      ),
                                      Text('Posko Evakuasi',
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
                            ])),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/logo-rute.png",
                                        width: 70.0,
                                        height: 70.0,
                                      ),
                                      Text('Rute Evakuasi',
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
                              GestureDetector(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => LaporanBantuan());
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
                                            "images/logo-bantuan.png",
                                            width: 70.0,
                                            height: 70.0,
                                          ),
                                          Text('Bantuan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => LaporanBencana());
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
                                            "images/logo-longsor.png",
                                            width: 70.0,
                                            height: 70.0,
                                          ),
                                          Text('Laporan Bencana',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                            "images/logo-info.png",
                                            width: 70.0,
                                            height: 70.0,
                                          ),
                                          Text('Informasi',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
