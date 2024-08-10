import 'package:get/get.dart';
import 'package:movie_flix/application/dashboard/views/screens/dashboard_navigation.dart';
import 'package:movie_flix/application/detail_movie/views/selected_movie_page.dart';
import 'package:movie_flix/application/profile/views/screens/profile_page.dart';
import 'package:movie_flix/utils/app_routes.dart';

/// A class that defines and provides the routing configuration for the application.
///
/// The `AppPages` class contains a list of [GetPage] objects that map route names to
/// their corresponding page widgets. This configuration is used by GetX for managing
/// navigation and routing within the app.
///
/// The routes defined in this class correspond to different pages in the application,
/// such as the user profile page, the dashboard navigation, and the selected movie page.
///
/// Example usage:
/// 
/// ```dart
/// GetMaterialApp(
///   initialRoute: AppRoutes.userDashboard,
///   getPages: AppPages.pages,
/// );
/// ```
class AppPages {
  /// A list of [GetPage] objects that define the routes for the application.
  ///
  /// Each [GetPage] specifies a route name and the page widget to be displayed when
  /// that route is navigated to. The routes include:
  /// 
  /// - `AppRoutes.userProfile`: Maps to the [ProfilePage] widget.
  /// - `AppRoutes.userDashboard`: Maps to the [DashboardNavigation] widget.
  /// - `AppRoutes.selectedMovie`: Maps to the [SelectedMoviePage] widget.
  static final pages = [
    // Route for the user profile page.
    GetPage(
      name: AppRoutes.userProfile, 
      page: () => const ProfilePage(),
    ),

    // Route for the user dashboard navigation.
    GetPage(
      name: AppRoutes.userDashboard, 
      page: () => const DashboardNavigation(),
    ),

    // Route for the selected movie details page.
    GetPage(
      name: AppRoutes.selectedMovie, 
      page: () => const SelectedMoviePage(),
    ),
  ];
}
