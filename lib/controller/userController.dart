import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/userModel.dart';

class UserController extends GetxController {
  var isLoading = false.obs; // Loading state
  var user = UserModel().obs; // User data

  // Method to fetch user details by ID
  Future<void> fetchUserById(int userId) async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        user.value = UserModel.fromJson(jsonData);
      } else {
        Get.snackbar("Error", "Failed to fetch user: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
