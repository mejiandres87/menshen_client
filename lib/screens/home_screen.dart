import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menshen_client/screens/employees_screen.dart';
import 'package:menshen_client/screens/locations_screen.dart';
import 'package:menshen_client/widgets/menu_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToEmployees(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployeesScreen(),
      ),
    );
  }

  void _goToLocations(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocationsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              MenuItem(
                  navigateHandler: () => _goToEmployees(context),
                  icon: Icons.person,
                  title: 'Empleados'),
              MenuItem(
                  navigateHandler: () => _goToLocations(context),
                  icon: Icons.meeting_room,
                  title: 'Salas')
            ],
          ),
        ),
      ),
    );
  }
}
