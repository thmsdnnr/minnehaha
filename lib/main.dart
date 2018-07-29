import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:thesht/waypoints.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "LET'S GO FOR A HIKE",
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new MyHomePage(title: "∆ MINNEHAHA ∆"),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OfflineMapPage())),
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () => print('pressed'),
          )
        ],
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("$location"),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class OfflineMapPage extends StatelessWidget {
  static const String route = '/offline_map';
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Offline Map")),
      body: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          children: [
            new Padding(
              padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Text(
                  "This is an offline map that is showing the SHT in Minnesota!")
            ),
            new Flexible(
              child: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(-91.4062, 47.2792),
                  minZoom: 8.0,
                  maxZoom: 13.0,
                  zoom: 11.0,
                  swPanBoundary: LatLng(-92.7081, 46.5834),
                  nePanBoundary: LatLng(-89.3573, 48.1679),
                ),
                layers: [
                  new TileLayerOptions(
                    offlineMode: true,
                    maxZoom: 14.0,
                    urlTemplate: "assets/map/{z}/{x}/{y}.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}