import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/dashboard/controllers/dashboard_controller.dart';
import 'package:movie_flix/core/const/app_themes.dart';

/// A widget that handles navigation and displays the appropriate content based on the selected tab.
///
/// The `DashboardNavigation` widget uses a [BottomNavigationBar] for tab-based navigation,
/// where each tab corresponds to a different page (e.g., Home, Profile). The widget handles
/// platform-specific UI differences between iOS and Android. On iOS, it uses a [Container] with
/// a shadow effect, while on Android, it uses a [BottomAppBar] with a notch for a floating action button.
///
/// This widget relies on the [DashboardController] for state management, including tracking
/// the currently selected tab and handling user interaction.
///
/// Example usage:
/// 
/// ```dart
/// DashboardNavigation();
/// ```
class DashboardNavigation extends StatelessWidget {
  const DashboardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate and initialize the DashboardController.
    var controller = Get.put(DashboardController());

    return Scaffold(
      // Prevents the bottom inset (e.g., keyboard) from resizing the view.
      resizeToAvoidBottomInset: false,
      
      // Sets the background color of the entire Scaffold to white.
      backgroundColor: AppThemes.white,
      
      // Displays the appropriate page based on the currently selected tab.
      body: Obx(() => 
        SafeArea(
          child: controller.tabPage[controller.currentIndex.value]
        )
      ),
      
      // Displays the bottom navigation bar, which is platform-specific.
      bottomNavigationBar: Obx(() => Platform.isIOS
      ? Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: controller.onItemTapped,
            backgroundColor: AppThemes.white,
            selectedItemColor: AppThemes.blue,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile')
            ],
          ),
        )
      : BottomAppBar(
          elevation: 10.0,
          padding: EdgeInsets.zero,
          shadowColor: Colors.grey,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: controller.onItemTapped,
            backgroundColor: AppThemes.white,
            selectedItemColor: AppThemes.blue,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile')
            ],
          ),
        ))
    );
  }
}
