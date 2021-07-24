import 'dart:convert';

import 'package:darurat_app/services/laporan-provider.dart';
import 'package:darurat_app/services/laporan-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:select_form_field/select_form_field.dart';

// Define a custom Form widget.
class LaporanBantuan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LaporanBantuanState();
}

class _LaporData {
  String nama = '';
  String tanggal = '';
  String alamat = '';
  String no_hp = '';
  String keterangan = '';
}

class Bantuan {
  const Bantuan(this.idBantuan, this.type);
  final String type;
  final int idBantuan;

}
class Bencana {
  const Bencana(this.idBencana, this.nama_bencana);

  final String nama_bencana;
  final int idBencana;
}
// Define a corresponding State class.
// This class holds data related to the form.
class LaporanBantuanState extends State<LaporanBantuan> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LaporanBantuanState>.
  _LaporData _dataLaporanBantuan = new _LaporData();
  // Bencana selectedBencana = const Bencana(1, 'Banjir');
  // Bantuan selectedBantuan = const Bantuan(1, 'Banjir');

  TextEditingController textController = TextEditingController(text: "Tanggal");
  List<Bantuan> dataBantuan = <Bantuan>[];
  late Future<List<dynamic>> futureDataLaporan;
  bool _isLoading = false;
  List<Bencana> dataBencana = <Bencana>[
    const Bencana(1, 'Banjir'),
    const Bencana(2, 'Longsor'),
    const Bencana(3, 'Kekeringan'),
    const Bencana(4, 'Puting Beliung')
  ];
  String pelapor = '';
  String deskripsi = '';
  String bencana = '';
  String status = '';
  String nomor_hp = '';
  String tanggal = '';
  int bencana_id = 0;
  int bantuan_id = 0;

  final _formKey = GlobalKey<FormState>();
  void getDataBantuan() async {
    var res = await Laporan().getDataBantuan();
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      for(var i=0;i<body['data'].length;i++){
        setState(() {
          dataBantuan.add(Bantuan(body['data'][i]['id'], body['data'][i]['type']));
        });
      }
    } else {
      print('gagal');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataBantuan();
    futureDataLaporan = fetchLaporanBantuan();
    print(dataBantuan);
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleLaporanBantuan = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9),
      // background
      onPrimary: Colors.white,
      // foreground
      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
      elevation: 2,
        shape: StadiumBorder()
    );
    final ButtonStyle stylebuttondelete = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        primary: Colors.redAccent,
        // background
        onPrimary: Colors.white,
        // foreground
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        elevation: 2,
        shape: StadiumBorder()
    );
    final ButtonStyle stylebuttonvalidasi = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        primary: Colors.lightBlueAccent,
        // background
        onPrimary: Colors.white,
        // foreground
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        elevation: 2,
        shape: StadiumBorder()
    );
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text('Laporan Bantuan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Roboto')),
            backgroundColor: Color(0xffffffff),
            bottom: TabBar(
              tabs: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Daftar Laporan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff1f4ea9),
                            fontFamily: 'Roboto'))),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Buat Laporan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff1f4ea9),
                            fontFamily: 'Roboto'))),
              ],
            )),
        body:
        TabBarView(
          children: [
            Container(
              alignment: Alignment.topRight,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:

              FutureBuilder<List<dynamic>>(
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
                                      child: Text('Laporan Bantuan ${snapshot.data![index]['tanggal']}\nNama : ${snapshot.data![index]['pelapor']}\nBantuan : ${snapshot.data![index]['bantuan']}\nKeterangan : ${snapshot.data![index]['deskripsi']}\nNo. HP : ${snapshot.data![index]['nomor_hp']}\nSTATUS : ${snapshot.data![index]['status']}', style: TextStyle(color: Colors.black, height: 1.2),),
                                    ),
                                  ),
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

          Form(
              key: _formKey,
              child: ListView(padding: const EdgeInsets.all(20), children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text('FORM LAPORAN BANTUAN',
                          style: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: textController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff1f4ea9), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        hintText: 'Tanggal',
                          isDense: true
                      ),
                      onTap: () async {
                        await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2025),
                            helpText: 'Tanggal'
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            textController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                            tanggal = DateFormat('yyyy-MM-dd').format(selectedDate);
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<Bencana>(
                      elevation: 16,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff1f4ea9), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        hintText: 'Pilih bencana',
                          isDense: true
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          if(newValue!=null){
                            bencana_id = newValue.idBencana;
                          }
                        });
                      },
                      items: dataBencana.map((Bencana bencana) {
                        return new DropdownMenuItem<Bencana>(
                          value: bencana,
                          child: new Text(
                            bencana.nama_bencana,
                            style: new TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<Bantuan>(
                      elevation: 16,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff1f4ea9), width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          hintText: 'Pilih bantuan',
                          isDense: true
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          if(newValue!=null){
                            bantuan_id = newValue.idBantuan;
                          }
                        });
                      },
                      items: dataBantuan.map((Bantuan bantuan) {
                        return new DropdownMenuItem<Bantuan>(
                          value: bantuan,
                          child: new Text(
                            bantuan.type,
                            style: new TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff1f4ea9), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        hintText: 'Keterangan',
                          isDense: true
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field tidak boleh kosong';
                        }
                        deskripsi = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Processing Data')));
                          _laporkan();
                        }
                      },
                      style: styleLaporanBantuan,
                      child: Text(_isLoading? 'Loading...' : 'Laporkan'),
                    ),
                  ],
                ),
              ])),
        ])
        )
    );
  }
  void _laporkan() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'pelapor' : pelapor,
      'deskripsi' : deskripsi,
      'bencana' : bencana,
      'status' : status,
      'nomor_hp' : nomor_hp,
      'tanggal' : tanggal,
      'bencana_id' : bencana_id,
      'bantuan_id' : bantuan_id,

    };

    var res = await Laporan().makeLaporan(data, 'laporan-bantuan');
    var body = json.decode(res.body);
    print(data);
    if(body['success']==true){
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => LaporanBantuan()
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pengajuan laporan gagal!!', style: TextStyle(color: Colors.white, fontSize: 20)),

              backgroundColor: Colors.red)
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

}
