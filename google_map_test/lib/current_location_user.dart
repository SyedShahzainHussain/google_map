import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CurrentLocationUSer extends StatefulWidget {
  const CurrentLocationUSer({super.key});

  @override
  State<CurrentLocationUSer> createState() => _CurrentLocationUSerState();
}

class _CurrentLocationUSerState extends State<CurrentLocationUSer> {
  LatLng? _currnt;
  Location location = Location();
  Completer<GoogleMapController> completer = Completer<GoogleMapController>();

  final List<LatLng> latlng = const [
    LatLng(24.8616, 67.0291),
    LatLng(33.7425, 73.0469),
  ];

  Map<PolylineId, Polyline> polline = {};
  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) =>
        {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currnt == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(24.8616, 67.0291), zoom: 15.0),
              onMapCreated: (GoogleMapController controller) =>
                  completer.complete(controller),
              // polylines: Set<Polyline>.of(polline.values),
              markers: {
                Marker(markerId: const MarkerId('1'), position: _currnt!),
                  Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position:    LatLng(24.8616, 67.0291)),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(33.7425, 73.0469))
              },
            ),
    );
  }

  Future<void> _cameraToPositioned(LatLng lat) async {
    final controller = await completer.future;
    CameraPosition cameraPosition =
        CameraPosition(target: LatLng(lat.latitude, lat.longitude), zoom: 15.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionStatus;

    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      return;
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
    }
    if (_permissionStatus != PermissionStatus.granted) {
      return;
    }

    location.onLocationChanged.listen((LocationData event) {
      if (event.latitude != null && event.longitude != null) {
        setState(() {
          _currnt = LatLng(event.latitude!, event.longitude!);
          _cameraToPositioned(_currnt!);
        });
      }
    });
  }

  // Future<List<LatLng>> getPolyLines() async {
  //   List<LatLng> polyLineCordinates = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult polylineResult =
  //       await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyAoSbver7G9emTgsZMM4RCAXt3z5pjauYE',
  //     const PointLatLng(24.8616, 67.0291),
  //     const PointLatLng(33.7425, 73.0469),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (polylineResult.points.isNotEmpty) {
  //     for (var element in polylineResult.points) {
  //       polyLineCordinates.add(LatLng(element.latitude, element.longitude));
  //     }
  //   }
  //   return polyLineCordinates;
  // }

  // void generetedPolyline(List<LatLng> polyLineCordinates) async {
  //   PolylineId id = const PolylineId("unique");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: Colors.black,
  //       points: polyLineCordinates,
  //       width: 8);

  //   setState(() {
  //     polline[id] = polyline;
  //   });
  // }
}
