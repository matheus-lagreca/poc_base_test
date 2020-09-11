import 'package:flutter/material.dart';
class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("ConfigPage"),
      ),
      body: new Center(
        child:  new Text("configuracao"),
      ),
    );
  }
}