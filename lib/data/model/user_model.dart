import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String image;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(id: $id, username: $username, email: $email, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.image == image;
  }

  @override
  int get hashCode =>
      id.hashCode ^ username.hashCode ^ email.hashCode ^ image.hashCode;
}
