import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:http/http.dart' as http;

final _host = 'menshen-firebase-default-rtdb.firebaseio.com';

class RegistryApiProvider {
  Future<List<Registry>> fetchRegistriesForEmployee(Employee employee) async {
    var registryList = <Registry>[];
    var url = Uri.https(_host, 'employees/${employee.id}/registries.json');
    var response = await http.get(url);
    var parsedRegistries = json.decode(response.body) as Map<String, dynamic>;
    if (parsedRegistries != null) {
      parsedRegistries.forEach((key, value) {
        var r = Registry.fromJson(value);
        r = r.coptWith(id: key);
        registryList.add(r);
      });
    }
    return registryList;
  }

  Future<List<Registry>> fetchRegistriesForEmployeeWithinTimeRange(
      Employee employee, DateTimeRange range) async {
    var registryList = <Registry>[];
    var url = Uri.https(
      _host,
      'employees/${employee.id}/registries.json',
      {
        'orderBy': '"in_time"',
        'startAt': '"${range.start.toIso8601String()}"',
        'endAt': '"${range.end.toIso8601String()}"'
      },
    );
    var response = await http.get(url);
    var parsedRegistries = json.decode(response.body) as Map<String, dynamic>;
    if (parsedRegistries != null) {
      parsedRegistries.forEach((key, value) {
        var r = Registry.fromJson(value);
        r = r.coptWith(id: key);
        registryList.add(r);
      });
    }

    return registryList;
  }

  Future<Registry> fetchLastRegistry(Employee employee) async {
    var url = Uri.https(
      _host,
      'employees/${employee.id}/registries.json',
      {
        'orderBy': '"in_time"',
        'limitToLast': '1',
      },
    );
    var response = await http.get(url);
    var parsedRegistries = json.decode(response.body) as Map<String, dynamic>;
    var registryList = <Registry>[];
    if (parsedRegistries != null) {
      parsedRegistries.forEach((key, value) {
        var r = Registry.fromJson(value);
        r = r.coptWith(id: key, employeeName: employee.fullname);
        registryList.add(r);
      });
    }
    return registryList.isNotEmpty ? registryList.first : null;
  }

  Future<bool> createRegistry(Employee employee, Registry registry) async {
    var url = Uri.https('menshen-firebase-default-rtdb.firebaseio.com',
        '/employees/${employee.id}/registries.json');
    var response = await http.post(url, body: json.encode(registry));
    return response.statusCode == 201;
  }
}
