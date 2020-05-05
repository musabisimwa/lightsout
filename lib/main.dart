import 'package:flutter/material.dart';
import 'package:lights/includes/lights.dart';
main(){
  runApp(Light());
}
class Light extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:UIBoard()
    );
  }
}