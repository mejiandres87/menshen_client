import 'package:flutter/material.dart';
import 'package:menshen_client/models/registry.dart';

class RegistryCard extends StatelessWidget {
  final Registry registry;

  RegistryCard(this.registry);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(registry.inTime.toIso8601String()),
      trailing:
          Icon(registry.locationName == 'Entrada' ? Icons.login : Icons.logout),
    );
  }
}
