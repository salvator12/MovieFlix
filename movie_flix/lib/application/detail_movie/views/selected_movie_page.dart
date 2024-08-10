import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/detail_movie/controllers/movie_detail_controller.dart';
import 'package:movie_flix/core/components/movie_card.dart';
import 'package:movie_flix/core/const/app_api_attribute.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'package:movie_flix/utils/app_routes.dart';

/// A page displaying detailed information about a selected movie.
///
/// The `SelectedMoviePage` widget uses the `MovieDetailController` to manage
/// the state and display details of the selected movie, including its genre,
/// release date, popularity, rating, and overview. It also shows a list of
/// similar movies based on the selected movie's genre.
///
/// The page layout includes:
/// - A `SliverAppBar` for displaying the movie's backdrop image and title.
/// - A `CustomScrollView` containing various details and similar movie cards.
/// - Progress indicator while data is loading.
///
/// Requires the movie details to be passed through `Get.arguments` and expects
/// `MovieDetailController` to be used for state management.
class SelectedMoviePage extends StatelessWidget {
  /// Creates a new instance of `SelectedMoviePage`.
  ///
  /// The [key] argument is optional and can be used to identify this widget
  /// in the widget tree.
  const SelectedMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with arguments passed from the previous page.
    var controller = Get.put(MovieDetailController(Get.arguments));

    return Scaffold(
      body: Obx(() => controller.isLoading.isTrue
        ? const Center(
            child: CircularProgressIndicator(
              color: AppThemes.blue,
              strokeWidth: 5.0,
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverAppBar.large(
                leading: Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppThemes.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppThemes.darkBlue,
                    ),
                  ),
                ),
                backgroundColor: AppThemes.white,
                expandedHeight: Get.size.height * .5,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    controller.selectedMovie.value.title!,
                    style: AppThemes().text3BoldShadow(color: AppThemes.white),
                  ),
                  background: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.network(
                      '${AppAPIAttributes.imagePath}${controller.selectedMovie.value.backdropPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Genre: ',
                            style: AppThemes().text4(color: AppThemes.black),
                          ),
                          Text(
                            controller.genre.value,
                            style: AppThemes().text4Bold(color: AppThemes.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Release date: ',
                            style: AppThemes().text4(color: AppThemes.black),
                          ),
                          Text(
                            controller.selectedMovie.value.releaseDate!,
                            style: AppThemes().text4Bold(color: AppThemes.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Popularity: ',
                            style: AppThemes().text4(color: AppThemes.black),
                          ),
                          Text(
                            controller.selectedMovie.value.popularity!.toStringAsFixed(1),
                            style: AppThemes().text4Bold(color: AppThemes.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Rating: ',
                            style: AppThemes().text4(color: AppThemes.black),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            controller.selectedMovie.value.voteAverage!.toStringAsFixed(1),
                            style: AppThemes().text4Bold(color: AppThemes.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppThemes().biggerSpacing,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey[350],
                      ),
                      SizedBox(
                        height: AppThemes().biggerSpacing,
                      ),
                      Text(
                        'Overview',
                        style: AppThemes().text2Bold(color: AppThemes.lightBlue),
                      ),
                      SizedBox(height: AppThemes().biggerSpacing,),
                      Text(
                        controller.selectedMovie.value.overview!,
                        style: AppThemes().text4SemiBold(color: AppThemes.black),
                      ),
                      SizedBox(
                        height: AppThemes().biggerSpacing,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey[350],
                      ),
                      SizedBox(
                        height: AppThemes().biggerSpacing,
                      ),
                      Text(
                        'Similar Genre',
                        style: AppThemes().text2Bold(color: AppThemes.lightBlue),
                      ),
                      SizedBox(height: AppThemes().biggerSpacing,),
                      SizedBox(
                        height: Get.size.height * .4,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.lsSimilarMovie.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print("movie tapped");
                                Get.delete<MovieDetailController>();
                                Get.toNamed(AppRoutes.selectedMovie,
                                  arguments: {
                                    'movie': controller.lsSimilarMovie[index]
                                  },
                                  preventDuplicates: false,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: MovieCard(data: controller.lsSimilarMovie[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
