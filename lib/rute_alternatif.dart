import 'package:flutter/material.dart';
import 'package:darurat_app/locations.dart' as locations;
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RuteAlternatif extends StatefulWidget {
  @override
  _RuteAlternatifState createState() => _RuteAlternatifState();
}

class _RuteAlternatifState extends State<RuteAlternatif> {
  double currentZoom = 9.0;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(-7.1524786, 111.8869293);
  var points = <LatLng> [
    new LatLng(-7.1524786, 111.8869293),
    new LatLng(-7.129435, 112.083407)
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Rute Alternatif',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Roboto')),
        backgroundColor: Colors.white,
      ),

      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentCenter,
          zoom: currentZoom,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/dianasaurus/ckr1htgf6cplp18mks9i55ibg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGlhbmFzYXVydXMiLCJhIjoiY2tyMWhjMnp2MjI1MjJwbXRsN3BhaHUydyJ9.fnwzmfdUj5gQK_yQ1302RA",
              subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(-7.1524786, 111.8869293),
                builder: (ctx) =>
                    Container(
                      child: Icon(Icons.home_sharp, size: 35,),
                    ),
              ),
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(-7.129435, 112.083407),
                builder: (ctx) =>
                    Container(
                      child: Icon(Icons.location_on, size: 35,),
                    ),
              ),
            ],
          ),
          PolylineLayerOptions(
            polylines: [
              new Polyline(
                points : points,
                strokeWidth: 4.0,
                color: Colors.red
              )
            ]
          )

        ],

      ),

        floatingActionButton:
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: (){
                  currentZoom = currentZoom + 1;
                  mapController.move(currentCenter, currentZoom);
                },
                tooltip: 'Zoom',
                child: Icon(Icons.add_circle_outline_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: (){
                  currentZoom = currentZoom - 1;
                  mapController.move(currentCenter, currentZoom);
                },
                tooltip: 'Zoom',
                child: Icon(Icons.remove_circle_outline_rounded),
              ),
            ]
        ),


        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                      hintText: 'Masukkan Rute Tujuan Anda',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
                iconSize: 35,
              )
            ],
          )
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
        )
    );
  }
}