import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
//import 'package:geolocator/geolocator.dart';
import 'place.dart';
import 'package:flutter/services.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();


}

class _UserScreenState extends State<UserScreen> {

  //initialising the controller for google map
  GoogleMapController _controller;
  bool isMapCreated = false;

  //default location
  static final LatLng myLocation = LatLng(12.9717, 79.1594);


  @override
  void initState() {
    super.initState();

  }

  //zoom for the default location
  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 16.4746,
  );

  Set<Marker> _createMarker() {
    return <Marker>[

      //Marker for default point in Google Map
      Marker(
          markerId: MarkerId("marker_1"),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta,
          )),
    ].toSet();
  }

  //Setting Map Style
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

        appBar: AppBar(
          centerTitle: true,
          title: Text("ParkSpace", style: TextStyle(color: Colors.deepPurple),),
          backgroundColor: Colors.white,

          leading: Icon(
            Icons.menu,
            color: Colors.deepPurple,

          ),

          shadowColor: Colors.white,
          elevation: 0,

        ),
        body: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 92,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        GoogleMap(
                          trafficEnabled: true,
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
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

                        Positioned(
                          left: 10.0,
                          right: 10.0,
                          top: 10.0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            height: 54.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 40.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Where do you go?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                            left: 10.0,
                            right: 10.0,
                            bottom: 5.0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 40.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.0,),
                                Text("Select parking slot",
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ],
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
