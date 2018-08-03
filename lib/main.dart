import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:latlong/latlong.dart';
import 'package:thesht/mapscreen.dart';
import 'package:thesht/trailpoints.dart';
import 'package:thesht/waypoints.dart';
import 'package:thesht/waypointscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LET'S GO FOR A HIKE",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: "√∆∆∆ <3 ∆∆∆√")
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MapScreen _mapScreen = MapScreen();
  final WaypointScreen _waypointScreen = WaypointScreen();

  static LatLng _thisPosition;
  static int _closestWptIdx;
  static double _closestMile;
  static bool _isNOBO = true;

  void getPosition() async {
    var position =
        await Geolocator().getPosition(LocationAccuracy.bestForNavigation);
    if (position != null) {
      setState(() {
        _thisPosition = LatLng(position.latitude, position.longitude);
        _closestWptIdx = Trailpoints.getClosestIndexTo(_thisPosition);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: "Get location",
            icon: Icon(Icons.location_on),
            onPressed: getPosition,
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => _mapScreen)),
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => _waypointScreen)),
          )
        ],
      ),
      body: buildBodyWidget(_closestWptIdx),
    );
  }

  List<Widget> buildNextWptItems(List<Map<String, Object>> W) {
    const fullFromAbbrev = {
      "ALL": "All",
      "WTR": "Water",
      "CMP": "Campsite",
      "TWN": "Town",
      "CAR": "Road",
      "TRL": "Trail",
      "POI": "Interesting Thing",
    };
    List<Widget> result = [];
    for (var waypoint in W) {
      String mMarker = Trailpoints.getMileAt(
              LatLng(waypoint["lat"], waypoint["lon"]),
              isNOBO: _isNOBO)
          .toStringAsFixed(1);
      String distance = Trailpoints.sumBetweenIndices(
              waypoint["closestWptIdx"], _closestWptIdx,
              isNOBO: _isNOBO)
          .toStringAsFixed(1);
      result.add(Card(
        elevation: 4.0,
        child:
      ListTile(
        title: Text(
            "Next ${fullFromAbbrev[waypoint["typ"]]}: ${waypoint["name"]}", style: Theme.of(context).textTheme.body2),
        subtitle: Text("$distance [mile: $mMarker]"),
        trailing: IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapScreen(waypoint)));
            }),
      )));
    }
    return result;
  }

  Widget buildBodyWidget(int closestWptIdx) {
    List<Map<String, Object>> waypoints = [];
    if (_closestWptIdx != null) {
      var nextWTR = Waypoints.getNextOfType(closestWptIdx, "WTR", _isNOBO);
      var nextCMP = Waypoints.getNextOfType(closestWptIdx, "CMP", _isNOBO);
      var nextTWN = Waypoints.getNextOfType(closestWptIdx, "TWN", _isNOBO);
      var nextCAR = Waypoints.getNextOfType(closestWptIdx, "CAR", _isNOBO);
      var nextTRL = Waypoints.getNextOfType(closestWptIdx, "TRL", _isNOBO);
      var nextPOI = Waypoints.getNextOfType(closestWptIdx, "POI", _isNOBO);
      waypoints
        ..add(nextWTR)
        ..add(nextCMP)
        ..add(nextTWN)
        ..add(nextCAR)
        ..add(nextTRL)
        ..add(nextPOI);
    }
    return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/marmot.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildNextWptItems(waypoints),
        ));
  }
}
