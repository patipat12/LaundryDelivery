import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testdb/models/user.dart';


class ApiService {
  static const String url = 'https://www.androidthai.in.th/fluttertraining/few/getUserProfile.php?'; // Replace with your server URL

  static Future<User?> fetchUserProfile() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
