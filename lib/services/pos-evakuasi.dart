import 'dart:convert';

import 'package:http/http.dart' as http;
String baseURL = 'http://192.168.43.204:8000/api/';
//sop_banjir
Future<List<dynamic>> fetchPosEvakuasi() async {
  var result = await http.get(Uri.parse(baseURL+'posko-evakuasi'));
  print(json.decode(result.body)['data']);
  return json.decode(result.body)['data'];
}
