import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menshen_client/blocs/registry_bloc.dart';
import 'package:menshen_client/blocs/utils/registry_event.dart';
import 'package:menshen_client/blocs/utils/registry_state.dart';
import 'package:menshen_client/models/registry.dart';

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
              children: [
                !isFinished ? LinearProgressIndicator() : Container(),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: const Text('Empleado'),
                    ),
                    DataColumn(
                      label: const Text('Tipo'),
                    ),
                    DataColumn(
                      label: const Text('Hora'),
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
}
