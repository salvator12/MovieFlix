import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:movie_flix/application/profile/controllers/profile_controller.dart';
import 'package:movie_flix/core/components/movie_card.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'package:movie_flix/utils/app_routes.dart';

/// A widget that displays the profile page content, including the user's
/// watchlist and favorite movies.
///
/// This widget is a `GetView` that relies on [ProfileController] for state
/// management. It uses `Obx` to reactively update the UI based on changes
/// in the controller's state.
class ProfilePageBody extends GetView<ProfileController> {
  /// Creates a [ProfilePageBody] instance.
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(
                color: AppThemes.blue,
                strokeWidth: 5.0,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Displays the 'My Watch List' section header.
                Text(
                  'My Watch List',
                  style: AppThemes()
                      .text3Bold(color: const Color.fromRGBO(18, 123, 220, 1)),
                ),
                SizedBox(height: AppThemes().biggerSpacing),

                /// Displays the user's watchlist as a horizontally scrollable list.
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.lsWatchlistMovie.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.selectedMovie, arguments: {
                            'movie': controller.lsWatchlistMovie[index]
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MovieCard(
                              data: controller.lsWatchlistMovie[index]),
                        ),
                      );
                    },
                  ),
                ),

                /// Displays the 'My Favorite' section header.
                Text(
                  'My Favorite',
                  style: AppThemes().text3Bold(color: AppThemes.lightBlue),
                ),
                SizedBox(height: AppThemes().biggerSpacing),

                /// Displays the user's favorite movies as a horizontally scrollable list.
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.lsFavoriteMovie.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.selectedMovie, arguments: {
                            'movie': controller.lsFavoriteMovie[index]
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MovieCard(
                              data: controller.lsFavoriteMovie[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
