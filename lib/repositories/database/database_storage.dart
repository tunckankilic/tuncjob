import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncjob/models/user_model.dart';
import 'package:tuncjob/repositories/database/base_database_storage.dart';
import 'package:tuncjob/repositories/storage/storage_repository.dart';

class DatabaseStorage extends BaseDatabaseStorage {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((event) => User.fromSnapshot(event));
  }

  @override
  Future<void> updateUserPictures(String imageName, User user) async {
    String downloadUrl =
        await StorageRepository().getDownloadUrl(imageName, user);
    return _firebaseFirestore.collection("users").doc(user.id).update({
      "imageUrls": FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> updateUser(User user) {
    return _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .update(user.toMap())
        .then((value) {
      log("User Document Updated");
    });
  }

  @override
  Future<String> createUser(User user) async {
    String documentId = await _firebaseFirestore
        .collection("users")
        .add(user.toMap())
        .then((value) {
      log("User Added, ID: ${value.id}");
      return value.id;
    });
    return documentId;
  }
}
