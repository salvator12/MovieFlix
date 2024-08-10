import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/profile/controllers/profile_controller.dart';
import 'package:movie_flix/application/profile/views/screens/profile_page_body.dart';
import 'package:movie_flix/application/profile/views/screens/profile_page_header.dart';
import 'package:movie_flix/core/const/app_themes.dart';

/// A stateless widget that represents the profile page of the application.
///
/// This page displays the user's profile information, including the profile
/// header and body content. It supports pull-to-refresh functionality to
/// update the profile information.
class ProfilePage extends StatelessWidget {
  /// Creates an instance of [ProfilePage].
  ///
  /// The [key] parameter is used to uniquely identify this widget within the
  /// widget tree.
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the ProfileController and make it available for dependency
    // injection.
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppThemes.white,
      body: RefreshIndicator(
        /// Triggers the [onRefresh] method in [ProfileController] to refresh
        /// the profile data when the user performs a pull-to-refresh gesture.
        onRefresh: () => controller.onRefresh(),
        
        child: Obx(() => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Displays a message to inform the user that they should scroll up
                /// to update content if [isUpdatePage] is true.
                controller.isUpdatePage.value 
                  ? Text('Please scroll up to update content') 
                  : Container(),

                /// Displays the profile page header.
                ProfilePageHeader(),

                SizedBox(height: Get.size.height * .05),

                /// Displays the profile page body, which contains the user's
                /// watchlist and favorite movies.
                ProfilePageBody(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
