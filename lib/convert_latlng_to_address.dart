import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

// Geo coder package lat lng ko address ma convert karta ha

class ConvertLatlngToAddress extends StatefulWidget {
  const ConvertLatlngToAddress({super.key});

  @override
  State<ConvertLatlngToAddress> createState() => _ConvertLatlngToAddressState();
}

class _ConvertLatlngToAddressState extends State<ConvertLatlngToAddress> {

  String _address = 'Address will appear here';

  double latitude = 37.4219983;
  double longitude = -122.084;


  Future<void> _getAddressFromLatLng() async{
    try{

      List<Placemark> placeMark = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placeMark[0];

      String completeAddress = "${place.street}, ${place.locality},${place.administrativeArea},${place.country}";

      setState(() {
        _address = completeAddress;
      });

    }
        catch(e){

           setState(() {  
             _address = "Error occured: $e";
           });

        }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_address,style: const TextStyle(
              fontSize: 16
            ),),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: (){
                _getAddressFromLatLng();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green
                ),
                child: Center(child: const Text("Get Address")),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
