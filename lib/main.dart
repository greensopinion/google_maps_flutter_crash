import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './map.dart';

import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Demo',
      theme: ThemeData.light(),
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Maps Example")),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20), child: _content(context))));
  }

  Widget _content(BuildContext context) {
    return Provider(
        create: (context) => Model(),
        child: ListView(children: [
          Container(
              child: Column(children: [
                Text("one"),
                Consumer<Model>(
                    builder: (context, model, child) =>
                        FloatingActionButton.extended(
                            label: Text("Snapshot"),
                            icon: Icon(Icons.camera),
                            onPressed: () async {
                              final file = await model.takeSnapshot();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Saved file to ${file.path}")));
                            }))
              ]),
              height: 400),
          Container(child: Column(children: [Text("two")]), height: 400),
          Container(child: Column(children: [Text("three")]), height: 400),
          Container(child: Map(), height: 400)
        ]));
  }
}
