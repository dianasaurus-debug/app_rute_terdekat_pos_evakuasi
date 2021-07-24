import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'lokasi-posko.g.dart';

@JsonSerializable()
class PoskoEvakuasi {
  PoskoEvakuasi({
    required this.id,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.nama_posko,
  });

  factory PoskoEvakuasi.fromJson(Map<String, dynamic> json) => _$PoskoEvakuasiFromJson(json);
  Map<String, dynamic> toJson() => _$PoskoEvakuasiToJson(this);

  final int id;
  final String alamat;
  final double latitude;
  final double longitude;
  final String nama_posko;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.data,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<PoskoEvakuasi> data;

}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'http://192.168.43.204:8000/api/posko-evakuasi/';

  // Retrieve the locations of Google offices
  final response = await http.get(Uri.parse(googleLocationsURL));
  if (response.statusCode == 200) {
    print(json.encode(response.body));
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}