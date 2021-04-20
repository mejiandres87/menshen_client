import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/screens/new_location_screen.dart';
import 'package:menshen_client/widgets/location_card.dart';
import 'package:http/http.dart' as http;

class LocationsScreen extends StatefulWidget {
  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  var locations = <Location>[];
  bool isLoading = false;

  @override
  void initState() {
    _loadLocations();
    super.initState();
  }

  void _loadLocations() async {
    setState(() {
      isLoading = true;
    });
    var locationList = <Location>[];
    var url = Uri.https(
        'menshen-firebase-default-rtdb.firebaseio.com', 'locations.json');
    var response = await http.get(url);
    var parsedLocations = json.decode(response.body) as Map<String, dynamic>;
    if (parsedLocations != null) {
      parsedLocations.forEach((key, value) {
        var l = Location.fromJson(value);
        l = l.copyWith(id: key);
        locationList.add(l);
      });
    }
    setState(() {
      isLoading = false;
      locations = locationList;
    });
  }

  void _goToNewLocation(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NewLocationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salas'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : locations.isNotEmpty
              ? ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LocationCard(location: locations[index]);
                  },
                )
              : Center(
                  child: const Text("No hay Salas"),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNewLocation(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
