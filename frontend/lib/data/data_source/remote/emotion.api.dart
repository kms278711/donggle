import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class EmotionApi {
  File file;
  String filename;

  EmotionApi({
    required this.file,
    required this.filename,
  });

  Future<String> emotionAI() async {
    var uri = Uri.https("j10c101.p.ssafy.io", "ai/analyze/emotions");

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

