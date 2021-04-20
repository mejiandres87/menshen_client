import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:http/http.dart' as http;
import 'package:menshen_client/widgets/registry_card.dart';

class EmployeeLogScreen extends StatefulWidget {
  final Employee employee;

  EmployeeLogScreen(this.employee);

  @override
  _EmployeeLogScreenState createState() => _EmployeeLogScreenState();
}

class _EmployeeLogScreenState extends State<EmployeeLogScreen> {
  var _registries = <Registry>[];
  bool isLoading = false;

  @override
  void initState() {
    _loadRegistries();
    super.initState();
  }

  void _loadRegistries() async {
    setState(() {
      isLoading = true;
    });
    var registryList = <Registry>[];
    var url = Uri.https('menshen-firebase-default-rtdb.firebaseio.com',
        'employees/${widget.employee.id}/registries.json');
    var response = await http.get(url);
    var parsedRegistries = json.decode(response.body) as Map<String, dynamic>;
    if (parsedRegistries != null) {
      parsedRegistries.forEach((key, value) {
        var r = Registry.fromJson(value);
        r = r.coptWith(id: key);
        registryList.add(r);
      });
    }
    setState(() {
      isLoading = false;
      _registries = registryList;
    });
  }

  void _loadRegistriesFiltered(DateTimeRange range) async {
    setState(() {
      isLoading = true;
    });
    var registryList = <Registry>[];
    var url = Uri.https(
      'menshen-firebase-default-rtdb.firebaseio.com',
      'employees/${widget.employee.id}/registries.json',
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
    setState(() {
      isLoading = false;
      _registries = registryList;
    });
  }

  void _showDateRangePicker(BuildContext context) async {
    var range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (range != null) _loadRegistriesFiltered(range);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee.fullname),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () => _showDateRangePicker(context),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _registries.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return RegistryCard(_registries[index]);
                  },
                  itemCount: _registries.length,
                )
              : Center(
                  child: const Text("No hay registros..."),
                ),
    );
  }
}
