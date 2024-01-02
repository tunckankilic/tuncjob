import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:tuncjob/repositories/storage/storage_repository.dart';

class CustomImageContainer extends StatelessWidget {
  final String? imageUrl;
  const CustomImageContainer({
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            top: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            right: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: imageUrl == null
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () async {
                    ImagePicker _imagePicker = ImagePicker();
                    final XFile? image = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          "No image has been selected",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ));
                    }
                    image != null
                        ? StorageRepository().uploadImage(image)
                        : null;
                  },
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
