import 'package:tuncjob/models/user_model.dart';

abstract class BaseDatabaseStorage {
  Stream<User> getUser();
  Future<void> updateUserPictures(String imageName);
}
