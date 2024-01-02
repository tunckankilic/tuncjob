import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncjob/models/user_model.dart';
import 'package:tuncjob/repositories/database/base_database_storage.dart';
import 'package:tuncjob/repositories/storage/storage_repository.dart';

class DatabaseStorage extends BaseDatabaseStorage {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection("users")
        .doc("4C9xcqar58jtY5TFnwLm")
        .snapshots()
        .map((event) => User.fromSnapshot(event));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);
    return _firebaseFirestore
        .collection("users")
        .doc("4C9xcqar58jtY5TFnwLm")
        .update({
      "imageUrls": FieldValue.arrayUnion([downloadUrl])
    });
  }
}
