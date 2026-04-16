class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '-',
      imageUrl:
          json['photo_profile_url'] ?? 'assets/images/setting/profile.png',
    );
  }

  String operator [](String other) => other == 'phone' ? phone : other;
}
