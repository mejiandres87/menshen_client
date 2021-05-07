import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menshen_client/blocs/registry_bloc.dart';
import 'package:menshen_client/blocs/utils/registry_event.dart';
import 'package:menshen_client/blocs/utils/registry_state.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:http/http.dart' as http;

class RegistriesScreen extends StatefulWidget {
  @override
  _RegistriesScreenState createState() => _RegistriesScreenState();
}

class _RegistriesScreenState extends State<RegistriesScreen> {
  RegistryBloc _bloc;

  @override
  void initState() {
    _bloc = RegistryBloc(RegistryUninitialized());
    _bloc.add(RegistryLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de entradas/salidas'),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () => _filterByEmployee(context)),
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _filterByTimeRange(context)),
        ],
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, RegistryState state) {
          if (state is RegistryUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RegistryInitializing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RegistryLoading) {
            return buildTable(state.registries, false);
          }
          if (state is RegistryLoaded) {
            return buildTable(state.registries, true);
          }
          return Center(
            child: const Text('Ocurrió un error inesperado...'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.add(RegistryPopulate()),
        child: Icon(Icons.file_upload),
      ),
    );
  }

  List<DataRow> buildDataCells(List<Registry> registries) {
    return registries
        .map(
          (r) => DataRow(
            cells: <DataCell>[
              DataCell(
                Text(r.employeeName),
              ),
              DataCell(
                Icon(r.locationName == 'Entrada' ? Icons.login : Icons.logout),
              ),
              DataCell(
                Text(r.inTime.toString()),
              ),
            ],
          ),
        )
        .toList();
  }

  Widget buildTable(List<Registry> registries, bool isFinished) {
    return registries.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                !isFinished ? LinearProgressIndicator() : Container(),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: const Text(
                        'Empleado',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: const Text(
                        'Tipo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: const Text(
                        'Hora',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: buildDataCells(registries),
                )
              ],
            ),
          )
        : Center(
            child: const Text('No hay registros...'),
          );
  }

  void _filterByEmployee(BuildContext context) async {
    List<Employee> employeesList = [];
    var url = Uri.https(
        'menshen-firebase-default-rtdb.firebaseio.com', 'employees.json');
    var response = await http.get(url);
    var parsedEmployees = json.decode(response.body) as Map<String, dynamic>;
    parsedEmployees.forEach((key, value) {
      var e = Employee.fromJson(value);
      e = e.copyWith(id: key);
      employeesList.add(e);
    });
    var employee = await showDialog<Employee>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Seleccione un empleado'),
          children: employeesList
              .map((e) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, e);
                    },
                    child: Text(e.fullname),
                  ))
              .toList(),
        );
      },
    );
    if (employee != null) _bloc.add(RegistryFilterEmployee(employee: employee));
  }

  void _filterByTimeRange(BuildContext context) async {
    var range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (range != null) _bloc.add(RegistryFilterTimeRange(range: range));
  }
}
