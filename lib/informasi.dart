import 'package:darurat_app/services/pos-evakuasi.dart';
import 'package:darurat_app/services/riwayat-bencana.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Informasi extends StatefulWidget {
  Informasi({Key? key}) : super(key: key);

  @override
  _InformasiState createState() => _InformasiState();
}

class _InformasiState extends State<Informasi> {
  late Future<List<dynamic>> futureRiwayatBencana;
  late Future<List<dynamic>> futurePosEvakuasi;
  var i = 0;

  @override
  void initState() {
    super.initState();
    futureRiwayatBencana = fetchRiwayatBencana();
    futurePosEvakuasi = fetchPosEvakuasi();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Informasi',
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
                        child: Text('POSKO EVAKUASI',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff1f4ea9),
                                fontFamily: 'Roboto'))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('RIWAYAT BENCANA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff1f4ea9),
                                fontFamily: 'Roboto'))),
                  ],
                )),
            body: TabBarView(children: [
              FutureBuilder<List<dynamic>>(
                  future: futurePosEvakuasi,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: DataTable(
                              columnSpacing: 10.0,
                              columns: const <DataColumn>[
                                DataColumn(
                                    label: Text(
                                      'No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    numeric: true),
                                DataColumn(
                                  label: Text(
                                    'Nama Posko',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Alamat',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: snapshot.data.map<DataRow>((e) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(
                                        (snapshot.data.indexOf(e) + 1)
                                            .toString(),
                                        textAlign: TextAlign.left)),
                                    DataCell(Text(e['nama_posko'],
                                        textAlign: TextAlign.left)),
                                    DataCell(
                                      Container(
                                          width: 170, //SET width
                                          child: Text(e['alamat'],
                                              textAlign: TextAlign.left)),
                                    )
                                  ],
                                );
                              }).toList()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              FutureBuilder<List<dynamic>>(
                  future: futureRiwayatBencana,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: DataTable(
                              columnSpacing: 10.0,
                              columns: const <DataColumn>[
                                DataColumn(
                                    label: Text(
                                      'No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    numeric: true),
                                DataColumn(
                                  label: Text(
                                    'Tahun',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Desa',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Bencana',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: snapshot.data.map<DataRow>((e) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(
                                        (snapshot.data.indexOf(e) + 1)
                                            .toString(),
                                        textAlign: TextAlign.left)),
                                    DataCell(Text(e['tahun'].toString(),
                                        textAlign: TextAlign.left)),
                                    DataCell(Text(e['desa'],
                                        textAlign: TextAlign.left)),
                                    DataCell(
                                      Container(
                                          width: 170, //SET width
                                          child: Text(e['bencana'],
                                              textAlign: TextAlign.left)),
                                    )
                                  ],
                                );
                              }).toList()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ])));
  }
}
