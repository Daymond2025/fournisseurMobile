class VilleParams {
  final int id;
  final String? name;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  VilleParams({
    required this.id,
    this.name,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory VilleParams.fromJson(Map<String, dynamic> json) {
    // print(json);
    return VilleParams(
      id: json['id'],
      name: json['name'] != null ? json['name'] : '',
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
