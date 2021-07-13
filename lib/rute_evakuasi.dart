import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:darurat_app/locations.dart' as locations;


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
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
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
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),

        persistentFooterButtons: [
          Align(
            alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
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
}