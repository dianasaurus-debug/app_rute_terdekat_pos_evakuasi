import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Laporan{
  final String _url = 'http://tanggap.ngodingcerdas.com/api/';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  makeLaporan(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  validasiLaporan(apiUrl) async{
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.put(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }
  getDataBantuan() async {
    var fullUrl = _url + 'bantuan';
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}