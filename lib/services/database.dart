import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

final _firestore = Firestore.instance;

class Queries {
  final CollectionReference profile = _firestore.collection("profile");
  final CollectionReference applications =
      _firestore.collection("applications");
  final CollectionReference saved = _firestore.collection("saved_jobs");

  Future<void> createprofile(
      _uid, _name, _email, _phone, _experience, _githublink, _resume) async {
    var result = await _firestore.collection('profile').document(_uid).setData({
      'name': _name,
      'email': _email,
      'phone': _phone,
      'experience': _experience,
      'githublink': _githublink,
      'resume': _resume,
      'active': true,
      'date_created': FieldValue.serverTimestamp()
    });
    return result;
  }

  Future updataProfile(String uid, String _name, String _email, String _phone,
      String _experience, String _githublink, String _resume) async {
    try {
      await Firestore.instance
          .collection("profile")
          .document(uid)
          .updateData({
            'name': _name,
            'email': _email,
            'phone': _phone,
            'experience': _experience,
            'githublink': _githublink,
            'resume': _resume,
          })
          .then((value) => true)
          .catchError((error) => throw new PlatformException(
              code: "UPADATE_FAILED", message: "Unable to update"));
      return true;
    } on PlatformException catch (e) {
      return e.code;
    }
  }

  Future<Stream<QuerySnapshot>> checkApplicationExist(
      String uid, DocumentReference jobRef) async {
    return applications
        .where('profile_ref', isEqualTo: profile.document(uid))
        .where('jobref', isEqualTo: jobRef)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> checkSavedExist(
      String uid, DocumentReference jobRef) async {
    return saved
        .where('profile_ref', isEqualTo: profile.document(uid))
        .where('jobref', isEqualTo: jobRef)
        .snapshots();
  }

  Future addApplication(String uid, DocumentReference jobRef) async {
    try {
      _firestore.collection('applications').add({
        'profile_ref': profile.document(uid),
        'jobref': jobRef,
        'apply_date': FieldValue.serverTimestamp(),
        'status': 'pending',
      }).then((value) => print("Application submitted"));
    } on PlatformException catch (e) {
      print(
          "ADD APPLICATION 2   <<<<<<================= ${e.message} ===============>>>>>>");
      return e.message;
    }
  }

  Future withDrawAppication(String uid, DocumentReference jobRef) async {
    try {
      QuerySnapshot application = await applications
          .where('profile_ref', isEqualTo: profile.document(uid))
          .where('jobref', isEqualTo: jobRef)
          .getDocuments();
      application.documents[0].reference
          .delete()
          .then((value) => print("Application widrawn"));
    } on PlatformException catch (e) {
      print(
          "UNSAVE JOB EXCEPTION   <<<<<<================= ${e.message} ===============>>>>>>");
      return e.message;
    }
  }

  Future saveJob(String uid, DocumentReference jobRef) async {
    try {
      return _firestore
          .collection('saved_jobs')
          .add({
            'profile_ref': profile.document(uid),
            'jobref': jobRef,
            'save_date': FieldValue.serverTimestamp(),
          })
          .then((value) => print("Job saved"))
          .catchError((onError) => throw new PlatformException(
              code: onError.code, message: onError.message));
    } on PlatformException catch (e) {
      print(
          "SAVE JOB FAILED   <<<<<<================= ${e.message} ===============>>>>>>");
      return e.message;
    }
  }

  Future unSaveJob(String uid, DocumentReference jobRef) async {
    try {
      QuerySnapshot savedJob = await saved
          .where('profile_ref', isEqualTo: profile.document(uid))
          .where('jobref', isEqualTo: jobRef)
          .getDocuments();
      savedJob.documents[0].reference
          .delete()
          .then((value) => print("Job unsaved..."));
    } on PlatformException catch (e) {
      print(
          "UNSAVE JOB EXCEPTION   <<<<<<================= ${e.message} ===============>>>>>>");
      return e.message;
    }
  }
}
