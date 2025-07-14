import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class AutoCompletePlacesApi extends StatefulWidget {
  const AutoCompletePlacesApi({super.key});

  @override
  State<AutoCompletePlacesApi> createState() => _AutoCompletePlacesApiState();
}

class _AutoCompletePlacesApiState extends State<AutoCompletePlacesApi> {

  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener((){
      onChanged();
    });
  }

  void onChanged(){

    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async{

     String kPlaces_API_KEY = "AIzaSyB-7d_8fCQrcniAh7FMaBDNeiGXQ6Jjddg";
     String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
     String request = '$baseURL?input=$input&key=$kPlaces_API_KEY&sessiontoken=$_sessionToken';

     var response = await http.get(Uri.parse(request));

     if(response.statusCode == 200){
        setState(() {
          _placesList = jsonDecode(response.body.toString()) ['prediction'];
        });
     }
     else{
        throw Exception('Failed to load data');
     }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google search places api"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search Places with name',
              ),
            ),

          ],
        ),
      ),
    );
  }
}
