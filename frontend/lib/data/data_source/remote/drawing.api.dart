import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DrawingApi {
  File file;
  String filename;

  DrawingApi({
    required this.file,
    required this.filename,
  });

  /// Use the doodle model
  Future<String> drawingAI() async {
    var uri = Uri.https("j10c101.p.ssafy.io", "ai/analyze/drawing");

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri)
      ..fields['filename'] = filename // Assuming the API expects a filename field
      ..files.add(await http.MultipartFile.fromPath('file', file.path, filename: filename)); // 'file' is the field name for the file

    // Send the request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Assuming your error message structure, adjust if needed
      String msg = json.decode(response.body)['detail'];
      return msg;
    }
  }
}

