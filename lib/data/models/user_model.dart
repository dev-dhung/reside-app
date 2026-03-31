import 'package:prototype/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String apartment;
  final String tower;
  final bool isAdmin;
  final bool isSolvent;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.apartment,
    required this.tower,
    this.isAdmin = false,
    this.isSolvent = false,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      apartment: json['apartment'] as String,
      tower: json['tower'] as String,
      isAdmin: json['isAdmin'] as bool? ?? false,
      isSolvent: json['isSolvent'] as bool? ?? false,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      apartment: user.apartment,
      tower: user.tower,
      isAdmin: user.isAdmin,
      isSolvent: user.isSolvent,
      avatarUrl: user.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'apartment': apartment,
      'tower': tower,
      'isAdmin': isAdmin,
      'isSolvent': isSolvent,
      'avatarUrl': avatarUrl,
    };
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      apartment: apartment,
      tower: tower,
      isAdmin: isAdmin,
      isSolvent: isSolvent,
      avatarUrl: avatarUrl,
    );
  }
}
