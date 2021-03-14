import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/screens/scanner_screen.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  LocationCard({@required this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ScannerScreen(location: location);
      })),
      child: Card(
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
      ),
    );
  }
}
