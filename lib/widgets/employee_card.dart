import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:menshen_client/screens/employee_screen.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({@required this.employee});

  void _navigateToEmployeescreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployeeScreen(employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToEmployeescreen(context),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(employee.fullname),
              subtitle: Text('${employee.idType} - ${employee.idNumber}'),
            )
          ],
        ),
      ),
    );
  }
}
