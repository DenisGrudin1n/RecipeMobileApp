class User {
  final String username;
  final String email;
  final String password;
  final String uid;

  const User({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "uid": uid,
      };
}
