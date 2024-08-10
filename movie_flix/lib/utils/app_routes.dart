/// A class that defines route names for the application.
///
/// The `AppRoutes` class contains constant string values that represent the route names
/// used throughout the application for navigation. These constants help ensure consistency
/// in route naming and prevent errors related to hardcoded route strings.
///
/// Route names:
/// 
/// - [userProfile]: Represents the route for the user profile page.
/// - [userDashboard]: Represents the route for the user dashboard page.
/// - [selectedMovie]: Represents the route for the selected movie details page.
///
/// Example usage:
/// 
/// ```dart
/// Get.toNamed(AppRoutes.userProfile);
/// ```
class AppRoutes {
  /// The route name for the user profile page.
  ///
  /// This route is used to navigate to the user profile page within the application.
  static const userProfile = '/userProfile';

  /// The route name for the user dashboard page.
  ///
  /// This route is used to navigate to the main dashboard page of the application.
  static const userDashboard = '/userDashboard';

  /// The route name for the selected movie details page.
  ///
  /// This route is used to navigate to the details page of a selected movie.
  static const selectedMovie = '/selectedMovie';
}
