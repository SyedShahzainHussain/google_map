import 'dart:async';
import 'dart:collection';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polygone extends StatefulWidget {
  const Polygone({super.key});

  @override
  State<Polygone> createState() => _PolygoneState();
}

class _PolygoneState extends State<Polygone> {
  Completer<GoogleMapController> completer = Completer();

final List<LatLng> latlng = const [
    LatLng(24.8616, 67.0291),
    LatLng(24.9110, 67.0539),
  ];

  HashSet<Polygon> polygone = HashSet<Polygon>();  
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < latlng.length; i++) {
      markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            infoWindow: InfoWindow(title: i.toString())),
      );
      polygone.add(
        Polygon(
          polygonId: const PolygonId('1'),
          points: latlng,
          fillColor: Colors.green.withOpacity(0.3),
          strokeColor: Colors.green,
          geodesic: true,
          strokeWidth: 2,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          const CameraPosition(target: LatLng(24.8616, 67.0291), zoom: 14.0),
      onMapCreated: (controller) {
        return completer.complete(controller);
      },
      polygons: polygone,
      markers: Set<Marker>.of(markers),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
    );
  }
}
