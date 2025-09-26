import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String id, required String name, required String email, required String token, String? avatarUrl})
      : super(id: id, name: name, email: email, token: token, avatarUrl: avatarUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? json['access_token'] ?? '',
      avatarUrl: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'token': token,
    'avatar': avatarUrl,
  };
}
