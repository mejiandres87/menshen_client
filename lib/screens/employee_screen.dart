import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'edit_employee_screen.dart';

class EmployeeScreen extends StatelessWidget {
  final Employee employee;

  EmployeeScreen(this.employee);

  void _goToEditEmployee(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditEmployeeScreen(employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(employee.fullname, textAlign: TextAlign.center),
          Text('${employee.idType} - ${employee.idNumber}',
              textAlign: TextAlign.center),
          Text(employee.position, textAlign: TextAlign.center),
          Text(employee.bloodType, textAlign: TextAlign.center),
          Center(
            child: QrImage(
              data:
                  '${employee.fullname}>>${employee.idType}>>${employee.idNumber}>>${employee.bloodType}>>${employee.position}>>${employee.id}',
              version: QrVersions.auto,
              size: 200,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToEditEmployee(context),
        child: Icon(Icons.edit),
      ),
    );
  }
}
