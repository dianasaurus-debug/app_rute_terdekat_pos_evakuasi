import 'dart:convert';

import 'package:darurat_app/services/laporan-provider.dart';
import 'package:darurat_app/services/laporan-service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:select_form_field/select_form_field.dart';

// Define a custom Form widget.
class LaporanBencanaBPBD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LaporanBencanaBPBDState();
}

class _LaporData {
  String nama = '';
  String tanggal = '';
  String alamat = '';
}

class Bencana {
  const Bencana(this.idBencana, this.nama_bencana);

  final String nama_bencana;
  final int idBencana;
}

// Define a corresponding State class.
// This class holds data related to the form.
class LaporanBencanaBPBDState extends State<LaporanBencanaBPBD> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LaporanBencanaBPBDState>.
  _LaporData _dataLaporanBencanaBPBD = new _LaporData();
  Bencana selectedBencana = const Bencana(1, 'Banjir');
  TextEditingController textController = TextEditingController(text: "Tanggal");
  List<Bencana> dataBencana = <Bencana>[
    const Bencana(1, 'Banjir'),
    const Bencana(2, 'Longsor'),
    const Bencana(3, 'Kekeringan'),
    const Bencana(4, 'Puting Beliung')
  ];

  late Future<List<dynamic>> futureDataLaporan;
  late FirebaseMessaging messaging;


  final _formKey = GlobalKey<FormState>();
  void initState() {
    // TODO: implement initState
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
        Text(event.notification!.title!),
        leading: Icon(Icons.warning_rounded, color : Colors.red),
        subtitle: Text(event.notification!.body!),
        background: Colors.cyan.shade700,
        duration: Duration(seconds: 10),
      );
    });
    messaging.subscribeToTopic("bencana");
    super.initState();
    futureDataLaporan = fetchLaporanBencana();

  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleLaporanBencanaBPBD = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        primary: Color(0xff1f4ea9),
        // background
        onPrimary: Colors.white,
        // foreground
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        elevation: 2,
        shape: StadiumBorder());
    final ButtonStyle stylebuttondelete = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        primary: Colors.redAccent,
        // background
        onPrimary: Colors.white,
        // foreground
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        elevation: 2,
        shape: StadiumBorder());
    final ButtonStyle stylebuttonvalidasi = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        primary: Colors.lightBlueAccent,
        // background
        onPrimary: Colors.white,
        // foreground
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        elevation: 2,
        shape: StadiumBorder());
    // Build a Form widget using the _formKey created above.
    return  Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                title: Text('Laporan Bencana',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Roboto')),
                backgroundColor: Color(0xffffffff),
                ),
            body:
              Container(
                alignment: Alignment.topRight,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<dynamic>>(
                    future: futureDataLaporan,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            padding: EdgeInsets.fromLTRB(20, 10, 40, 20),
                            itemBuilder: (BuildContext context, int index) {
                              return
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text('Laporan Bencana ${snapshot.data![index]['tanggal']}\nNama : ${snapshot.data![index]['pelapor']}\nBencana : ${snapshot.data![index]['bencana']}\nDeskripsi : ${snapshot.data![index]['deskripsi']}\nSTATUS : ${snapshot.data![index]['status']}', style: TextStyle(color: Colors.black, height: 1.2),),
                                      ),
                                    ),
                                    snapshot.data![index]['status']=='MENUNGGU' ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            tolak(snapshot.data![index]['id']);
                                          },
                                          style: stylebuttondelete,
                                          child: Text('HAPUS', style: TextStyle(fontSize: 13)),
                                        ),
                                        const SizedBox(width: 5),
                                        ElevatedButton(
                                          onPressed: () {
                                            validasi(snapshot.data![index]['id']);
                                          },
                                          style: stylebuttonvalidasi,
                                          child: Text('VALIDASI', style: TextStyle(fontSize: 13)),
                                        ),
                                      ],
                                    ) : Text('Tervalidasi!', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
                                  ],
                                );
                            }
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                color: Colors.white,
              ),

            );
  }
  void validasi(id) async {
    var res = await Laporan().validasiLaporan('laporan-bencana/validate/${id}');
    var body = json.decode(res.body);
    if (body['success']) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LaporanBencanaBPBD()), (Route<dynamic> route) => false);
    } else {
      print('gagal');
    }
  }
  void tolak(id) async {
    var res = await Laporan().validasiLaporan('laporan-bencana/reject/${id}');
    var body = json.decode(res.body);
    if (body['success']) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LaporanBencanaBPBD()), (Route<dynamic> route) => false);
    } else {
      print('gagal');
    }
  }
}
