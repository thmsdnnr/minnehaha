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

  void getPosition() async {
    var position =
        await Geolocator().getPosition(LocationAccuracy.bestForNavigation);
    if (position != null) {
      setState(() {
        _thisPosition = LatLng(position.latitude, position.longitude);
        _closestWptIdx = Trailpoints.getClosestIndexTo(_thisPosition);
        print(Trailpoints.getMileAt(_thisPosition, isNOBO: _isNOBO));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  void _goToElement(int index, BuildContext context) {
    double offset = 72.0;
    widget._scrollController.animateTo((offset * index),
        duration: const Duration(milliseconds: 200), curve: Curves.elasticIn);
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
        double dA = A["dFromMe"];
        double dB = B["dFromMe"];
        return dA.compareTo(dB);
      });
    }
    bool haveNextWpt = false;
    for (var i = 0; i < listOfPlaces.length; i++) {
      double distanceAway = listOfPlaces[i]["dFromMe"];
      if (haveNextWpt == false && distanceAway != null && distanceAway >= 0) {
        haveNextWpt = true;
        if (widget._scrollController.hasClients == true) {
          _goToElement(i, context);
        }
      }
    }
    return ListView.builder(
        itemCount: listOfPlaces.length,
        controller: widget._scrollController,
        itemBuilder: (context, index) {
          final Map<String, Object> W = listOfPlaces[index];
          double distanceAway = W["dFromMe"];
          String distanceString = distanceAway != null && distanceAway < 0
              ? "${distanceAway.abs().toStringAsFixed(1)} miles back"
              : "${distanceAway.abs().toStringAsFixed(1)} miles";
          return ListTile(
            title: Text(W["name"]),
            subtitle: Text(
                "${W["typ"]} $distanceString"),
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
