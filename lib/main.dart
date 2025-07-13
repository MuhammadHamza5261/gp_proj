import 'package:flutter/material.dart';
import 'package:gm_proj/current_user_location_on_marker/user_location_on_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserLocationOnMarker(),
    );
  }
}


