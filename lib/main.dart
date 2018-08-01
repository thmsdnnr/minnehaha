import 'package:flutter/material.dart';
import 'package:thesht/mapscreen.dart';
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
      home: MyHomePage(title: "∆ MINNEHAHA ∆"),
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
                context, MaterialPageRoute(builder: (context) => WaypointScreen())),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Let's take a walk!"),
          ],
        ),
      ),
    );
  }
}
