import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  var uuid = const Uuid();
  String? sessionToken;
  List<dynamic> _placeList = [];
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    } else {
      getSuggestion(controller.text);
    }
  }

  getSuggestion(String input) async {
    String apiKey = 'AIzaSyAoSbver7G9emTgsZMM4RCAXt3z5pjauYE';
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseUrl?input=$input&key=$apiKey&sessionToken=$sessionToken';
    final response = await get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Fialed To Load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(),
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        final List<Location> address =
                            await locationFromAddress(
                                _placeList[index]['description']);
                        print(address.first.latitude);
                        print(address.first.longitude);
                      },
                      title: Text(_placeList[index]['description']),
                    );
                  },
                  itemCount: _placeList.length,
                ))
              ],
            )),
      ),
    );
  }
}
