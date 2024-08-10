import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/home/controllers/home_controller.dart';
import 'package:movie_flix/application/home/views/widgets/movie_carousel_card.dart';
import 'package:movie_flix/application/profile/controllers/profile_controller.dart';
import 'package:movie_flix/core/const/app_api_attribute.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'package:movie_flix/core/services/movie_api.dart';
import 'package:movie_flix/utils/app_routes.dart';

/// A widget that displays a carousel of movies.
///
/// This widget shows a carousel of movies based on the selected tab.
/// It provides interactive buttons for favoriting, adding to watchlist,
/// and saving images of movies.
class MovieCarouselPage extends GetView<HomeController> {
  /// Creates a [MovieCarouselPage] widget.
  ///
  /// The [selectedTab] parameter determines which movie list to display
  /// in the carousel: now playing or popular.
  final int selectedTab;

  /// Constructs a [MovieCarouselPage] with the given [selectedTab].
  const MovieCarouselPage({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show a loading indicator while data is being fetched.
      if (controller.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        );
      }

      // Display the carousel of movies.
      return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: selectedTab == 0 ? 6 : 20,
          options: CarouselOptions(
            height: Get.size.height * .65,
            viewportFraction: 0.55,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          itemBuilder: (context, index, realIndex) {
            final movie = selectedTab == 0
                ? controller.lsNowPlayingMovie[index]
                : controller.lsPopularMovie[index];

            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.selectedMovie, arguments: {
                      'movie': movie,
                    });
                  },
                  child: MovieCarouselCard(data: movie),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.updateFavoriteButton(selectedTab, index);
                        MovieAPI().postFavorite(
                          movie.id!,
                          movie.isFavorite.value,
                        );
                        Get.find<ProfileController>().isUpdatePage.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        elevation: 3,
                      ),
                      child: Obx(() => Icon(
                        movie.isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: AppThemes.red,
                      )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.updateWatchlistButton(selectedTab, index);
                        MovieAPI().postWatchList(
                          movie.id!,
                          movie.isWatchList.value,
                        );
                        Get.find<ProfileController>().isUpdatePage.value = true;
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        elevation: 3,
                      ),
                      child: Obx(() => Icon(
                        movie.isWatchList.value
                            ? Icons.movie
                            : Icons.movie_creation_outlined,
                        color: Colors.orange[700],
                      )),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.saveImage(
                          '${AppAPIAttributes.imagePath}${movie.backdropPath}',
                        );
                        Get.defaultDialog(
                          title: 'Success',
                          middleText:
                              '${movie.title} image has been saved',
                          textConfirm: 'Ok',
                          onConfirm: () => Get.back(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 2),
                        elevation: 3,
                      ),
                      child: Icon(Icons.save_alt, color: AppThemes.green),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
