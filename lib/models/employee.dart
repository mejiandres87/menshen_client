class Employee {
  final String id;
  final String fullname;
  final String idType;
  final String idNumber;
  final String bloodType;
  final String position;
  final String currentLocation;

  const Employee(
      {this.id,
      this.bloodType,
      this.currentLocation,
      this.fullname,
      this.idNumber,
      this.idType,
      this.position});

  Employee.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.bloodType = json['blood_type'],
        this.currentLocation = json['current_location'],
        this.fullname = json['fullname'],
        this.idNumber = json['id_number'],
        this.idType = json['id_type'],
        this.position = json['position'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'blood_type': this.bloodType,
        'current_location': this.currentLocation,
        'fullname': this.fullname,
        'id_number': this.idNumber,
        'id_type': this.idType,
        'position': this.position,
      };

  Employee copyWith(
      {String id,
      String fullname,
      String bloodType,
      int currentLocation,
      String idType,
      String idNumber,
      String position}) {
    return Employee(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        currentLocation: currentLocation ?? this.currentLocation,
        idNumber: idNumber ?? this.idNumber,
        idType: idType ?? this.idType,
        bloodType: bloodType ?? this.bloodType,
        position: position ?? this.position);
  }
}
