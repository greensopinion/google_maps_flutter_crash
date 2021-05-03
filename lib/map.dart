import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _takeSnapshot,
        label: Text('Snapshot'),
        icon: Icon(Icons.camera),
      ),
    );
  }

  Future<void> _takeSnapshot() async {
    final GoogleMapController controller = await _controller.future;
    final bytes = await controller.takeSnapshot();
    if (bytes == null) {
      throw Exception("NO BYTES! (why not?)");
    }
    final directory = await getTemporaryDirectory();
    final file = File("${directory.path}/example_map_snapshot.png");
    await file.writeAsBytes(bytes);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Saved file to ${file.path}")));
  }
}
