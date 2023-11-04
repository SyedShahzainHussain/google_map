// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_map_test/current_location_user.dart';
// import 'package:google_map_test/mapstyle.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_map_test/home_screen.dart';
// import 'package:google_map_test/info_model.dart';
// import 'package:google_map_test/polygone.dart';
// import 'package:google_map_test/marker_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CurrentLocationUSer(),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String addres = '';
//   Position? currntLocation;
//   // static const CameraPosition _intiialCameraPosition = CameraPosition(
//   //     target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.0);

//   // final Completer<GoogleMapController> _controller = Completer();

//   // final List<Marker> _marker = [];
//   // final List<Marker> _list = const [
//   //   Marker(
//   //       markerId: MarkerId("1"),
//   //       position: LatLng(37.42796133580664, -122.085749655962),
//   //       infoWindow: InfoWindow(title: "1")),
//   //   Marker(
//   //       markerId: MarkerId("2"),
//   //       position: LatLng(30.3753, 69.3451),
//   //       infoWindow: InfoWindow(title: "2"))
//   // ];

//   @override
//   void initState() {
//     super.initState();

//     // _marker.addAll(_list);
//   }

//   // getLocation() async {
//   //   List<Placemark> location =
//   //       await placemarkFromCoordinates(24.8826125, 67.0338594);
//   //   var name =
//   //       '${location.first.street},${location.first.subLocality}${location.first.locality}${location.first.subAdministrativeArea},${location.first.administrativeArea}';
//   //   setState(() {
//   //     addres = name;
//   //   });
//   // }
//   Future<void> getCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) => null)
//         .onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//     });
//     currntLocation = await Geolocator.getCurrentPosition();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // getLocation();
//     getCurrentLocation();

//     return Scaffold(
//       body: HomeScreen(),
//     );
//   }
// }
 // body: SafeArea(
      //   child: GoogleMap(
      //     initialCameraPosition: _intiialCameraPosition,
      //     mapType: MapType.normal,
      //     onMapCreated: (GoogleMapController controller) {
      //       return _controller.complete(controller);
      //     },
      //     markers: Set<Marker>.of(_marker),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () async {
      //       GoogleMapController controller = await _controller.future;
      //       controller.animateCamera(CameraUpdate.newCameraPosition(
      //           const CameraPosition(
      //               target: LatLng(30.3753, 69.3451), zoom: 14)));

      //       setState(() {});
      //     },
      //     label: const Icon(
      //       Icons.location_disabled_outlined,
      //     )),