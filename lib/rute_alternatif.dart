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
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:geocoding/geocoding.dart';

class RuteAlternatif extends StatefulWidget {
  @override
  _RuteAlternatifState createState() => _RuteAlternatifState();
}

class _RuteAlternatifState extends State<RuteAlternatif> {
  static const api_key='AIzaSyBNDLzwdE1ge5XQPBWyxJEBPFnNEkvWcf8';
  final ButtonStyle styleCari = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      primary: Color(0xff1f4ea9),
      // background
      onPrimary: Colors.white,
      // foreground
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      shape: StadiumBorder());
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String posko_dicari = '';
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  late List<dynamic> daftar_rute;
  late List<dynamic> daftar_lokasi;
  dynamic recentLocation;
  String vehicle = 'bike';
  final List<LatLng> points = <LatLng>[];
  bool MapNavigated = false;
  final Map<String, Marker> _markers = {};
  late LatLng myPosition;
  LocationManager.Location location = new LocationManager.Location();
  late bool _serviceEnabled;
  late LocationManager.PermissionStatus _permissionGranted;
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

    final Uint8List markerIcon = await getBytesFromAsset('images/icon-lokasi-saya.png', 50);
    final Uint8List markerIconWarning = await getBytesFromAsset('images/warning_pin.png', 50);


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
      _markers['Lokasi saya'] = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId('Lokasi saya'),
        position: LatLng(_lat, _lng),
        infoWindow: InfoWindow(
          title: 'Lokasi saya',
        ),
      );
      for (final bencana in decodedDataBencana) {
        final marker = Marker(
          markerId: MarkerId(bencana['id'].toString()),
          icon: BitmapDescriptor.fromBytes(markerIconWarning),
          position: LatLng(double.parse(bencana['latitude']), double.parse(bencana['longitude'])),
          infoWindow: InfoWindow(
            title: '${bencana['bencana']} di ${bencana['desa']}',
            snippet: 'Awas ada ${bencana['bencana']} di desa ${bencana['desa']}',
          ),
        );
        _markers[bencana['id'].toString()] = marker;
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
    if (_permissionGranted == LocationManager.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != LocationManager.PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      controller.moveCamera(CameraUpdate.newLatLngZoom(LatLng(res.latitude!, res.longitude!), 12));
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

  @override
  void initState() {
    _locateMe();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: MapNavigated == true
            ? <Widget>[
                IconButton(
                  icon: Icon(CupertinoIcons.car,
                      color:
                          vehicle == 'car' ? Colors.blueAccent : Colors.black),
                  onPressed: () {
                    getDataPosko('car', recentLocation);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pedal_bike,
                      color:
                          vehicle == 'bike' ? Colors.blueAccent : Colors.black),
                  onPressed: () {
                    getDataPosko('bike', recentLocation);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.directions_walk,
                      color:
                          vehicle == 'foot' ? Colors.blueAccent : Colors.black),
                  onPressed: () {
                    getDataPosko('foot', recentLocation);
                  },
                ),
              ]
            : null,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Rute Alternatif',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Roboto')),
        backgroundColor: Colors.white,
      ),
      body:
               GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _currentPosition,
                markers: _markers.values.toSet(),
                polylines: Set<Polyline>.of(_mapPolylines.values),
              ),


      persistentFooterButtons: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                    isDense: true,                      // Added this
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1f4ea9), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    hintText: 'Masukkan Posko Tujuan Anda',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field tidak boleh kosong';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        setState(() {
                          posko_dicari = value;
                        });
                      }
                    });
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                getDaftarPosko();
              },
              iconSize: 35,
            ),
            MapNavigated == true ?
            ElevatedButton(
              onPressed: () {
                _showTestDialog();
              },
              child: Text('Jelajahi', style : TextStyle(fontSize: 13)),
            ) : Text(''),
          ],
        )
      ],

    );
  }
  void getDaftarPosko() async{
    print(posko_dicari);
    var res = await PoskoEvakuasiService().getDesiredPosko(posko_dicari);
    var body = json.decode(res.body);
    if(body!=null){
      setState(() {
        daftar_lokasi = body['hits'];
      });
      _showResultDialog();
    }
  }
  void getDataPosko(jenisKendaraan, datalokasi) async {
      setState(() {
        recentLocation = datalokasi;
      });
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(datalokasi['point']['lat'], datalokasi['point']['lng']),
        zoom: 10,
      );
      controller
          .showMarkerInfoWindow(MarkerId(datalokasi['name']));

      var titikKoordinat = await PoskoEvakuasiService().getKoordinatPosko(
         _lat,
          _lng,
          datalokasi['point']['lat'], datalokasi['point']['lng'],
          jenisKendaraan);

      var daftarKoordinat =
          json.decode(titikKoordinat.body)['paths'][0]['points']['coordinates'];
      print(daftarKoordinat);
      setState(() {
        jarak_posko =
            (json.decode(titikKoordinat.body)['paths'][0]['distance'] / 1000)
                .toStringAsFixed(2);
        daftar_rute =
            json.decode(titikKoordinat.body)['paths'][0]['instructions'];
        vehicle = jenisKendaraan;
        points.clear();
        _markers[datalokasi['name']] = Marker(
          markerId: MarkerId(datalokasi['name']),
          position: LatLng(datalokasi['point']['lat'], datalokasi['point']['lng']),
          infoWindow: InfoWindow(
            title: '${datalokasi['name']}, ${datalokasi['street']!=null ? datalokasi['street']+',' : ''} ${datalokasi['country']}',
          ),
        );
      });
      for (var koordinat in daftarKoordinat) {
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
                width: MediaQuery.of(context).size.width - 20,
                child: ListView.builder(
                  itemCount: daftar_rute.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Image.asset(
                        "images/${detectIcon(daftar_rute[i]['sign'])}",
                        width: 50.0,
                        height: 50.0,
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: 'Langkah ${i + 1}\n',
                          style: TextStyle(fontSize: 15, color: Colors.brown),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${daftar_rute[i]['text']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    );
                  },
                )),
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
  void _showResultDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            title: Center(child: Text("Pilih Lokasi")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 100,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemCount: daftar_lokasi.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Image.network(
                        "https://www.pngfind.com/pngs/m/73-732203_location-marker-location-icon-png-grey-transparent-png.png",
                        width: 15.0,
                        height: 30.0,
                      ),
                      title: Text('${daftar_lokasi[i]['name']}, ${daftar_lokasi[i]['street']!=null ? daftar_lokasi[i]['street']+',' : ''} ${daftar_lokasi[i]['country']}', style : TextStyle(fontSize: 15)),
                      onTap:(){
                        Navigator.of(context).pop();
                        getDataPosko('bike', daftar_lokasi[i]);
                      },
                    );
                  },
                )),
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




  String detectIcon(sign) {
    var namaIcon = '';
    switch (sign) {
      case -7:
        namaIcon = 'ic_continue';
        break;
      case -3:
        namaIcon = 'sharp_left';
        break;
      case -2:
        namaIcon = 'ic_turn_left';
        break;
      case -1:
        namaIcon = 'ic_slight_left';
        break;
      case 0:
        namaIcon = 'ic_continue';
        break;
      case 1:
        namaIcon = 'ic_slight_right';
        break;
      case 2:
        namaIcon = 'ic_turn_right';
        break;
      case 3:
        namaIcon = 'sharp_right';
        break;
      case 4:
        namaIcon = 'ic_arrived';
        break;
      case 6:
        namaIcon = 'roundabout';
        break;
      case 7:
        namaIcon = 'keep_right';
        break;
    }
    return namaIcon + '.png';
  }
}
