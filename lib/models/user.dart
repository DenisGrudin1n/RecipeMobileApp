import 'package:cloud_firestore/cloud_firestore.dart';

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

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot['username'],
        email: snapshot['email'],
        password: snapshot['password'],
        uid: snapshot['uid']);
  }
}
