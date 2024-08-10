import 'package:get/get.dart';
import 'package:movie_flix/application/home/views/screens/home_page.dart';
import 'package:movie_flix/application/profile/views/screens/profile_page.dart';

/// A controller for managing the state and logic of the dashboard in the MovieFlix app.
///
/// The `DashboardController` handles navigation between the different tabs in the
/// bottom navigation bar of the dashboard. It tracks the currently selected tab index
/// and provides a list of the pages corresponding to each tab.
///
/// This controller uses `GetxController` for state management and `GetSingleTickerProviderStateMixin`
/// to provide the required [TickerProvider] for animations if needed.
///
/// Example usage:
/// 
/// ```dart
/// DashboardController controller = Get.put(DashboardController());
/// ```
class DashboardController extends GetxController with GetSingleTickerProviderStateMixin {
  /// The index of the currently selected tab.
  ///
  /// This is an observable value, so any UI element that depends on this value
  /// will automatically update when it changes.
  var currentIndex = 0.obs;

  /// A list of pages corresponding to each tab in the dashboard.
  ///
  /// This list is immutable and contains the pages that will be displayed
  /// when a particular tab is selected.
  final tabPage = const [
    HomePage(),
    ProfilePage()
  ];

  /// Updates the [currentIndex] when a tab is selected.
  ///
  /// The method checks if the selected index is not equal to 2 before updating the [currentIndex].
  /// This could be used to skip an index if needed.
  ///
  /// [index]: The index of the tab that was tapped.
  void onItemTapped(int index) {
    if (index != 2) {
      currentIndex.value = index;
    }
  }

  /// Called when the controller is initialized.
  ///
  /// This method is automatically called by GetX when the controller is first created.
  /// It is a good place to initialize any required data or state.
  @override
  void onInit() {
    super.onInit();
  }
}
