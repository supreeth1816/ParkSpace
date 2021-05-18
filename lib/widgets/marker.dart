import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';


//Getting Bytes to display custom marker
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}

//mapMarker is custom Marker for parking
BitmapDescriptor mapMarker;

void setCustomMarker() async {
  final Uint8List markerIcon = await getBytesFromAsset('assets/icon.png', 160);
  mapMarker = await BitmapDescriptor.fromBytes(markerIcon);
}



