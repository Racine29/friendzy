import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageService {
  static double ratioX = 9;
  static double ratioY = 11;

  Future<CroppedFile?> _rognerLimage({
    required String imagePath,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          showCropGrid: false,
          statusBarColor: Colors.black,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          hidesNavigationBar: false,
        ),
      ],
    );
    return croppedFile;
  }

  Future<XFile?> selectionnerUneImage() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (result != null) {
      final imgResult = result.path;
      final cropImg = await _rognerLimage(imagePath: imgResult);

      if (cropImg != null) {
        final imgPath = cropImg.path;
        final imgPathCache = imgPath.substring(0, imgPath.lastIndexOf("/"));

        try {
          final imgOriginalSize = await result.length();
          int quality = 0;

          if (imgOriginalSize > 0 && imgOriginalSize < 500) {
            quality = 70;
          } else if (imgOriginalSize > 500 && imgOriginalSize < 1000) {
            quality = 65;
          } else if (imgOriginalSize > 1000 && imgOriginalSize < 2000) {
            quality = 60;
          } else if (imgOriginalSize > 2000 && imgOriginalSize < 3000) {
            quality = 50;
          } else if (imgOriginalSize > 3000 && imgOriginalSize < 5000) {
            quality = 45;
          } else {
            quality = 40;
          }

          return await FlutterImageCompress.compressAndGetFile(
              imgPath, "$imgPathCache/${result.name.split(".")[0]}.jpg",
              quality: quality);
        } catch (e) {
          rethrow;
        }
      }
    }
    return null;
  }
}
