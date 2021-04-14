class Registry {
  final String id;
  final String employee;
  final String location;
  final DateTime inTime;

  Registry({this.id, this.employee, this.inTime, this.location});

  Registry.fromJson(Map<String, dynamic> json)
      : this.employee = json['employee'],
        this.id = json['id'],
        this.inTime =
            json['in_time'] == null ? null : DateTime.parse(json['in_time']),
        this.location = json['location'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'employee': this.employee,
        'location': this.location,
        'in_time': this.inTime.toIso8601String()
      };

  Registry coptWith(
      {String id, String employee, String location, DateTime inTime}) {
    return Registry(
        id: id ?? this.id,
        employee: employee ?? this.employee,
        location: location ?? this.location,
        inTime: inTime ?? this.inTime);
  }
}
