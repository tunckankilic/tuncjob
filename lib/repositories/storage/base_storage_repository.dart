import 'package:image_picker/image_picker.dart';
import 'package:tuncjob/models/user_model.dart';

abstract class BaseStorageRepository {
  Future<void> uploadImage(XFile image, User user);
  Future<String> getDownloadUrl(String imageName, User user);
}
