class Location {
  final int id;
  final String name;
  final String description;

  const Location({
    this.id,
    this.name,
    this.description,
  });

  Location.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'] ?? '',
        this.description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'description': this.description,
      };

  Location copyWith({
    int id,
    String name,
    String description,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
