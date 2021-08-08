// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lokasi-poskos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoskoEvakuasi _$PoskoEvakuasiFromJson(Map<String, dynamic> json) {
  return PoskoEvakuasi(
    id: (json['id'] as num).toInt(),
    alamat: json['alamat'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    nama_posko: json['nama_posko'] as String,
  );
}

Map<String, dynamic> _$PoskoEvakuasiToJson(PoskoEvakuasi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alamat': instance.alamat,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'nama_posko': instance.nama_posko,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    data: (json['data'] as List<dynamic>)
        .map((e) => PoskoEvakuasi.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
  'data': instance.data,
};
