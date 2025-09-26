import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;

  const Profile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
  });

  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, photoUrl];
}
