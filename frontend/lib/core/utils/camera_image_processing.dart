import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class CameraImageProcessing {
  static Future<bool> saveImageToDevice(XFile imageFile) async {
    try {
      // Get the directory to save the image
      final String dir = (await getApplicationDocumentsDirectory()).path;

      // Create a new file path
      final File newFile = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");

      // Copy the image file to the new path
      await imageFile.saveTo(newFile.path);

      // Optionally, save to the gallery
      final result = await ImageGallerySaver.saveFile(newFile.path);
      return result['isSuccess'] ?? false;
    } catch (e) {
      debugPrint("Error saving image: $e");
      return false;
    }
  }

  static Future<void> saveImageData(XFile image) async {
    if (image == null) {
      showToast('오류가 났어요:(', backgroundColor: AppColors.error);
      return;
    }
    final result = await saveImageToDevice(image);
    if (result) {
      showToast("그림이 갤러리에 저장되었습니다!");
    } else {
      showToast("그림 저장이 실패했어요:(", backgroundColor: AppColors.error);
    }
  }

  static Future<File> getImageData(XFile image) async {
    File file = File(image.path);
    return file;
  }
}
