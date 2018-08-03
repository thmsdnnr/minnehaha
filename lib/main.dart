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
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WaypointScreen())),
          )
        ],
      ),
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/marmot.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text("Hi"),
              subtitle: Text("there"),
            )
          ]
        )
    );
            
    // return Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    //   Card(
    //     child: Container(
    //       child:
    //           Text('Hello world', style: Theme.of(context).textTheme.display2),
    //       decoration: BoxDecoration(
    //           color: const Color(0xff7c94b6),
    //           image: DecorationImage(
    //             fit: BoxFit.cover,
    //             colorFilter: ColorFilter.mode(
    //                 Colors.black.withOpacity(0.6), BlendMode.dstATop),
    //             image: AssetImage('assets/marmot.jpeg'),
    //           )),
    //     ),
    //   ),
    //   Card(
    //     child: Container(
    //       child:
    //           Text('Hello world', style: Theme.of(context).textTheme.display3),
    //       decoration: BoxDecoration(
    //           color: const Color(0xff7c94b6),
    //           image: DecorationImage(
    //             fit: BoxFit.cover,
    //             colorFilter: ColorFilter.mode(
    //                 Colors.black.withOpacity(0.6), BlendMode.dstATop),
    //             image: AssetImage('assets/marmot.jpeg'),
    //           )),
    //     ),
    //   ),
    // ]);
  }
}
