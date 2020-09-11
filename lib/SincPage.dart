import 'package:flutter/material.dart';
class SincPage extends StatefulWidget {
  @override
  _SincPageState createState() => _SincPageState();
}

class _SincPageState extends State<SincPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("SincPage"),
      ),
      body: new Center(
        child:  new Text("Sinc"),
      ),
    );
  }
}