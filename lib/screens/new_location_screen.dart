import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/models/location.dart';
import 'package:http/http.dart' as http;

class NewLocationScreen extends StatefulWidget {
  @override
  _NewLocationScreenState createState() => _NewLocationScreenState();
}

class _NewLocationScreenState extends State<NewLocationScreen> {
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _location = Location(
    id: null,
    name: '',
    description: '',
  );

  void _saveForm(BuildContext context) {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    var url = Uri.https(
        'menshen-firebase-default-rtdb.firebaseio.com', 'locations.json');
    http
        .post(url, body: json.encode(_location))
        .then((value) => Navigator.of(context).pop());
  }

  String _emptyValidator(String input) {
    if (input.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva sala'),
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
                  decoration: InputDecoration(labelText: 'Nombre'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _location = _location.copyWith(name: value);
                  },
                  validator: _emptyValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descripción'),
                  textInputAction: TextInputAction.send,
                  focusNode: _descriptionFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm(context);
                  },
                  onSaved: (value) {
                    _location = _location.copyWith(description: value);
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
