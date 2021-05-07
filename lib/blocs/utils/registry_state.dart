import 'package:equatable/equatable.dart';
import 'package:menshen_client/models/registry.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistryState extends Equatable {
  RegistryState([List props = const []]) : super();

  @override
  List<Object> get props => const [];
}

class RegistryUninitialized extends RegistryState {
  @override
  String toString() {
    return 'RegistryUninitialized';
  }
}

class RegistryError extends RegistryState {
  @override
  String toString() {
    return 'RegistryError';
  }
}

class RegistryInitializing extends RegistryState {
  @override
  String toString() {
    return 'RegistryInitializing';
  }
}

class RegistryLoading extends RegistryState {
  final List<Registry> registries;
  RegistryLoading({this.registries}) : super([registries]);

  RegistryLoading copyWith({List<Registry> registries}) {
    return RegistryLoading(registries: registries ?? this.registries);
  }

  @override
  String toString() {
    return 'RegistryLoading { registries: ${registries?.length} }';
  }
}

class RegistryLoaded extends RegistryState {
  final List<Registry> registries;
  RegistryLoaded({this.registries}) : super([registries]);

  RegistryLoaded copyWith({List<Registry> registries}) {
    return RegistryLoaded(registries: registries ?? this.registries);
  }

  @override
  String toString() {
    return 'RegistryLoaded { registries: ${registries?.length} }';
  }
}
