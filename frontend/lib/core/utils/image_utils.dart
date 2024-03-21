import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imageLib;

/// ImageUtils
class ImageUtils {
  /// Converts a [CameraImage] in YUV420 format to [imageLib.Image] in RGB format
  static imageLib.Image convertYUV420ToImage(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int? uvPixelStride = cameraImage.planes[1].bytesPerPixel;

    final image = imageLib.Image(width, height);

    for (int w = 0; w < width; w++) {
      for (int h = 0; h < height; h++) {
        final int uvIndex =
            uvPixelStride! * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final int index = h * width + w;

        final y = cameraImage.planes[0].bytes[index];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data[index] = ImageUtils.yuv2rgb(y, u, v);
      }
    }
    return image;
  }

  /// Convert a single YUV pixel to RGB
  static int yuv2rgb(int y, int u, int v) {
    // Convert yuv pixel to rgb
    int r = (y + v * 1436 / 1024 - 179).round();
    int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    int b = (y + u * 1814 / 1024 - 227).round();

    // Clipping RGB values to be inside boundaries [ 0 , 255 ]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
    ((b << 16) & 0xff0000) |
    ((g << 8) & 0xff00) |
    (r & 0xff);
  }

  static Future<Uint8List> preprocessCameraImage(CameraImage cameraImage) async {
    // Convert YUV420 to RGB
    imageLib.Image image = convertYUV420ToImage(cameraImage);

    // Resize the image to the expected size e.g., 224x224
    imageLib.Image resizedImage = imageLib.copyResize(image, width: 224, height: 224);

    // Normalize pixel values and convert to Uint8List
    return imageToByteListInt8(resizedImage, 1 / 0.08743137, 128.0);
  }

  static Uint8List imageToByteListInt8(imageLib.Image image, double std, double mean) {
    var convertedBytes = Uint8List(1 * 224 * 224 * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (int i = 0; i < 224; i++) {
      for (int j = 0; j < 224; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imageLib.getRed(pixel) - mean) ~/ std;
        buffer[pixelIndex++] = (imageLib.getGreen(pixel) - mean) ~/ std;
        buffer[pixelIndex++] = (imageLib.getBlue(pixel) - mean) ~/ std;
      }
    }
    return convertedBytes;
  }
}