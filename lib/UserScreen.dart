import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'place.dart';
import 'package:flutter/services.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();


}

class _UserScreenState extends State<UserScreen> {

  GoogleMapController _controller;
  bool isMapCreated = false;
  static final LatLng myLocation = LatLng(12.9717, 79.1594);

  String _mapStyle;

  @override
  void initState() {
    super.initState();

  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 16.4746,
  );

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta,
          )),
    ].toSet();
  }

  getMapMode() {

      getJsonFile("assets/map_style.json").then(setMapStyle);

  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }


  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {

    if (isMapCreated) {
      getMapMode();
    }

    return Scaffold(
        body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text("Parking Slot Locator",
                  style: TextStyle(
                    fontSize: 24
                  ),),
                  SizedBox(height: 10,),
                  Container(
                    height: MediaQuery.of(context).size.height - 92,
                    width: MediaQuery.of(context).size.width,

                    child: GoogleMap(

                      trafficEnabled: true,
                      mapType: MapType.normal,
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: _createMarker(),




                      initialCameraPosition: _kGooglePlex,

                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        isMapCreated = true;
                        getMapMode();
                        setState(() {});
                      },


                      zoomGesturesEnabled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
    );

  //           : Center(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height / 3,
  //           width: MediaQuery.of(context).size.width,
  //           child: GoogleMap(
  //             initialCameraPosition: CameraPosition(
  //                 target: LatLng(17.3850,
  //                     78.4867),
  //                 zoom: 16.0),
  //             zoomGesturesEnabled: true,
  //           ),
  //         ),
  //           ),
  //         ),
  //
  //
  // //);
  }
}
