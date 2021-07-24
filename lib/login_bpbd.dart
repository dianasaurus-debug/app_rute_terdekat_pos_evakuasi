import 'dart:convert';

import 'package:darurat_app/home.dart';
import 'package:darurat_app/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Define a custom Form widget.
class LoginBPBD extends StatefulWidget {
  @override
  LoginBPBDState createState() {
    return LoginBPBDState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginBPBDState extends State<LoginBPBD> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LoginState>.
  var email;
  var password;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleLogin = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9), // background
      onPrimary: Colors.white, // foreground
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    );
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Roboto')),
          backgroundColor: Color(0xff1f4ea9),
        ),
        body:
        SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text('Login', style: TextStyle(fontSize: 28, fontFamily: 'Roboto'),),
                      ),
                      const SizedBox(height: 25),
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
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            _login();
                          }
                        },
                        style: styleLogin,
                        child: Text(_isLoading? 'Loading...' : 'Login',),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Belum punya akun? Register', style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),),
                      ),
                    ],
                  ),
                )
            )
        )

    );
  }
  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };

    var res = await Network().authData(data, 'bpbd-auth/login');
    var body = json.decode(res.body);
    if(body['success']){
      print(body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('bpbd', json.encode(body['bpbd']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomePage()
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal!!', style: TextStyle(color: Colors.white, fontSize: 20)),

              backgroundColor: Colors.red)
      );
    }

    setState(() {
      _isLoading = false;
    });

  }
}
