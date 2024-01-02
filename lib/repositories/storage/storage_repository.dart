import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';
import 'package:tuncjob/repositories/storage/base_storage_repository.dart';
import "package:firebase_storage/firebase_storage.dart" as fs;

class StorageRepository extends BaseStorageRepository {
  final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  @override
  Future<void> uploadImage(XFile image) async {
    try {
      log("Uploading...");
      await storage.ref("user_1/${image.name}").putFile(File(image.path)).then(
            (p0) => DatabaseStorage().updateUserPictures(image.name),
          );
      log("Uploaded!!");
    } catch (_) {}
  }

  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref("user_1/$imageName").getDownloadURL();
    return downloadUrl;
  }
}
