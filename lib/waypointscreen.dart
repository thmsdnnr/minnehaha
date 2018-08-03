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
    keepScrollOffset: false,
  );
  @override
  _WaypointScreenState createState() => _WaypointScreenState();
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
  double _closestMile;

  void getPosition() async {
    var position =
        await Geolocator().getPosition(LocationAccuracy.bestForNavigation);
    if (position != null) {
      setState(() {
        _thisPosition = LatLng(position.latitude, position.longitude);
        _closestWptIdx = Trailpoints.getClosestIndexTo(_thisPosition);
        _closestMile = Trailpoints.getMileAt(_thisPosition, isNOBO: _isNOBO);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  void switchHikingDirection() {
    setState(() {
      _isNOBO = !_isNOBO;
      _closestMile = Trailpoints.getMileAt(_thisPosition, isNOBO: _isNOBO);
    });
  }

  void _goToElement(int index, BuildContext context) {
    double offset = 72.0;
    widget._scrollController.animateTo((offset * (index - 3)),
        duration: const Duration(milliseconds: 200), curve: Curves.elasticIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${titleFromFilter[_currentSelected]}"),
        actions: <Widget>[
          IconButton(
            tooltip: "Get location",
            icon: Icon(Icons.location_on),
            onPressed: getPosition,
          ),
          IconButton(
            tooltip: "Hiking ${!_isNOBO == true ? "SOBO" : "NOBO"}",
            icon: _isNOBO == true
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down),
            onPressed: switchHikingDirection,
          ),
          PopupMenuButton<String>(
            elevation: 4.0,
            icon: Icon(Icons.filter_list),
            onSelected: (selection) {
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
      body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('assets/marmot.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
            ),
          ),
          child: buildPlaceList(context, _currentSelected, _isNOBO)),
    );
  }

  double calculateDistanceFromMe(wpt, isNOBO) {
    if (_closestWptIdx == null) {
      return null;
    }

    return Trailpoints.sumBetweenIndices(wpt["closestWptIdx"], _closestWptIdx,
        isNOBO: _isNOBO);
  }

  Widget buildPlaceList(BuildContext context, filter, _isNOBO) {
    List<Map<String, Object>> listOfPlaces = Waypoints.list;
    // _isNOBO == true ? Waypoints.list : Waypoints.list.reversed.toList();
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
    listOfPlaces = listOfPlaces
        .where((place) => place["isCurrentPosition"] == null)
        .toList();
    bool haveNextWpt = false;
    for (var i = 0; i < listOfPlaces.length; i++) {
      double distanceAway = listOfPlaces[i]["dFromMe"];
      if (haveNextWpt == false && distanceAway != null && distanceAway >= 0) {
        haveNextWpt = true;
        if (widget._scrollController.hasClients == true) {
          listOfPlaces.insert(i, {
            "isCurrentPosition": true,
            "title": "Walking ${_isNOBO == true ? "north" : "south"}",
            "subtitle": "Near mile ${_closestMile.toStringAsFixed(1)}"
          });
          _goToElement(i + 1, context);
        }
      }
    }
    return ListView.builder(
        itemCount: listOfPlaces.length,
        controller: widget._scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Map<String, Object> W = listOfPlaces[index];
          if (W["isCurrentPosition"] == true) {
            return ListTile(
              leading: Icon(Icons.android, color: Colors.deepOrange),
              title: Text("${W["title"]}"),
              subtitle: Text("${W["subtitle"]}"),
            );
          } else {
            double distanceAway = W["dFromMe"];
            String distanceString = "";
            String mMarker = "";
            if (distanceAway != null) {
              String dist = distanceAway.abs().toStringAsFixed(1);
              mMarker = Trailpoints.getMileAt(LatLng(W["lat"], W["lon"]),
                      isNOBO: _isNOBO)
                  .toStringAsFixed(1);
              distanceString =
                  distanceAway < 0 ? "$dist miles back" : "$dist miles away";
            }
            return ListTile(
              title: Text(W["name"]),
              subtitle: Text("$distanceString [mile: $mMarker]"),
              trailing: IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen(W)));
                  }),
            );
          }
        });
  }
}
