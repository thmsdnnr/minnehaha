import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:thesht/waypoints.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

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
  String location = "";

  void _incrementCounter() async {
    var currentLocation = await Location().getLocation;
    print(currentLocation.toString());
    setState(() {
      location = currentLocation.toString();
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
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OfflineMapPage())),
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () => print('pressed'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$location"),
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

class OfflineMapPage extends StatelessWidget {
  static const String route = '/offline_map';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offline Map")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(47.2792, -91.4062),
            minZoom: 8.0,
            maxZoom: 13.0,
            zoom: 11.0,
            swPanBoundary: LatLng(46.5834, -92.7081),
            nePanBoundary: LatLng(48.1679, -89.3573),
          ),
          layers: [
            TileLayerOptions(
              offlineMode: true,
              maxZoom: 14.0,
              urlTemplate: "assets/map/{z}/{x}/{y}.png",
            ),
          ],
        ),
      ),
    );
  }
}
