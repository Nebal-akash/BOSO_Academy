import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  int points;
  String profilePic;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.points,
    required this.profilePic,
  });

  // Convert UserModel to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'points': points,
      'profilePic': profilePic,
    };
  }

  // Create UserModel from Firestore DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      uid: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      points: data['points'] ?? 0,
      profilePic: data['profilePic'] ?? '',
    );
  }
}
