import 'package:flutter/material.dart';
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

Widget buildPlaceList(BuildContext context, filter, _isNOBO) {
  List<Map<String, Object>> listOfPlaces = _isNOBO ? Waypoints.list : Waypoints.list.reversed.toList();
  if (filter != "ALL") {
    print("filtering" + filter);
    listOfPlaces = listOfPlaces.where((item) => item["typ"] == filter).toList();
  }
  return ListView.builder(
      itemCount: listOfPlaces.length,
      itemBuilder: (context, index) {
        final Map<String, Object> W = listOfPlaces[index];
        return ListTile(
          title: Text(W["name"]),
          subtitle: Text(W["typ"]),
          onTap: () {
            print("haha tickles");
          }
        );
      });
}

class WaypointScreen extends StatefulWidget {
  WaypointScreen({Key key, this.title}) : super(key: key);

  final String title;

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
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
            "${titleFromFilter[_currentSelected]} (${_isNOBO ? "NOBO" : "SOBO"})"),
        actions: <Widget>[
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
                  PopupMenuItem<String>(value: "TWN", child: Text("Towns")),
                  PopupMenuItem<String>(value: "CAR", child: Text("Roads")),
                  PopupMenuItem<String>(
                      value: "ALL", child: Text("Everything")),
                ],
          ),
        ],
      ),
      body: Center(child: buildPlaceList(context, _currentSelected, _isNOBO)),
    );
  }
}