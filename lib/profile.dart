import 'dart:convert';

import 'package:darurat_app/services/auth-service.dart';
import 'package:darurat_app/welcome_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = 'init';
  late String username = 'init';
  late String email = 'init';
  late String password = 'init';
  late String phone = 'init';
  late String address = 'init';
  late String nip = 'init';

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
  late FirebaseMessaging messaging;

  @override
  void initState() {
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
    super.initState();
    _loadUserData();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user') != null ? jsonDecode(localStorage.getString('user')) : '';
    var bpbd = localStorage.getString('bpbd') != null ? jsonDecode(localStorage.getString('bpbd')) : '';

    if(user != null) {
      setState(() {
          name = user['name'];
          username = user['username'];
          email = user['email'];
          password = user['password'];
          phone = user['phone'];
          address = user['address'];
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Profil',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Roboto')),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child:
            Align(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png')
                ),
                  const SizedBox(height: 15),
                  Text('Hai, $name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto')),
                  const SizedBox(height: 15),
                  Text('E-Mail : $email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto')),
                  const SizedBox(height: 15),
                  Text('Nomor HP : $phone',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto')),
                  const SizedBox(height: 15),
                  Text('Alamat : $address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto')),
                  const SizedBox(height: 15),
                  Text('Username : $username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto')),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: styleGagal,
                    child: Text("Logout"),
                    onPressed:  () {
                      logout();
                    },
                  )

                ],
              ),
              alignment: Alignment.center,
            )
      ),
    );
  }
  void logout() async {
    var res = await Network().getData('auth/logout');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => WelcomePage()), (Route<dynamic> route) => false);
    } else {
      print('gagal');
    }
  }

}