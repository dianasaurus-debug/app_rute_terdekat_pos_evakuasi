import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:select_form_field/select_form_field.dart';

// Define a custom Form widget.
class Laporan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LaporanState();
}

class _LaporData {
  String nama = '';
  String tanggal = '';
  String alamat = '';
  String no_hp = '';
  String keterangan = '';
}

class Bencana {
  const Bencana(this.idBencana, this.nama_bencana);
  final String nama_bencana;
  final int idBencana;

}
// Define a corresponding State class.
// This class holds data related to the form.
class LaporanState extends State<Laporan> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LaporanState>.
  _LaporData _datalaporan = new _LaporData();
  Bencana selectedBencana = const Bencana(1, 'Banjir');
  TextEditingController textController = TextEditingController(text: "Tanggal");
  List<Bencana> dataBencana = <Bencana>[const Bencana(1,'Banjir'), const Bencana(2,'Longsor'), const Bencana(3,'Kekeringan'),const Bencana(4,'Puting Beliung')];


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleLaporan = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9),
      // background
      onPrimary: Colors.white,
      // foreground
      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
      elevation: 2,
    );
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Laporan Bantuan',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto')),
          backgroundColor: Colors.white,
        ),
        body: Form(
            key: _formKey,
            child: ListView(padding: const EdgeInsets.all(20), children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text('FORM LAPORAN BANTUAN',
                        style: TextStyle(fontSize: 25, fontFamily: 'Roboto')),
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
                      hintText: 'Nama',
                    ),
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
                      hintText: 'Alamat',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                      hintText: 'No Handphone',
                    ),
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
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        if(newValue!=null){
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
                      hintText: 'Alamat',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field tidak boleh kosong';
                      }
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    style: styleLaporan,
                    child: Text('Lapor'),
                  ),
                ],
              ),
            ])));
  }
}
