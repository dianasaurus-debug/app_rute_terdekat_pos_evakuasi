import 'package:darurat_app/home.dart';
import 'package:darurat_app/login.dart';
import 'package:darurat_app/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Define a custom Form widget.
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'Models/User.dart';

// Future<User> signUp(String name, String username, String email, String address, String phone, String password) async {
//   final response = await http.post(
//     Uri.parse('http://192.168.43.204:8000/api/auth/signup'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'X-Requested-With': 'XMLHttpRequest',
//     },
//     body: jsonEncode(<String, String>{
//       'name': name,
//       'username': username,
//       'address': address,
//       'phone': phone,
//       'password': password,
//       'email': email,
//     }),
//   );
//
//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Gagal daftar');
//   }
// }

class RegisterBPBD extends StatefulWidget {
  @override
  RegisterBPBDState createState() {
    return RegisterBPBDState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class RegisterBPBDState extends State<RegisterBPBD> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<RegisterBPBDState>.
  bool _isLoading = false;

  late final String nip;
  late final String username;
  late final String email;
  late final String password;


  // Future<User>? _futureUser;
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle styleRegister = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    primary: Color(0xff1f4ea9), // background
    onPrimary: Colors.white, // foreground
    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
  );
  final ButtonStyle styleSukses = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9),
      // background
      onPrimary: Colors.white,
      // foreground
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      elevation: 2,
      shape: StadiumBorder()
  );
  final ButtonStyle styleGagal = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Colors.redAccent,
      // background
      onPrimary: Colors.white,
      // foreground
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      elevation: 2,
      shape: StadiumBorder()
  );
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Register',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Roboto')),
          backgroundColor: Color(0xff1f4ea9),
        ),
        body:
        SingleChildScrollView (
            child: buildForm()
        )

    );
  }
  Form buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text('Register', style: TextStyle(fontSize: 28, fontFamily: 'Roboto'),),
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff1f4ea9), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: 'NIP',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  nip = value;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff1f4ea9), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: 'E-Mail',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  email = value;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff1f4ea9), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: 'Username',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  username = value;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff1f4ea9), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: 'Password',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  password = value;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {

                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
                style: styleRegister,
                child: Text('Register'),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text('Sudah punya akun? Login', style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),),
              ),
            ],
          ),
        )
    );
  }
  showError() async {
    await Future.delayed(Duration(microseconds: 1));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Register Gagal"),
            actions: [
              ElevatedButton(
                style: styleGagal,
                child: Text("Tutup"),
                onPressed:  () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        });
  }
  // startTime() async {
  //   var duration = new Duration(seconds: 6);
  //   return new Timer(duration, route);
  // }
  // route() {
  //   Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) => Login()
  //   )
  //   );
  // }
  showSuccess() async {
    await Future.delayed(Duration(microseconds: 1));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sukses"),
            content: Text("Daftar sukses"),
            actions: [
              ElevatedButton(
                style: styleSukses,
                child: Text("Login"),
                onPressed:  () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
              ElevatedButton(
                style: styleGagal,
                child: Text(_isLoading? 'Loading...' : 'Daftar'),
                onPressed:  () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              )
            ],
          );
        });
  }
  // FutureBuilder<User> buildFutureBuilder() {
  //   return FutureBuilder<User>(
  //     future: _futureUser,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         showSuccess();
  //         return buildForm();
  //       } else if (snapshot.hasError) {
  //         showError();
  //         return buildForm();
  //       }
  //       return
  //         Column(
  //           mainAxisAlignment : MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [CircularProgressIndicator()]);
  //     },
  //   );
  // }
  void _register()async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password': password,
      'username': username,
      'nip' : nip
    };

    var res = await Network().authData(data, 'bpbd-auth/signup');
    var body = json.decode(res.body);
    if(body['success']==true){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']['token']));
      localStorage.setString('bpbd', json.encode(body['bpbd']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomePage()
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Daftar gagal!!', style: TextStyle(color: Colors.white, fontSize: 20)),

              backgroundColor: Colors.red)
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
