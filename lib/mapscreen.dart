import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:geolocator/models/position.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final double _minZoom = 8.0;
  static final double _maxZoom = 13.0;
  MapController theControls = MapController();

  double _currentZoom = 11.0;
  MapPosition _thisPosition;

  void _handlePositionChange(newPosition) {
    _thisPosition = newPosition;
  }

  void getPosition() async {
    var position =
        await Geolocator().getPosition(LocationAccuracy.bestForNavigation);
    if (position != null) {
      setState(() {
        _thisPosition = MapPosition(
            center: LatLng(position.latitude, position.longitude),
            zoom: _currentZoom);
        theControls.move(_thisPosition.center, _currentZoom);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  double zoomIn() => min((_currentZoom + 1.0), _maxZoom);
  double zoomOut() => max((_currentZoom - 1.0), _minZoom);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("<3"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () => setState(() {
                  _currentZoom = zoomOut();
                  theControls.move(_thisPosition.center, _currentZoom);
                }),
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () => setState(() {
                  _currentZoom = zoomIn();
                  theControls.move(_thisPosition.center, _currentZoom);
                }),
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: getPosition,
          )
        ],
      ),
      body: FlutterMap(
        mapController: theControls,
        options: MapOptions(
          onTap: (positionTapped) {
            // Zoom to tapped position if position != current.
            // print("${positionTapped.latitude}, ${positionTapped.longitude}");
            _thisPosition = MapPosition(center: positionTapped, zoom: zoomIn());
            theControls.move(_thisPosition.center, _thisPosition.zoom);
          },
          onPositionChanged: (position) {
            _handlePositionChange(position);
          },
          center: LatLng(47.2792, -91.4062),
          minZoom: _minZoom,
          maxZoom: _maxZoom,
          zoom: 13.0,
          swPanBoundary: LatLng(46.5834, -92.7081),
          nePanBoundary: LatLng(48.1679, -89.3573),
        ),
        layers: [
          TileLayerOptions(
            offlineMode: true,
            maxZoom: 13.0,
            urlTemplate: "assets/map/{z}/{x}/{y}.png",
          ),
          MarkerLayerOptions(markers: [
            Marker(
                width: 80.0,
                height: 80.0,
                point: _thisPosition?.center,
                builder: (ctx) => Container(
                      child: Icon(
                        Icons.person_pin,
                        color: Colors.pink,
                      ),
                    ))
          ])
        ],
      ),
    );
  }
}
