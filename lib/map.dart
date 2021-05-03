import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Map> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Polyline polyline = Polyline(
      polylineId: PolylineId("a-line"),
      color: Colors.red,
      width: 2,
      points: [
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.43796133580664, -122.095749655962),
        LatLng(37.42796133580664, -122.096749655962),
        LatLng(37.42796133580664, -122.085749655962),
      ]);

  Marker marker1 = Marker(
      markerId: MarkerId("a-marker"),
      flat: true,
      rotation: 180,
      anchor: Offset(1.0, 0.5),
      position: LatLng(37.42796133580664, -122.085749655962));

  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
        builder: (context, model, child) => GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              compassEnabled: false,
              indoorViewEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              polylines: Set.from([polyline]),
              markers: Set.from([marker1]),
              onMapCreated: (GoogleMapController controller) {
                model.controller.complete(controller);
              },
            ));
  }
}
