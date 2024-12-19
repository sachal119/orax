import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:orax_assignment/controller/postController.dart';
import 'package:orax_assignment/view/shimmerLoading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final ScrollController _scrollController = ScrollController();

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    postController.fetchPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        postController.loadMorePosts();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Explore",
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Obx(() {
        if (postController.isLoading.value && postController.posts.isEmpty) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ShimmerLoading();
            },
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: postController.posts.length +
              (postController.isLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == postController.posts.length) {
              return const ShimmerLoading();
            }
            final post = postController.posts[index];
            final user = postController.users[post.userId];
            final username = '${user?.data?.firstName} ${user?.data?.lastName}';
            final profileImage = user?.data?.avatar ??
                "https://randomuser.me/api/portraits/men/1.jpg";

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for Profile and User Info
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/profile/${post.userId}');
                          ;
                        },
                        child: CircleAvatar(
                          radius: 24.r,
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            "20 Minutes ago",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.more_horiz, color: Colors.grey, size: 20.sp),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Title Section
                  Text(
                    post.title ?? "No title available",
                    style: TextStyle(fontSize: 15.sp, height: 1.5),
                  ),
                  SizedBox(height: 12.h),

                  // Post Image and Like/Comment Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column for Like and Comments
                      Column(
                        children: [
                          LikeButton(
                            size: 30.sp,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "3456", // Like count
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Icon(Icons.comment_outlined,
                              color: Colors.grey, size: 26.sp),
                          SizedBox(height: 5.h),
                          Text(
                            "254", // Comment count
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w), // Spacing between columns

                      // Right Expanded Section for Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: SizedBox(
                            height: 200.h,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://picsum.photos/800/800?random=$index",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Divider(
                  //   height: 30.h,
                  //   thickness: 0.5.h,
                  //   color: Colors.grey,
                  // ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
