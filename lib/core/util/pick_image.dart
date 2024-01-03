import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  _logger.e('No Image Selected');
}
