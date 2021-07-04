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
              DataTable(
            columnSpacing: 10.0,
            columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'No',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Kecamatan',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Desa',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nama Posko',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('Mohit')),
                      DataCell(Text('23')),
                      DataCell(Text('Associate Software Developer')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('Akshay')),
                      DataCell(Text('25')),
                      DataCell(Text('Software Developer')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('3')),
                      DataCell(Text('Deepak')),
                      DataCell(Text('29')),
                      DataCell(Text('Team Lead ')),
                    ],
                  ),
                ],
              ),
              DataTable(
                columnSpacing: 10.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'No',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Kecamatan',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Desa',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nama Posko',
                      style: TextStyle(fontWeight : FontWeight.bold),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('Mohit')),
                      DataCell(Text('23')),
                      DataCell(Text('Associate Software Developer')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('Akshay')),
                      DataCell(Text('25')),
                      DataCell(Text('Software Developer')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('3')),
                      DataCell(Text('Deepak')),
                      DataCell(Text('29')),
                      DataCell(Text('Team Lead ')),
                    ],
                  ),
                ],
              ),
            ])));
  }
}
