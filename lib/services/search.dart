import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchData(String query) {
    return Firestore.instance
        .collection("jobs")
        .where('searchKey', arrayContains: query.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
