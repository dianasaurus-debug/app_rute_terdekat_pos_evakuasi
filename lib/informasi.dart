import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Informasi extends StatelessWidget {
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
              SingleChildScrollView(
                  child: DataTable(
                columnSpacing: 10.0,
                columns: const <DataColumn>[
                  DataColumn(
                      label: Text(
                        'No',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      numeric: true),
                  DataColumn(
                    label: Text(
                      'Kecamatan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Desa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nama Posko',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1', textAlign: TextAlign.left)),
                      DataCell(Text('Bojonegoro', textAlign: TextAlign.left)),
                      DataCell(Text('Sukorejo', textAlign: TextAlign.left)),
                      DataCell(
                        Container(
                            width: 170, //SET width
                            child: Text(
                                'RS Umum Daerah Dr.R.Sosodoro Djatikoesoemo',
                                textAlign: TextAlign.left)),
                      )
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2', textAlign: TextAlign.left)),
                      DataCell(Text('Sumberrejo', textAlign: TextAlign.left)),
                      DataCell(Text('Sumberrejo', textAlign: TextAlign.left)),
                      DataCell(
                        Container(
                            width: 170, //SET width
                            child: Text('RS Umum Muhamadiyah Sumberrejo',
                                textAlign: TextAlign.left)),
                      )
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('3', textAlign: TextAlign.left)),
                      DataCell(Text('Padangan', textAlign: TextAlign.left)),
                      DataCell(Text('Ngasinan', textAlign: TextAlign.left)),
                      DataCell(
                        Container(
                            width: 200, //SET width
                            child: Text('RS Umum Daerah Padangan',
                                textAlign: TextAlign.left)),
                      )
                    ],
                  ),
                ],
              )),
              SingleChildScrollView(
                  child: DataTable(
                columnSpacing: 10.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tahun',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    numeric: true
                  ),
                  DataColumn(
                    label: Text(
                      'Desa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Bencana',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('2017')),
                      DataCell(Text('Canganaan')),
                      DataCell(Text('Banjir')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('2017')),
                      DataCell(Text('Kedungprimben')),
                      DataCell(Text('Banjir')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('3')),
                      DataCell(Text('2017')),
                      DataCell(Text('Trejo')),
                      DataCell(Text('Banjir')),
                    ],
                  ),
                ],
              )),
            ])));
  }
}
