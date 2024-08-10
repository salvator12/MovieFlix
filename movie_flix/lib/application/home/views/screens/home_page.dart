import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/home/controllers/home_controller.dart';
import 'package:movie_flix/application/home/views/screens/movie_carousel_page.dart';
import 'package:movie_flix/core/const/app_themes.dart';

/// A page that serves as the home screen of the movie application.
///
/// This page includes a tab bar to switch between different movie categories
/// and displays movie carousels for the selected category. It uses the 
/// [HomeController] to manage the state and interactions.
class HomePage extends StatelessWidget {
  /// Creates a [HomePage] widget.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the [HomeController] for managing the state of the home page.
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Movie Flix"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 1.0)],
              color: AppThemes.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TabBar(
              unselectedLabelColor: Colors.grey.shade400,
              labelColor: Colors.white,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3, color: AppThemes.white),
                ),
              ),
              tabs: controller.tabs,
              controller: controller.tabsController,
            ),
          ),
          SizedBox(height: AppThemes().veryExtraSpacing,),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: controller.tabsController,
              children: [
                /// Displays the carousel of movies that are currently playing.
                MovieCarouselPage(selectedTab: 0),

                /// Displays the carousel of popular movies.
                MovieCarouselPage(selectedTab: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
