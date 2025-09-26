import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required String id,
    required String name,
    required String email,
    String? phone,
    String? photoUrl,
  }) : super(
    id: id,
    name: name,
    email: email,
    phone: phone,
    photoUrl: photoUrl,
  );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "photoUrl": photoUrl,
    };
  }
}
