import 'dart:async';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Model {
  Completer<GoogleMapController> controller = Completer();

  Future<File> takeSnapshot() async {
    final GoogleMapController controller = await this.controller.future;
    final bytes = await controller.takeSnapshot();
    if (bytes == null) {
      throw Exception("NO BYTES! (why not?)");
    }
    final directory = await getTemporaryDirectory();
    final file = File("${directory.path}/example_map_snapshot.png");
    await file.writeAsBytes(bytes);
    return file;
  }
}
