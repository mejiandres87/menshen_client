import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/screens/employees_screen.dart';
import 'package:menshen_client/screens/locations_screen.dart';
import 'package:menshen_client/screens/scanner_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToEmployees(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployeesScreen(),
      ),
    );
  }

  void _goToLocations(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocationsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _goToEmployees(context),
                child: const Text('Empleados'),
              ),
              ElevatedButton(
                onPressed: () => _goToLocations(context),
                child: const Text('Salas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
