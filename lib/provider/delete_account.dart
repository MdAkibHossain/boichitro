import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/secure_storage_service.dart';

class DeleteAccountProvider with ChangeNotifier {
  Future<void> deleteAccount() async {
    try {
      var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
      print(token);
      final url =
          Uri.parse('https://boichitro.com.bd/api/v1/auth/account/delete/');
      final response = await http.delete(url, headers: {
        'Authorization': 'Token $token',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Resource deleted successfully');
      } else {
        print('Failed to delete resource. Status code: ${response.statusCode}');
        throw Exception('failed to delete');
      }
    } catch (e) {
      print('Error occurred while deleting resource: $e');
    }
  }
}
