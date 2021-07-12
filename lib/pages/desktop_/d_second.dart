import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DesktopSecond extends StatefulWidget {
  @override
  _DesktopSecondState createState() => _DesktopSecondState();
}

class _DesktopSecondState extends State<DesktopSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:

              // GoogleMap(
              //   initialCameraPosition: const CameraPosition(
              //       target: LatLng(37.2381676, 127.0708563), zoom: 12),
              //   markers: [
              //     Marker(
              //         markerId: MarkerId('markerID'),
              //         position: LatLng(37.2381676, 127.0708563),
              //         infoWindow: InfoWindow(title: "titlez", snippet: 'snippet'))
              //   ].toSet(),
              // ),

              Container(
        color: Colors.blue,
      )),
    );
  }
}
