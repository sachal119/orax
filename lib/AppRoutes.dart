import 'package:get/get.dart';
import 'package:orax_assignment/view/explore.dart';
import 'package:orax_assignment/view/profile.dart';

class AppRoutes {
  static const String home = '/explore';

  static List<GetPage> routes = [
    GetPage(name: '/profile/:userId', page: () => ProfileScreen()),
    GetPage(
      name: home,
      page: () => ExploreScreen(),
    ),
  ];
}
