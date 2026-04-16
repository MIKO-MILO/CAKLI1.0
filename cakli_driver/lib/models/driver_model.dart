class Driver {
  final String id;
  final String name;
  final String email;
  final String phone;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '-',
    );
  }
}