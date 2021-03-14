import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/employee.dart';
import 'package:http/http.dart' as http;

class NewEmployeeScreen extends StatefulWidget {
  @override
  _NewEmployeeState createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployeeScreen> {
  final _idFocusNode = FocusNode();
  final _positionFocusNode = FocusNode();
  final _bloodTypeFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _employee = Employee(
      id: null,
      fullname: '',
      bloodType: '',
      idNumber: '',
      idType: 'CC',
      currentLocation: '',
      position: '');

  void _saveForm(BuildContext context) {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    var url = Uri.https(
        'menshen-firebase-default-rtdb.firebaseio.com', 'employees.json');
    http
        .post(url, body: json.encode(_employee))
        .then((value) => Navigator.of(context).pop());
  }

  String _emptyValidator(String input) {
    if (input.isEmpty) {
      return 'Este campo es oblicatorio';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Empleado'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _saveForm(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(labelText: 'Nombre Completo'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_idFocusNode);
                    },
                    onSaved: (value) {
                      _employee = _employee.copyWith(fullname: value);
                    },
                    validator: _emptyValidator),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Número de cédula'),
                  textInputAction: TextInputAction.next,
                  focusNode: _idFocusNode,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_positionFocusNode);
                  },
                  onSaved: (value) {
                    _employee = _employee.copyWith(idNumber: value);
                  },
                  validator: _emptyValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cargo'),
                  textInputAction: TextInputAction.next,
                  focusNode: _positionFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_bloodTypeFocusNode);
                  },
                  onSaved: (value) {
                    _employee = _employee.copyWith(position: value);
                  },
                  validator: _emptyValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tipo de Sangre'),
                  textInputAction: TextInputAction.send,
                  focusNode: _bloodTypeFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm(context);
                  },
                  onSaved: (value) {
                    _employee = _employee.copyWith(bloodType: value);
                  },
                  validator: _emptyValidator,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
