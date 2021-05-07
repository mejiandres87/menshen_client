import 'dart:convert';
import 'package:menshen_client/models/employee.dart';
import 'package:http/http.dart' as http;

final _host = 'menshen-firebase-default-rtdb.firebaseio.com';

class EmployeeApiProvider {
  Future<List<Employee>> fetchAllEmployees() async {
    List<Employee> employeesList = [];
    var url = Uri.https(_host, 'employees.json');
    var response = await http.get(url);
    var parsedEmployees = json.decode(response.body) as Map<String, dynamic>;

    parsedEmployees.forEach((key, value) {
      var e = Employee.fromJson(value);
      e = e.copyWith(id: key);
      employeesList.add(e);
    });

    return employeesList;
  }
}
