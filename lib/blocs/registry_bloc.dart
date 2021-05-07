import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menshen_client/blocs/utils/registry_event.dart';
import 'package:menshen_client/blocs/utils/registry_state.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:menshen_client/resources/repository.dart';

class RegistryBloc extends Bloc<RegistryEvent, RegistryState> {
  final _repository = Repository();

  RegistryBloc(RegistryState initialState) : super(initialState);

  @override
  Stream<RegistryState> mapEventToState(RegistryEvent event) async* {
    if (event is RegistryLoad) {
      yield RegistryInitializing();
      var state = RegistryLoading();
      var employees = await _repository.fetchEmployees();
      if (employees != null) {
        var registries = <Registry>[];
        for (Employee e in employees) {
          Registry r = await _repository.fetchLastEmployeeRegistry(e);
          if (r != null) {
            registries.add(r);
            state = state.copyWith(registries: registries);
            yield state;
          }
        }
        yield RegistryLoaded(registries: registries);
      } else {
        yield RegistryError();
      }
    }
    if (event is RegistryPopulate) {
      if (state is RegistryLoaded) {
        var currentState = state as RegistryLoaded;
        yield RegistryLoading(registries: currentState.registries);
      }
      if (state is RegistryError) {
        yield RegistryInitializing();
      }
      var employees = await _repository.fetchEmployees();
      if (employees != null) {
        var randy = Random();
        var locations = await _repository.fetchLocations();
        if (locations != null) {
          for (Employee e in employees) {
            Location l = locations[randy.nextInt(locations.length)];
            Registry r = Registry(
              location: l.id,
              locationName: l.name,
              inTime: DateTime.now().subtract(Duration(
                days: randy.nextInt(5),
                hours: randy.nextInt(12),
              )),
            );
            await _repository.createRegistry(e, r);
          }
        }
      }
      if (state is RegistryLoading) {
        var currentState = state as RegistryLoading;
        yield RegistryLoaded(registries: currentState.registries);
      }
      if (state is RegistryInitializing) {
        yield RegistryLoaded(registries: const []);
      }
    }
  }
}
