import 'package:equatable/equatable.dart';

class Registry extends Equatable {
  final String id;
  final String location;
  final String locationName;
  final DateTime inTime;
  final String employeeName;

  Registry(
      {this.id,
      this.inTime,
      this.location,
      this.locationName,
      this.employeeName});

  Registry.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.locationName = json['location_name'],
        this.inTime =
            json['in_time'] == null ? null : DateTime.parse(json['in_time']),
        this.location = json['location'],
        this.employeeName = json['employee_name'];

  @override
  List<Object> get props => [id, location, inTime, employeeName];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'location': this.location,
        'location_name': this.locationName,
        'in_time': this.inTime.toIso8601String()
      };

  Registry coptWith({
    String id,
    String employeeName,
    String location,
    DateTime inTime,
    String locationName,
  }) {
    return Registry(
        id: id ?? this.id,
        locationName: locationName ?? this.locationName,
        location: location ?? this.location,
        inTime: inTime ?? this.inTime,
        employeeName: employeeName ?? this.employeeName);
  }
}
