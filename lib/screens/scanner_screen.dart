import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:menshen_client/models/location.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:http/http.dart' as http;

class ScannerScreen extends StatefulWidget {
  ScannerScreen({Key key, this.location}) : super(key: key);

  final Location location;

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _id = '';
  String _fullname = '';
  String _idType = '';
  String _idNumber = '';
  String _position = '';
  String _bloodType = '';
  String _timestamp = '';

  Future<void> scanQR() async {
    String barCodeScanRes;

    try {
      barCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      print(barCodeScanRes);
    } on PlatformException {
      barCodeScanRes = 'Failed to get platform version';
    }

    if (!mounted) return;

    if (barCodeScanRes.contains('>>')) {
      var splittedString = barCodeScanRes.split('>>');
      setState(() {
        _fullname = splittedString[0];
        _idType = splittedString[1];
        _idNumber = splittedString[2];
        _bloodType = splittedString[3];
        _position = splittedString[4];
        _id = splittedString[5];
        _timestamp = DateTime.now().toIso8601String();
      });
      var registry = Registry(
          location: widget.location.id,
          inTime: DateTime.now(),
          locationName: widget.location.name);
      var url = Uri.https('menshen-firebase-default-rtdb.firebaseio.com',
          '/employees/$_id/registries.json');
      http.post(url, body: json.encode(registry));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Nombre completo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_fullname),
            Text(
              'Identificación',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('$_idType $_idNumber'),
            Text(
              'Cargo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_position),
            Text(
              'Grupo Sanguíneo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_bloodType),
            Text(
              'Fecha de registro',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_timestamp),
            ElevatedButton(
              onPressed: () => scanQR(),
              child: Text('Scan'),
            )
          ],
        ),
      ),
    );
  }
}
