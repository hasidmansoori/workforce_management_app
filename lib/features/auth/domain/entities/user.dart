class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final String? avatarUrl;

  User({required this.id, required this.name, required this.email, required this.token, this.avatarUrl});
}
