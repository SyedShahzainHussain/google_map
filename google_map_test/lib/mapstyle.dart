import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStyle extends StatefulWidget {
  const MapStyle({super.key});

  @override
  State<MapStyle> createState() => _MapStyleState();
}

class _MapStyleState extends State<MapStyle> {
  Completer<GoogleMapController> controller = Completer();
  String mapTheme = '';
  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/mapTheme/standardtheme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Change"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Standard'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/standardtheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              ),
              PopupMenuItem(
                child: const Text('Silver'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/silvertheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              ),
              PopupMenuItem(
                child:  Text('Dark'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/darktheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              ),
              PopupMenuItem(
                child: const Text('Night'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/nighttheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              ),
              PopupMenuItem(
                child: const Text('Aburgine'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/aburginetheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              ),
              PopupMenuItem(
                child: const Text('Retro'),
                onTap: () {
                  controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/mapTheme/retrotheme.json')
                        .then((string) => value.setMapStyle(string));
                  });
                },
              )
            ],
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.8616, 67.0291),
        ),
        onMapCreated: (controller) {
          controller.setMapStyle(mapTheme);

          return this.controller.complete(controller);
        },
      ),
    );
  }
}
