import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/services/database.dart';

class JobsProvider with ChangeNotifier {
  String uid;
  DocumentReference jobRef;
  Queries queries = new Queries();

  CollectionReference user = Firestore.instance.collection("users");
  bool _hasApplied = false;
  bool get hasApplied => _hasApplied;

  set checkApplied(bool applicationStatus) {
    _hasApplied = applicationStatus;
    notifyListeners();
  }

  saveJob(User user, DocumentReference jobRef) async {
    queries.saveJob(user.uid, jobRef);
  }
}
