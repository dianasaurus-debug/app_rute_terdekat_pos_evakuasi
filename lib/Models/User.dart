import 'dart:convert';
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String address;

  User({required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json['id'],
      name : json['name'],
      username :json['username'],
      email : json['email'],
      password :json['password'],
      phone : json['phone'],
      address :json['address'],
    );
  }
}
