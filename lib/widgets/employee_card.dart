import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({@required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(employee.fullname),
            subtitle: Text('${employee.idType} - ${employee.idNumber}'),
          )
        ],
      ),
    );
  }
}
