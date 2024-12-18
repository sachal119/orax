import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/postModel.dart';
import '../model/userModel.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  var posts = <PostModel>[].obs;
  var users = <int, UserModel>{}.obs;
  var page = 1.obs; // Track the current page

  // Method to fetch posts
  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        posts.addAll(List<PostModel>.from(
            jsonData.map((post) => PostModel.fromJson(post))));

        await fetchUsers(); // Fetch user details after posts
      } else {
        Get.snackbar("Error", "Failed to fetch posts: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to fetch more posts
  Future<void> loadMorePosts() async {
    page.value++; // Increment page number
    fetchPosts(); // Fetch more posts
  }

  // Method to fetch users (only fetch once for all users)
  Future<void> fetchUsers() async {
    try {
      final userIds =
          posts.map((post) => post.userId).toSet(); // Get unique userIds

      for (var userId in userIds) {
        final response =
            await http.get(Uri.parse('https://reqres.in/api/users/$userId'));
        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);

          // Add user data to the users map
          users[userId!] = UserModel.fromJson(jsonData);
        } else {}
      }
    } catch (e) {
      Get.snackbar(
          "Error", "An error occurred while fetching user details: $e");
    }
  }
}
