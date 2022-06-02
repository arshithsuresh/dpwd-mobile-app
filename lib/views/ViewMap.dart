import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ViewOnMap extends StatefulWidget {
  @override
  State<ViewOnMap> createState() => ViewOnMapState();
}

class ViewOnMapState extends State<ViewOnMap> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();

  Marker _pickMarker = Marker(markerId: MarkerId("picker"), draggable: true);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as LatLng;

    _pickMarker =
        Marker(markerId: MarkerId("picker"), draggable: true, position: args);

    return new Scaffold(
        body: FutureBuilder(
      future: location.getLocation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(child: CircularProgressIndicator());
        } else {
          final LocationData location = snapshot.data;

          return GoogleMap(
            
            initialCameraPosition: CameraPosition(
              target: args,
              zoom: 12
            ),
            markers: {_pickMarker},
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
      },
    ));
  }
}
