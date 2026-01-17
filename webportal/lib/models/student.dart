class Student {
  final String id;
  final String cameraId;
  final String fullName;
  final DateTime dateOfBirth;
  final String createdBy;
  final DateTime createdAt;
  final String? fatherName;
  final String? motherName;
  final String? phone;
  final String? address;
  final String? email;

  Student({
    required this.id,
    required this.cameraId,
    required this.fullName,
    required this.dateOfBirth,
    required this.createdBy,
    required this.createdAt,
    this.fatherName,
    this.motherName,
    this.phone,
    this.address,
    this.email,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cameraId': cameraId,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'fatherName': fatherName,
      'motherName': motherName,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }

  // Create from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      cameraId: json['cameraId'],
      fullName: json['fullName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
    );
  }

  // Calculate age
  int get age {
    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}

