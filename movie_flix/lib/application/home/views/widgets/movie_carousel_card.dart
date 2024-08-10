import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/application/home/controllers/home_controller.dart';
import 'package:movie_flix/core/const/app_api_attribute.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'package:movie_flix/core/models/m_movie.dart';

/// A widget that displays a card for a movie in a carousel.
///
/// This widget shows the movie's poster and its title. The card is used
/// within a carousel view to present a collection of movies.
class MovieCarouselCard extends GetView<HomeController> {
  /// Creates a [MovieCarouselCard] widget.
  ///
  /// The [data] parameter provides the movie details to be displayed
  /// in the card.
  final Movie data;

  /// Constructs a [MovieCarouselCard] with the provided [data].
  const MovieCarouselCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.size.height * .4,
          width: Get.size.width * .6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: AppThemes.darkBlue,
          ),
          child: Image.network(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            '${AppAPIAttributes.imagePath}${data.posterPath}',
          ),
        ),
        SizedBox(height: AppThemes().extraSpacing),
        SizedBox(
          width: 200,
          child: Text(
            '${data.originalTitle}',
            style: AppThemes().text5Bold(color: AppThemes.black),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
