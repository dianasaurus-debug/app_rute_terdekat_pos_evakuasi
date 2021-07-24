import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PoskoEvakuasiService{
  final String _url = 'http://192.168.43.204:8000/api/';
  final String _APIURL = 'https://api.openrouteservice.org /v2/directions/driving-car?api_key = 5b3ce3597851110001cf6248e62092923e184788ab51af799d5132c3&start = 8.681495,49.41461&end=8.687872,49.420318';

  getPosTerdekat(data) async{
    var fullUrl = _url + 'posko-evakuasi/terdekat';
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
    );
  }
  getKoordinatPosko(lat_awal, lng_awal, lat_akhir, lng_akhir) async{
    var fullUrl = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248e62092923e184788ab51af799d5132c3&start=${lat_awal},${lng_awal}&end=${lat_akhir},${lng_akhir}';
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}