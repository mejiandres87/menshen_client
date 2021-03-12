import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerScreen extends StatefulWidget {
  ScannerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _barcode = '';

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing');
    } else {
      setState(() {
        _barcode = barcode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_barcode),
            RaisedButton(
              child: Text('Start scan'),
              onPressed: _scan,
            )
          ],
        ),
      ),
    );
  }
}
