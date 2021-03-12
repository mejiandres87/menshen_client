import 'package:flutter/cupertino.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/widgets/employee_card.dart';

class EmployeesScreen extends StatefulWidget {
  final List<Employee> employees;

  EmployeesScreen({@required this.employees});

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.employees.length,
        itemBuilder: (BuildContext context, int index) {
          return EmployeeCard(employee: widget.employees[index]);
        });
  }
}
