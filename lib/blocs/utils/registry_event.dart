import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistryEvent extends Equatable {
  RegistryEvent([List props = const []]) : super();

  @override
  List<Object> get props => const [];
}

class RegistryLoad extends RegistryEvent {
  @override
  String toString() {
    return 'RegistryLoad';
  }
}

class RegistryFilterTimeRange extends RegistryEvent {
  final DateTimeRange range;

  RegistryFilterTimeRange({@required this.range}) : super([range]);

  @override
  String toString() {
    return 'RegistryFilterTimeRange { range : $range }';
  }
}

class RegistryFilterEmployee extends RegistryEvent {
  final String employeeId;

  RegistryFilterEmployee({@required this.employeeId}) : super([employeeId]);

  @override
  String toString() {
    return 'RegistryFilterEmployee {employeeId : $employeeId }';
  }
}

//Dummy Event to add info to registries
class RegistryPopulate extends RegistryEvent {
  @override
  String toString() {
    return 'RegistryPopulate';
  }
}
