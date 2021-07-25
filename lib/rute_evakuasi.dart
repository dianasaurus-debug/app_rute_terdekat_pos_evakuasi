import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:darurat_app/pos-evakuasi-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:darurat_app/lokasi-poskos.dart' as locations;
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';

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
  late List<dynamic> daftar_rute;
  String vehicle = 'bike';
  final List<LatLng> points = <LatLng>[];
  bool MapNavigated = false;
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
  late String posko_terdekat;
  String jarak_posko = '';
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
        actions:
        MapNavigated == true ? <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.car, color: vehicle=='car' ? Colors.blueAccent : Colors.black),
            onPressed: () {
              getDataPosko('car');
            },
          ),
          IconButton(
            icon: Icon(Icons.pedal_bike, color: vehicle=='bike' ? Colors.blueAccent : Colors.black),
            onPressed: () {
              getDataPosko('bike');
            },
          ),
          IconButton(
            icon: Icon(Icons.directions_walk,color: vehicle=='foot' ? Colors.blueAccent : Colors.black),
            onPressed: () {
              getDataPosko('foot');
            },
          ),
        ] : null,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Rute Evakuasi',
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

        persistentFooterButtons: [
          Column(
            children : [
              MapNavigated == true ? Text('\nJarak ${jarak_posko} Km\n', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),) : Text(''),
              Align(
                alignment: Alignment.center,
                child: MapNavigated == false ? ElevatedButton(
                  onPressed: () {
                    _locateMe();
                    getDataPosko('bike');
                  },
                  style: styleCari,
                  child: Text('Cari Posko terdekat'),
                ) : ElevatedButton(
                  onPressed: () {
                    _showTestDialog();
                  },
                  style: styleCari,
                  child: Text('Jelajahi Rute'),
                ),
              ),
            ]
          )
        ],

        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.white,
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.black.withOpacity(.60),
        //   selectedFontSize: 14,
        //   unselectedFontSize: 14,
        //   onTap: (value) {
        //     // Respond to item press.
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //       title: Text('Bantuan'),
        //       icon: Icon(Icons.info_outline_rounded),
        //     ),
        //     BottomNavigationBarItem(
        //       title: Text('Informasi'),
        //       icon: Icon(Icons.account_circle),
        //     ),
        //     BottomNavigationBarItem(
        //       title: Text('Profil'),
        //       icon: Icon(Icons.account_circle),
        //     ),
        //   ],
        // )
    );
  }
  void getDataPosko(jenisKendaraan) async {
    var res = await PoskoEvakuasiService().getPosTerdekat({"latitude" : _lat, "longitude" : _lng});
    var body = json.decode(res.body);
    print(body);
    if (body['success']==true) {
      print(body['palingdekat']);
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(double.parse(body['palingdekat'][0]['latitude']), double.parse(body['palingdekat'][0]['longitude'])),
        zoom: 10,
      );
      // List<Placemark> placemarks = await placemarkFromCoordinates(-7.201024,111.938835);
      // print(placemarks);
      controller.showMarkerInfoWindow(MarkerId(body['palingdekat'][0]['nama_posko']));

      Future<Uint8List> getBytesFromAsset(String path, int width) async {
        ByteData data = await rootBundle.load(path);
        ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
        ui.FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
      }
      final Uint8List markerIcon = await getBytesFromAsset('images/icon-lokasi-saya.png', 100);

      setState(() {
        posko_terdekat = body['palingdekat'][0]['nama_posko'];
        _markers['Lokasi saya'] = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId('Lokasi saya'),
          position: LatLng(-7.201024, 111.938835),
          infoWindow: InfoWindow(
            title: 'Lokasi saya',
          ),
        );
      });
      // controller.showMarkerInfoWindow(MarkerId('Lokasi saya'));

      var titikKoordinat = await PoskoEvakuasiService().getKoordinatPosko(-7.201024,111.938835, double.parse(body['palingdekat'][0]['latitude']), double.parse(body['palingdekat'][0]['longitude']), jenisKendaraan);

      print(_lat);
      print(json.decode(titikKoordinat.body)['paths']);
      var daftarKoordinat = json.decode(titikKoordinat.body)['paths'][0]['points']['coordinates'];
      setState(() {
        jarak_posko = (json.decode(titikKoordinat.body)['paths'][0]['distance']/1000).toStringAsFixed(2);
        daftar_rute = json.decode(titikKoordinat.body)['paths'][0]['instructions'];
        vehicle = jenisKendaraan;
        points.clear();
      });
      for(var koordinat in daftarKoordinat){
        points.add(LatLng(koordinat[1], koordinat[0]));
      }
      print(daftar_rute);
      final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
      _polylineIdCounter++;
      final PolylineId polylineId = PolylineId(polylineIdVal);
      final Polyline polyline = Polyline(
        polylineId: polylineId,
        consumeTapEvents: true,
        color: Colors.green,
        width: 3,
        points: points,
      );

      setState(() {
        MapNavigated = true;
        _mapPolylines[polylineId] = polyline;
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
    } else {
      print('gagal');
    }
  }
  void _showTestDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            title: Center(child: Text("Detail Navigasi Rute")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height - 20,
              width: MediaQuery.of(context).size.width -20,
              child: ListView.builder(
                itemCount: daftar_rute.length,
                itemBuilder: (context, i) {
                  return  ListTile(
                    leading: Image.asset(
                      "images/${detectIcon(daftar_rute[i]['sign'])}",
                      width: 50.0,
                      height: 50.0,
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: 'Langkah ${i+1}\n',
                        style: TextStyle(fontSize: 15, color: Colors.brown),
                        children: <TextSpan>[
                          TextSpan(text: '${daftar_rute[i]['text']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black)),
                        ],
                      ),
                    ),
                  );
                },
              )
            ),
            actions: <Widget>[
              RaisedButton(
                child: new Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xFF121A21),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  String detectIcon(sign){
    var namaIcon = '';
    switch(sign){
      case -7 : namaIcon = 'ic_continue';
      break;
      case -3 : namaIcon = 'sharp_left';
      break;
      case -2 : namaIcon = 'ic_turn_left';
      break;
      case -1 : namaIcon = 'ic_slight_left';
      break;
      case 0 : namaIcon = 'ic_continue';
      break;
      case 1 : namaIcon = 'ic_slight_right';
      break;
      case 2 : namaIcon = 'ic_turn_right';
      break;
      case 3 : namaIcon = 'sharp_right';
      break;
      case 4 : namaIcon = 'ic_arrived';
      break;
      case 6 : namaIcon = 'roundabout';
      break;
      case 7 : namaIcon = 'keep_right';
      break;
    }
    return namaIcon+'.png';

  }

}