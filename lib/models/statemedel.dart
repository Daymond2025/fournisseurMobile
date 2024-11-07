class StateParams {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  StateParams({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StateParams.fromJson(Map<String, dynamic> json) {
    return StateParams(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
