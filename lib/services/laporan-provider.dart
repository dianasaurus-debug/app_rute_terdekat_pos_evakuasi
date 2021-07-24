import 'dart:convert';

import 'package:http/http.dart' as http;
String baseURL = 'http://tanggap.ngodingcerdas.com/api/';
//sop_banjir
Future<List<dynamic>> fetchLaporanBencana() async {
  var result = await http.get(Uri.parse(baseURL+'laporan-bencana'));
  print(json.decode(result.body)['data']);
  return json.decode(result.body)['data'];
}
Future<List<dynamic>> fetchLaporanBantuan() async {
  var result = await http.get(Uri.parse(baseURL+'laporan-bantuan'));
  print(json.decode(result.body)['data']);
  return json.decode(result.body)['data'];
}
