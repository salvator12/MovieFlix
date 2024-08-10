import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/core/const/app_api_attribute.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'package:movie_flix/core/models/m_movie.dart';

/// A stateless widget that displays a card for a movie in a profile view.
///
/// This widget shows a movie's poster and title in a card format. It is
/// designed to be used in the profile page to display movies in the user's
/// watchlist or favorites.
///
/// The [data] parameter is required and must not be null. It provides the
/// movie information to be displayed.
class MovieCard extends StatelessWidget {
  /// Creates an instance of [MovieCard].
  ///
  /// The [data] parameter must not be null and represents the movie information
  /// to be displayed on the card.
  const MovieCard({super.key, required this.data});

  /// The movie data to be displayed on the card.
  final Movie data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.size.height * .25,
              width: Get.size.width * .4,
              child: Image.network(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                '${AppAPIAttributes.imagePath}${data.posterPath}'
              ),
            ),
          ],
        ),
        SizedBox(height: AppThemes().extraSpacing,),
        SizedBox(
          width: Get.size.width * .4,
          child: Text(
            data.title!,
            style: AppThemes().text5Bold(color: AppThemes.black),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
