import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AutoCompletePlacesApi extends StatefulWidget {
  const AutoCompletePlacesApi({super.key});

  @override
  State<AutoCompletePlacesApi> createState() => _AutoCompletePlacesApiState();
}

class _AutoCompletePlacesApiState extends State<AutoCompletePlacesApi> {

  final _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';

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

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google search places api"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search Places with name',
              ),
            ),

          ],
        ),
      ),
    );
  }
}
