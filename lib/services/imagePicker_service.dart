// ignore_for_file: file_names

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      return pickedFile;
    } catch (e) {
      _logger.e('Error picking image: $e');
      return null;
    }
  }
}
