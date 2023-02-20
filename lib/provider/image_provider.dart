import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    StateNotifierProvider<ImageProvider, XFile?>((ref) => ImageProvider(null));

class ImageProvider extends StateNotifier<XFile?> {
  ImageProvider(super._state);

  void imageSelect() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    state = await _picker.pickImage(source: ImageSource.gallery);
  }
}
