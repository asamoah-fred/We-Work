import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_work/models/profile_model.dart';

class FetcProfile {
  final CollectionReference profiles = Firestore.instance.collection("profile");
  String _uid;

  set setUid(String uid) {
    _uid = uid ?? null;
    // print(_uid);
  }

  Stream<ProfileModel> get profileStream {
    return profiles.document(_uid).snapshots().map(_profileList);
  }

  ProfileModel _profileList(DocumentSnapshot snapshot) {
    return ProfileModel.fromSnapshot(snapshot);
  }
}
