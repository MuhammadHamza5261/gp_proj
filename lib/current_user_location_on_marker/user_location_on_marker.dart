import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


/// flutter ki user ki location get Geocoder package ka through karta han


class UserLocationOnMarker extends StatefulWidget {
  const UserLocationOnMarker({super.key});

  @override
  State<UserLocationOnMarker> createState() => _UserLocationOnMarkerState();
}

class _UserLocationOnMarkerState extends State<UserLocationOnMarker> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =  const CameraPosition(
    target: LatLng(37.21, -122.23),
    zoom: 14.4746,
  );

  // create markers list
  final List<Marker> _marker = [];

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



  // create a function to get user location
  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value) {

    }).onError((error,stackTrace){
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }

  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            getUserCurrentLocation().then((value) async {
              print(value.latitude.toString()+""+value.longitude.toString());

              _marker.add(
                Marker(
                    markerId: const MarkerId("3"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: "My current location",
                  ),
                )
              );

              CameraPosition cameraPosition = CameraPosition(
                  target: LatLng(value.latitude, value.longitude),
                zoom: 14
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {

              });

            });
          }
      ),
      body:  GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_marker),
          compassEnabled: false,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          }

      ),
    );
  }
}
