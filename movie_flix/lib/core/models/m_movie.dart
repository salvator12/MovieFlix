import 'dart:core';
import 'dart:ffi';

import 'package:get/get.dart';

/// Represents a movie with various attributes.
///
/// The `Movie` class contains information about a movie including its ID,
/// title, backdrop, poster, release date, genre IDs, popularity, and vote average.
/// It also includes observable properties for tracking if the movie is a favorite
/// or part of the watchlist.
///
/// Attributes:
/// - [id]: Unique identifier for the movie.
/// - [title]: Title of the movie.
/// - [backdropPath]: Path to the movie's backdrop image.
/// - [originalTitle]: Original title of the movie.
/// - [overview]: Brief description or synopsis of the movie.
/// - [posterPath]: Path to the movie's poster image.
/// - [releaseDate]: Release date of the movie.
/// - [genreIds]: List of genre IDs associated with the movie.
/// - [popularity]: Popularity score of the movie.
/// - [voteAverage]: Average vote score of the movie.
/// - [isFavorite]: Observable boolean indicating if the movie is marked as a favorite.
/// - [isWatchList]: Observable boolean indicating if the movie is on the watchlist.
class Movie {
  /// Unique identifier for the movie.
  int? id;

  /// Title of the movie.
  String? title;

  /// Path to the movie's backdrop image.
  String? backdropPath;

  /// Original title of the movie.
  String? originalTitle;

  /// Brief description or synopsis of the movie.
  String? overview;

  /// Path to the movie's poster image.
  String? posterPath;

  /// Release date of the movie.
  String? releaseDate;

  /// List of genre IDs associated with the movie.
  List<int>? genreIds;

  /// Popularity score of the movie.
  double? popularity;

  /// Average vote score of the movie.
  double? voteAverage;

  /// Observable boolean indicating if the movie is marked as a favorite.
  RxBool isFavorite = false.obs;

  /// Observable boolean indicating if the movie is on the watchlist.
  RxBool isWatchList = false.obs;

  /// Creates a new [Movie] instance with the provided attributes.
  ///
  /// [id] is the unique identifier for the movie.
  /// [title] is the title of the movie.
  /// [backdropPath] is the path to the movie's backdrop image.
  /// [originalTitle] is the original title of the movie.
  /// [overview] is the brief description or synopsis of the movie.
  /// [posterPath] is the path to the movie's poster image.
  /// [releaseDate] is the release date of the movie.
  /// [genreIds] is the list of genre IDs associated with the movie.
  /// [popularity] is the popularity score of the movie.
  /// [voteAverage] is the average vote score of the movie.
  Movie({
    this.id,
    this.title,
    this.backdropPath,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.genreIds,
    this.popularity,
    this.voteAverage,
  });
  
  /// Creates a [Movie] instance from a JSON object.
  ///
  /// The [json] parameter must be a [Map<String, dynamic>] containing the keys and
  /// values for the movie attributes.
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    voteAverage: json["vote_average"]?.toDouble(),
  );

  /// Converts the [Movie] instance to a JSON object.
  ///
  /// Returns a [Map<String, dynamic>] containing the movie attributes.
  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "vote_average": voteAverage,
  };
}
