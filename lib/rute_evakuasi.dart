import 'dart:async';
import 'dart:convert';

import 'package:darurat_app/pos-evakuasi-service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:darurat_app/lokasi-poskos.dart' as locations;
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RuteEvakuasi extends StatefulWidget {
  @override
  _RuteEvakuasiState createState() => _RuteEvakuasiState();
}

class _RuteEvakuasiState extends State<RuteEvakuasi> {
  final ButtonStyle styleCari = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    primary: Color(0xff1f4ea9), // background
    onPrimary: Colors.white, // foreground
    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      shape: StadiumBorder()
  );
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  final Map<String, Marker> _markers = {};
  late LatLng myPosition;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  final LatLng _center = const LatLng(-7.317463, 111.761466);
  late CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_lat, _lng),
    zoom: 12,
  );

  double _lat = -7.317463;
  double _lng = 111.761466;
  Completer<GoogleMapController> _controller = Completer();

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    _controller.complete(controller);
    setState(() {
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
    });
  }
  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      // final GoogleMapController controller = await _controller.future;
      // final _position = CameraPosition(
      //   target: LatLng(res.latitude!, res.longitude!),
      //   zoom: 12,
      // );
      // controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Rute Evakuasi',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
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

        persistentFooterButtons: [
          Align(
            alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      _locateMe();
                      getDataPosko();
                    },
                    style: styleCari,
                    child: Text('Cari Posko terdekat'),
                  ),
                ),
        ],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Bantuan'),
              icon: Icon(Icons.info_outline_rounded),
            ),
            BottomNavigationBarItem(
              title: Text('Informasi'),
              icon: Icon(Icons.account_circle),
            ),
            BottomNavigationBarItem(
              title: Text('Profil'),
              icon: Icon(Icons.account_circle),
            ),
          ],
        )    );
  }
  void getDataPosko() async {
    var res = await PoskoEvakuasiService().getPosTerdekat({"latitude" : _lat, "longitude" : _lng});
    var body = json.decode(res.body);
    print(body);
    if (body['success']==true) {
      print(body['palingdekat']);
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(double.parse(body['palingdekat'][0]['latitude']), double.parse(body['palingdekat'][0]['longitude'])),
        zoom: 12,
      );
      controller.showMarkerInfoWindow(MarkerId(body['palingdekat'][0]['nama_posko']));
      var titikKoordinat = await PoskoEvakuasiService().getKoordinatPosko(1.875249, 0.845140, 20.196142, 5.094979);
      print(json.decode(titikKoordinat.body));

      final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
      _polylineIdCounter++;
      final PolylineId polylineId = PolylineId(polylineIdVal);

      final Polyline polyline = Polyline(
        polylineId: polylineId,
        consumeTapEvents: true,
        color: Colors.red,
        width: 5,
        points: _createPoints(),
      );

      setState(() {
        _mapPolylines[polylineId] = polyline;
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
    } else {
      print('gagal');
    }
  }
  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(LatLng(1.875249, 0.845140));
    points.add(LatLng(4.851221, 1.715736));
    points.add(LatLng(8.196142, 2.094979));
    points.add(LatLng(12.196142, 3.094979));
    points.add(LatLng(16.196142, 4.094979));
    points.add(LatLng(20.196142, 5.094979));
    return points;
  }

}