import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final DocumentReference proifileRef;
  final String fullName;
  final String email;
  final String experience;
  final String github;
  final String resume;
  final String phone;
  final String dateCreated;

  ProfileModel({
    this.proifileRef,
    this.fullName,
    this.email,
    this.resume,
    this.experience,
    this.github,
    this.phone,
    this.dateCreated,
  });

  factory ProfileModel.fromSnapshot(DocumentSnapshot profile) {
    return ProfileModel(
      proifileRef: profile.reference,
      fullName: profile.data['name'] ?? "",
      email: profile.data['email'] ?? "",
      experience: profile.data['experience'] ?? "",
      dateCreated: profile.data['date_reated'] ?? "",
      phone: profile.data['phone'] ?? "",
      github: profile.data['githublink'] ?? "",
      resume: profile.data['resume'] ?? "",
    );
  }
}
