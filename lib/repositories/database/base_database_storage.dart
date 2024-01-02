import 'package:tuncjob/models/user_model.dart';

abstract class BaseDatabaseStorage {
  Stream<User> getUser(String userId);
  Future<String> createUser(User user);
  Future<void> updateUserPictures(String imageName, User user);
  Future<void> updateUser(User user);
}
