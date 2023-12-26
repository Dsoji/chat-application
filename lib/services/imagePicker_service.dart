import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      return pickedFile;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
