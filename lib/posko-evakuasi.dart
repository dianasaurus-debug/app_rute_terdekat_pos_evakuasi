import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:darurat_app/pos-evakuasi-service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:darurat_app/lokasi-poskos.dart' as locations;
import 'package:location/location.dart' as LocationManager;
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:darurat_app/pos-evakuasi-service.dart';
import 'package:overlay_support/overlay_support.dart';

class PoskoEvakuasi extends StatefulWidget {
  @override
  _PoskoEvakuasiState createState() => _PoskoEvakuasiState();
}

class _PoskoEvakuasiState extends State<PoskoEvakuasi> {
  final ButtonStyle styleCari = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9), // background
      onPrimary: Colors.white, // foreground
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      shape: StadiumBorder()
  );
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  late List<dynamic> daftar_rute;
  late List<dynamic> daftar_bencana;

  String vehicle = 'bike';
  final List<LatLng> points = <LatLng>[];
  bool MapNavigated = false;
  final Map<String, Marker> _markers = {};
  late LatLng myPosition;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationManager.Location location = new LocationManager.Location();
  final LatLng _center = const LatLng(-7.317463, 111.761466);
  late CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 12,
  );

  late String posko_terdekat;
  String jarak_posko = '';
  double _lat = -7.317463;
  double _lng = 111.761466;
  Completer<GoogleMapController> _controller = Completer();
  late FirebaseMessaging messaging;

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == LocationManager.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != LocationManager.PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude!, res.longitude!),
        zoom: 12,
      );
      controller.moveCamera(CameraUpdate.newLatLngZoom(LatLng(res.latitude!, res.longitude!), 12));
      //
      // controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _currentPosition = CameraPosition(
          target: LatLng(res.latitude!, res.longitude!),
          zoom: 12,
        );
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
  }
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    final dataBencanaBaru = await PoskoEvakuasiService().getBencanaBaru();
    final decodedDataBencana = json.decode(dataBencanaBaru.body)['data'];
    _controller.complete(controller);
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }
    final Uint8List markerIconPerson = await getBytesFromAsset('images/icon-lokasi-saya.png', 70);
    final Uint8List markerIcon = await getBytesFromAsset('images/warning_pin.png', 50);
    setState(() {
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
      messaging.subscribeToTopic("bencana");

      _markers.clear();
      for (final posko in googleOffices.data) {
        final marker = Marker(
          markerId: MarkerId(posko.nama_posko),
          position: LatLng(posko.latitude, posko.longitude),
          infoWindow: InfoWindow(
            title: posko.nama_posko,
            snippet: posko.alamat,

          ),
        );
        _markers[posko.nama_posko] = marker;
      }
      for (final bencana in decodedDataBencana) {
        final marker = Marker(
          markerId: MarkerId(bencana['id'].toString()),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(double.parse(bencana['latitude']), double.parse(bencana['longitude'])),
          infoWindow: InfoWindow(
            title: '${bencana['bencana']} di ${bencana['desa']}',
            snippet: 'Awas ada ${bencana['bencana']} di desa ${bencana['desa']}',
          ),
        );
        _markers[bencana['id'].toString()] = marker;
      }
      _markers['Lokasi saya'] = Marker(
        icon: BitmapDescriptor.fromBytes(markerIconPerson),
        markerId: MarkerId('Lokasi saya'),
        position: LatLng(_lat, _lng),
        infoWindow: InfoWindow(
          title: 'Lokasi saya',
        ),
      );

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locateMe();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Posko Evakuasi',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Roboto')),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _currentPosition,
        markers: _markers.values.toSet(),
        polylines: Set<Polyline>.of(_mapPolylines.values),
      ),

    );
  }

}