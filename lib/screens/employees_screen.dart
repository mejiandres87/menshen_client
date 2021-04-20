import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/screens/new_employee_screen.dart';
import 'package:menshen_client/widgets/employee_card.dart';
import 'package:http/http.dart' as http;

class EmployeesScreen extends StatefulWidget {
  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  List<Employee> employees = [];
  bool isLoading = false;
  @override
  void initState() {
    _loadEmployees();
    super.initState();
  }

  Future<void> _loadEmployees() async {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
      employees = employeesList;
    });
  }

  void _goToNewEmployee(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewEmployeeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empleados'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadEmployees,
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  return EmployeeCard(employees[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNewEmployee(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
