import 'dart:convert';
import 'package:menshen_client/models/location.dart';
import 'package:http/http.dart' as http;

final _host = 'menshen-firebase-default-rtdb.firebaseio.com';

class LocationApiProvider {
  Future<List<Location>> fetchLocations() async {
    List<Location> locationsList = [];
    var url = Uri.https(_host, 'locations.json');
    var response = await http.get(url);
    var parsedLocations = json.decode(response.body) as Map<String, dynamic>;

    parsedLocations.forEach((key, value) {
      var l = Location.fromJson(value);
      l = l.copyWith(id: key);
      locationsList.add(l);
    });

    return locationsList;
  }
}
