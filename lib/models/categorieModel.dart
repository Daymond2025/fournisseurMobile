class CatParams {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  CatParams({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CatParams.fromJson(Map<String, dynamic> json) {
    return CatParams(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
