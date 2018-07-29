import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:geolocator/models/position.dart';

import 'package:thesht/waypoints.dart';
import 'package:thesht/mapscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LET'S GO FOR A HIKE",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: "∆ MINNEHAHA ∆"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Position location =
      Position.fromMap({"latitude": 43.23, "longitude": -23.33});

  void _incrementCounter() async {
    print('hi'); //TODO: fix location
    Position position =
        await Geolocator().getPosition();
    print(position.latitude.toString());
    setState(() {
      print(position.latitude);
      location = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen())),
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen())),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${location.latitude}, ${location.longitude}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
