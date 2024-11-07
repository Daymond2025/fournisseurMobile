class PhoneData {
  final int id;
  final String phoneNumber;
  final String operator;
  final String createdAt;
  final String updatedAt;
  final String createdAtFr;
  final String updatedAtFr;

  PhoneData({
    required this.id,
    required this.phoneNumber,
    required this.operator,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  // Factory method to create a PhoneData instance from JSON
  factory PhoneData.fromJson(Map<String, dynamic> json) {
    return PhoneData(
      id: json['id'],
      phoneNumber: json['phone_number'],
      operator: json['operator'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  // Method to convert a PhoneData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'operator': operator,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}
