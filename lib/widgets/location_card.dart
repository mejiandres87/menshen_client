import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  LocationCard({@required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.meeting_room),
            title: Text(location.name),
            subtitle: Text(location.description),
          )
        ],
      ),
    );
  }
}
