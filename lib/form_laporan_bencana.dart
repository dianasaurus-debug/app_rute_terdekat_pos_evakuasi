import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:select_form_field/select_form_field.dart';

// Define a custom Form widget.
class LaporanBencana extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LaporanBencanaState();
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
class LaporanBencanaState extends State<LaporanBencana> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LaporanBencanaState>.
  _LaporData _dataLaporanBencana = new _LaporData();
  Bencana selectedBencana = const Bencana(1, 'Banjir');
  TextEditingController textController = TextEditingController(text: "Tanggal");
  List<Bencana> dataBencana = <Bencana>[
    const Bencana(1, 'Banjir'),
    const Bencana(2, 'Longsor'),
    const Bencana(3, 'Kekeringan'),
    const Bencana(4, 'Puting Beliung')
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleLaporanBencana = ElevatedButton.styleFrom(
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
            body: TabBarView(children: [
              Container(
                alignment: Alignment.topRight,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 10, 40, 20),
                  children: [
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
                            child: Text('Laporan Bencana 02 Desember 2020\nNama : Rachmat\nBencana : Tanah Longsor\nAlamat Kejadian : Dander', style: TextStyle(color: Colors.black, height: 1.2),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                              },
                              style: stylebuttondelete,
                              child: Text('HAPUS', style: TextStyle(fontSize: 13)),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {

                              },
                              style: stylebuttonvalidasi,
                              child: Text('VALIDASI', style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
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
                            child: Text('Laporan Bencana 02 Desember 2020\nNama : Rachmat\nBencana : Tanah Longsor\nAlamat Kejadian : Dander', style: TextStyle(color: Colors.black,  height: 1.2),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                              },
                              style: stylebuttondelete,
                              child: Text('HAPUS', style: TextStyle(fontSize: 13)),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {

                              },
                              style: stylebuttonvalidasi,
                              child: Text('VALIDASI', style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
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
                            child: Text('Laporan Bencana 02 Desember 2020\nNama : Rachmat\nBencana : Tanah Longsor\nAlamat Kejadian : Dander', style: TextStyle(color: Colors.black,  height: 1.2),),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                              },
                              style: stylebuttondelete,
                              child: Text('HAPUS', style: TextStyle(fontSize: 13)),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {

                              },
                              style: stylebuttonvalidasi,
                              child: Text('VALIDASI', style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
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
                          child: Text('FORM LAPORAN BENCANA',
                              style: TextStyle(
                                  fontSize: 25, fontFamily: 'Roboto')),
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
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff1f4ea9), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Nama',
                              isDense: true),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        // TextFormField(
                        //   keyboardType: TextInputType.datetime,
                        //   decoration: InputDecoration(
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Colors.lightBlueAccent, width: 2),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Color(0xff1f4ea9), width: 2),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.red, width: 2),
                        //     ),
                        //     focusedErrorBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.red, width: 2),
                        //     ),
                        //     hintText: 'Tanggal',
                        //   ),
                        //   // The validator receives the text that the user has entered.
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Field tidak boleh kosong';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        TextFormField(
                          readOnly: true,
                          controller: textController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff1f4ea9), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Tanggal',
                              isDense: true),
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2025),
                                    helpText: 'Tanggal')
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                textController.text = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
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
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff1f4ea9), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Alamat kejadian',
                              isDense: true),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        DropdownButtonFormField<Bencana>(
                          elevation: 16,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff1f4ea9), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Pilih bencana',
                              isDense: true),
                          onChanged: (newValue) {
                            setState(() {
                              if (newValue != null) {
                                selectedBencana = newValue;
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                          style: styleLaporanBencana,
                          child: Text('Lapor'),
                        ),
                      ],
                    ),
                  ])),
            ])));
  }
}
