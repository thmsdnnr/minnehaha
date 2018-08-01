import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:latlong/latlong.dart';
import 'package:thesht/mapscreen.dart';
import 'package:thesht/trailpoints.dart';
import 'package:thesht/waypoints.dart';

enum CD { NORTH, SOUTH, EAST, WEST }

const CD_fwd = {
  CD.NORTH: "north",
  CD.SOUTH: "south",
  CD.EAST: "east",
  CD.WEST: "west",
};

const CD_rev = {
  CD.NORTH: "south",
  CD.SOUTH: "north",
  CD.EAST: "west",
  CD.WEST: "east"
};

enum HD { LEFT, RIGHT }

const HD_fwd = {
  HD.LEFT: "left",
  HD.RIGHT: "right",
};

const HD_rev = {
  HD.LEFT: "right",
  HD.RIGHT: "left",
};

enum WPT_TYPE {
  POI,
  WTR,
  CAR,
  TWN,
  OFF,
  HLP,
  TRL,
  THD,
  CMP,
}

class WaypointScreen extends StatefulWidget {
  WaypointScreen({Key key, this.title}) : super(key: key);

  final String title;
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  @override
  _WaypointScreenState createState() => new _WaypointScreenState();
}

class _WaypointScreenState extends State<WaypointScreen> {
  static String _currentSelected = "ALL";
  static bool _isNOBO = false;
  static const titleFromFilter = {
    "ALL": "All",
    "WTR": "Water",
    "CMP": "Campsites",
    "TWN": "Towns",
    "CAR": "Roads",
    "TRL": "Trails",
  };
  LatLng _thisPosition;
  int _closestWptIdx;
  final double _initialScrollOffset = 0.0;

  void getPosition() async {
    var position =
        await Geolocator().getPosition(LocationAccuracy.bestForNavigation);
    if (position != null) {
      setState(() {
        _thisPosition = LatLng(position.latitude, position.longitude);
        _closestWptIdx = Trailpoints.getClosestIndexTo(_thisPosition);
        print(Trailpoints.getMileAt(_thisPosition));
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
    return new Scaffold(
      appBar: AppBar(
        title: Text(
            "${titleFromFilter[_currentSelected]} (${_isNOBO ? "NOBO" : "SOBO"})"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: getPosition,
          ),
          IconButton(
            icon: Icon(Icons.swap_vert),
            onPressed: () {
              setState(() {
                _isNOBO = !_isNOBO;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            initialValue: "ALL",
            onSelected: (selection) {
              print(selection);
              setState(() {
                _currentSelected = selection;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(value: "WTR", child: Text("Water")),
                  PopupMenuItem<String>(value: "CMP", child: Text("Campsites")),
                  PopupMenuItem<String>(value: "TRL", child: Text("Trails")),
                  PopupMenuItem<String>(value: "CAR", child: Text("Roads")),
                  PopupMenuItem<String>(value: "TWN", child: Text("Towns")),
                  PopupMenuItem<String>(
                      value: "ALL", child: Text("Everything")),
                ],
          ),
        ],
      ),
      body: Center(child: buildPlaceList(context, _currentSelected, _isNOBO)),
    );
  }

  double calculateDistanceFromMe(wpt, isNOBO) {
    if (_closestWptIdx == null) {
      return null;
    }
    return Trailpoints.sumBetweenIndices(wpt["closestWptIdx"], _closestWptIdx,
        isNOBO: isNOBO);
  }

  Widget buildPlaceList(BuildContext context, filter, _isNOBO) {
    List<Map<String, Object>> listOfPlaces =
        _isNOBO ? Waypoints.list : Waypoints.list.reversed.toList();
    for (var place in listOfPlaces) {
      place["dFromMe"] = calculateDistanceFromMe(place, _isNOBO);
    }
    if (filter != "ALL") {
      listOfPlaces =
          listOfPlaces.where((item) => item["typ"] == filter).toList();
    }
    if (_closestWptIdx != null) {
      listOfPlaces.sort((A, B) {
        double d_A = A["dFromMe"];
        double d_B = B["dFromMe"];
        return d_A.compareTo(d_B);
      });
    }
    return ListView.builder(
        itemCount: listOfPlaces.length,
        controller: widget._scrollController,
        itemBuilder: (context, index) {
          final Map<String, Object> W = listOfPlaces[index];
          double distanceAway = W["dFromMe"];
          return ListTile(
            title: Text(W["name"]),
            subtitle: Text(
                "${W["typ"]} ${distanceAway != null ? distanceAway.toStringAsFixed(2) : ""}"),
            trailing: IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen(W)));
                }),
          );
        });
  }
}
