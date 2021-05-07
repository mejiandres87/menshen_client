import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:menshen_client/resources/employee_api_provider.dart';
import 'package:menshen_client/resources/location_api_provider.dart';
import 'package:menshen_client/resources/registry_api_provider.dart';

class Repository {
  final _employeeApiProvider = EmployeeApiProvider();
  final _registryApiProvider = RegistryApiProvider();
  final _locationApiProvider = LocationApiProvider();

  Future<List<Employee>> fetchEmployees() async {
    return _employeeApiProvider.fetchAllEmployees();
  }

  Future<List<Registry>> fetchRegistriesForEmployee(Employee employee) async {
    return _registryApiProvider.fetchRegistriesForEmployee(employee);
  }

  Future<List<Registry>> fetchRegistriesForEmployeeWithinTimeRange(
      Employee employee, DateTimeRange range) async {
    return _registryApiProvider.fetchRegistriesForEmployeeWithinTimeRange(
        employee, range);
  }

  Future<Registry> fetchLastEmployeeRegistry(Employee employee) async {
    return _registryApiProvider.fetchLastRegistry(employee);
  }

  Future<bool> createRegistry(Employee employee, Registry registry) async {
    return _registryApiProvider.createRegistry(employee, registry);
  }

  Future<List<Location>> fetchLocations() async {
    return _locationApiProvider.fetchLocations();
  }
}
