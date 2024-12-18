import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Follow button state
  RxBool isFollowing = false.obs;

  // Dummy list of photo URLs
  RxList<String> photos = <String>[
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
    'https://picsum.photos/200/300?random=4',
    'https://picsum.photos/200/300?random=5',
    'https://picsum.photos/200/300?random=6',
    'https://picsum.photos/200/300?random=7',
    'https://picsum.photos/200/300?random=8',
    'https://picsum.photos/200/300?random=9',
  ].obs;

  // Toggle Follow state
  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }
}
