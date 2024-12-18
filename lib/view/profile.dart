import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

import '../controller/profileController.dart';
import '../controller/userController.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final int userId = int.parse(Get.parameters['userId']!);

    userController.fetchUserById(userId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          // Shimmer effect while loading
          return _buildShimmerEffect();
        }

        final user = userController.user.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(user.data!.avatar ??
                  'https://randomuser.me/api/portraits/men/11.jpg'),
            ),
            const SizedBox(height: 8),
            Text(
              '${user.data!.firstName} ${user.data!.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user.data!.email ?? 'No email available',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatColumn('438', 'Posts'),
                _buildStatColumn('298', 'Following'),
                _buildStatColumn('321K', 'Followers'),
              ],
            ),
            const SizedBox(height: 16),

            // Follow and Message Buttons
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Follow Button
                    ElevatedButton(
                      onPressed: controller.toggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isFollowing.value
                            ? Colors.white
                            : Color(0xFF6C63FF), // Button color (Light Purple)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // Rounded corners
                          side: BorderSide(
                            color: controller.isFollowing.value
                                ? Color(0xFF6C63FF)
                                : Colors.transparent, // Border color
                          ),
                        ),
                        elevation: 0, // Remove button shadow
                      ),
                      child: Text(
                        controller.isFollowing.value ? 'Following' : 'Follow',
                        style: TextStyle(
                          color: controller.isFollowing.value
                              ? Color(0xFF6C63FF) // Text color (Light Purple)
                              : Colors.white, // White text
                          fontWeight: FontWeight.w500, // Semi-bold text
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Message Button
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        side: const BorderSide(
                          color: Color(0xFF6C63FF), // Border color
                          width: 1, // Thin border
                        ),
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(
                          color: Colors.black87, // Dark text
                          fontWeight: FontWeight.w500, // Semi-bold text
                        ),
                      ),
                    ),
                  ],
                )),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Photos',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.list_outlined,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.grid_view,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),

            // Photo Grid
            Expanded(
              child: Obx(() => GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.photos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.photos[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  )),
            ),
          ],
        );
      }),
    );
  }

  // Shimmer effect widget
  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Shimmer for stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildShimmerStatColumn(),
              _buildShimmerStatColumn(),
              _buildShimmerStatColumn(),
            ],
          ),
          const SizedBox(height: 16),

          // Shimmer for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Shimmer for photo grid
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 9,
            // Placeholder item count
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Shimmer for stat column
  Widget _buildShimmerStatColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Container(
              width: 30,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Container(
              width: 50,
              height: 10,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // Widget for stats column
  Widget _buildStatColumn(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
