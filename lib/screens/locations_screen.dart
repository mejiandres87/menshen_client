import 'package:flutter/material.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/widgets/location_card.dart';

class LocationsScreen extends StatefulWidget {
  final List<Location> locations;
  LocationsScreen({@required this.locations});

  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.locations.length,
        itemBuilder: (BuildContext context, int index) {
          return LocationCard(location: widget.locations[index]);
        });
  }
}
