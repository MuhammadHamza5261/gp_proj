import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AnimateCameraToAnother extends StatefulWidget {
  const AnimateCameraToAnother({super.key});

  @override
  State<AnimateCameraToAnother> createState() => _AnimateCameraToAnotherState();
}

class _AnimateCameraToAnotherState extends State<AnimateCameraToAnother> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =  const CameraPosition(
    target: LatLng(37.21, -122.23),
    zoom: 14.4746,
  );

  // create markers list
  List<Marker> _marker = [];

  final List<Marker> _list = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(37.21, -122.23),
      infoWindow: InfoWindow(
          title: "My position"
      ),
    ),
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(23.21, -111.23),
      infoWindow: InfoWindow(
        title: "My second position",
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(35.6762, 139.6583),
                zoom: 14,
              ) 
            ));
            setState(() {

            });

          },
        child: const Icon(Icons.location_history_rounded),
      ),
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_marker),
            compassEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            }
        ),
      ),
    );

  }
}
