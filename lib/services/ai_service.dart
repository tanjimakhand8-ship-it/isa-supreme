import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class AIService {
  static const String baseUrl = String.fromEnvironment('BACKEND_URL', defaultValue: 'http://localhost:5000');
  static const String masterPassword = String.fromEnvironment('MASTER_PASSWORD', defaultValue: 'master123');

  Future<String> ask(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ask'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message, 'master_password': masterPassword}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body)['reply'];
    return 'Error: ${response.statusCode}';
  }

  Future<String> sendFile(String message, File file) async {
    var uri = Uri.parse('$baseUrl/ask_file');
    var request = http.MultipartRequest('POST', uri);
    request.fields['message'] = message;
    request.fields['master_password'] = masterPassword;
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    request.files.add(await http.MultipartFile.fromPath('file', file.path, contentType: MediaType.parse(mimeType)));
    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);
    if (resp.statusCode == 200) return jsonDecode(resp.body)['reply'];
    return 'Error: ${resp.statusCode}';
  }
}
