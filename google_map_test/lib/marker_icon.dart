import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart';

class MarkerIcon extends StatefulWidget {
  const MarkerIcon({super.key});

  @override
  State<MarkerIcon> createState() => _MarkerIconState();
}

class _MarkerIconState extends State<MarkerIcon> {
  final Completer<GoogleMapController> completer = Completer();
  Uint8List? markerImage;
  List<String> image = [
    'https://images.unsplash.com/photo-1682685797769-481b48222adf?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1682685797769-481b48222adf?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

// * Assets Image

  // Future<Uint8List> getMarkerImage(
  //   String image,
  //   int width,
  //   int height,
  // ) async {
  //   ByteData data = await rootBundle.load(image);
  //   Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
  //       targetHeight: height, targetWidth: width);
  //   FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

// * network Image

  // Future<Uint8List> getMarkerImage(
  //   String image,
  //   int width,
  //   int height,
  // ) async {
  //   try {
  //     final data = await get(Uri.parse(image));
  //     if (data.statusCode == 200) {
  //       final Uint8List bytes = data.bodyBytes;
  //       final imageCompress = await FlutterImageCompress.compressWithList(bytes,
  //           minHeight: height, minWidth: width);
  //       return Uint8List.fromList(imageCompress);
  //     }
  //     return Uint8List(0);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // * network Image
  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    final image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  final List<LatLng> latLngs = const [
    LatLng(36.115700, -115.146347),
    LatLng(36.115700, -115.142324),
  ];

  final List<Marker> _markers = [];

  void loadData() async {
    for (int i = 0; i < image.length; i++) {
      final Uint8List? markerICon = await loadNetworkImage(image[i]);
      final ui.Codec codec = await ui.instantiateImageCodec(
          markerICon!.buffer.asUint8List(),
          targetHeight: 50,
          targetWidth: 50);
      final FrameInfo fi = await codec.getNextFrame();
      final ByteData? byteData =
          await fi.image.toByteData(format: ImageByteFormat.png);
      final Uint8List resizedImage = byteData!.buffer.asUint8List();

      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latLngs[i],
          icon: BitmapDescriptor.fromBytes(resizedImage),
          infoWindow:
              InfoWindow(title: 'This is title marker: ${i.toString()}'),
        ),
      );
      setState(() {});
    }
  }

  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(36.115700, -115.146347), zoom: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set.of(_markers),
        myLocationEnabled: true,
        onMapCreated: (controller) => completer.complete(controller),
      ),
    );
  }
}
