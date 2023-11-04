import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfosModel extends StatefulWidget {
  const InfosModel({super.key});

  @override
  State<InfosModel> createState() => _InfosModelState();
}

class _InfosModelState extends State<InfosModel> {
  CustomInfoWindowController controller = CustomInfoWindowController();

  final List<LatLng> latLngs = const [
    LatLng(36.115700, -115.146347),
    LatLng(36.115700, -115.142324),
  ];

  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    for (var i = 0; i < latLngs.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latLngs[i],
        onTap: () {
          controller.addInfoWindow!(
            Container(
              height: MediaQuery.sizeOf(context).height * .1,
              width: MediaQuery.sizeOf(context).width * .5,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * .15,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1682685797828-d3b2561deef4?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Beef",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                          ),
                        ),
                        Spacer(),
                        Text(".3 m1")
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Text(
                      'Help me asdaskdakdadasdahdahsdahdhash',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
            latLngs[i],
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(36.115700, -115.142324), zoom: 14.0),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (controller) {
              this.controller.googleMapController = controller;
            },
            onTap: (argument) => controller.hideInfoWindow!(),
            onCameraMove: (position) {
              controller.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: controller,
            height: MediaQuery.sizeOf(context).height * .3,
            width: MediaQuery.sizeOf(context).width * .7,
          )
        ],
      ),
    );
  }
}
