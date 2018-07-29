import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final double _minZoom = 8.0;
  static final double _maxZoom = 13.0;
  MapController theControls = MapController();

  double _currentZoom = 11.0;
  MapPosition thisPosition;

  void _handlePositionChange(newPosition) {
    thisPosition = newPosition;
  }

  double zoomIn() => min((_currentZoom + 1.0), _maxZoom);
  double zoomOut() => max((_currentZoom - 1.0), _minZoom);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HIKING ON THE TRAAAIL <3"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () => setState(() {
                  _currentZoom = zoomOut();
                  theControls.move(thisPosition.center, _currentZoom);
                }),
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () => setState(() {
                  _currentZoom = zoomIn();
                  theControls.move(thisPosition.center, _currentZoom);
                }),
          )
        ],
      ),
      body: FlutterMap(
        mapController: theControls,
        options: MapOptions(
          onTap: (positionTapped) {
            // Zoom to tapped position if position != current.
            thisPosition = MapPosition(center: positionTapped, zoom: zoomIn());
            theControls.move(thisPosition.center, thisPosition.zoom);
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
        ],
      ),
    );
  }
}
