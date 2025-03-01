import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For debugging logs

class APIService {
  // Adjust base URL based on environment (Emulator vs Physical Device)
  static String _baseUrl = kIsWeb
      ? "http://localhost:5000" // Web testing
      : Platform.isAndroid
      ? "http://10.0.2.2:5000" // Android emulator
      : "http://127.0.0.1:5000"; // iOS simulator or physical device

  static const Duration timeoutDuration = Duration(seconds: 10); // Timeout duration

  /// Summarizes plain text
  static Future<String> summarizeText(String text) async {
    final Uri url = Uri.parse("$_baseUrl/summarize");

    try {
      final response = await http
          .post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}),
      )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse["summary"] ?? "No summary available.";
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } on SocketException {
      return "No internet connection or server unreachable.";
    } on HttpException {
      return "Invalid response from server.";
    } on http.ClientException {
      return "Server connection issue.";
    } on IOException {
      return "File error occurred.";
    } catch (e) {
      return "Failed to summarize text: $e";
    }
  }

  /// Summarizes a PDF file
  static Future<String> summarizePDF(String filePath) async {
    final Uri url = Uri.parse("$_baseUrl/summarize_pdf");

    try {
      File file = File(filePath);
      if (!await file.exists()) {
        return "Error: File not found at path: $filePath";
      }

      var request = http.MultipartRequest("POST", url)
        ..files.add(await http.MultipartFile.fromPath("file", filePath));

      final response = await request.send().timeout(timeoutDuration);
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return jsonResponse["summary"] ?? "No summary available.";
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } on SocketException {
      return "No internet connection or server unreachable.";
    } on HttpException {
      return "Invalid response from server.";
    } on http.ClientException {
      return "Server connection issue.";
    } on IOException {
      return "File error occurred.";
    } catch (e) {
      return "Failed to summarize PDF: $e";
    }
  }
}
