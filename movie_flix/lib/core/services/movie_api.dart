import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:movie_flix/core/const/app_api_attribute.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flix/core/models/m_genre.dart';
import 'package:movie_flix/core/models/m_movie.dart';

/// A singleton class responsible for interacting with the movie API.
///
/// The `MovieAPI` class provides methods to fetch movie data from The Movie Database (TMDb) API.
/// It uses a singleton pattern to ensure that only one instance of the class is created.
///
/// This class includes methods to fetch now playing movies, popular movies, favorite movies,
/// watchlist movies, similar movies based on genre, and movie genres. It also provides methods
/// to add or remove movies from favorites and watchlist.
class MovieAPI {
  // Private constructor to prevent external instantiation.
  MovieAPI._internal();

  // Static instance of the class.
  static final MovieAPI _instance = MovieAPI._internal();

  // Factory constructor to return the same instance every time.
  factory MovieAPI() {
    return _instance;
  }

  // URL endpoints for various API requests.
  static const _nowPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${AppAPIAttributes.APIKey}';
  static const _popularUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${AppAPIAttributes.APIKey}';
  static const _similarMovieUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${AppAPIAttributes.APIKey}&with_genres=';
  static const _movieGenreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=${AppAPIAttributes.APIKey}';
  static const _favoriteUrl = 'https://api.themoviedb.org/3/account/${AppAPIAttributes.accountIdAPI}/favorite/movies';
  static const _watchlistUrl = 'https://api.themoviedb.org/3/account/${AppAPIAttributes.accountIdAPI}/watchlist/movies';
  static const _postWatchListUrl = 'https://api.themoviedb.org/3/account/${AppAPIAttributes.accountIdAPI}/watchlist';
  static const _postFavoriteUrl = 'https://api.themoviedb.org/3/account/${AppAPIAttributes.accountIdAPI}/favorite';

  /// Fetches the list of currently playing movies.
  ///
  /// Returns a [Future] that resolves to a list of [Movie] objects.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<List<Movie>> getNowPlayingMovie() async {
    final response = await http.get(Uri.parse(_nowPlayingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      switch (response.statusCode) {
        case 400:
         throw Exception("Bad request");
        case 404:
          throw Exception("Data not found");
        case 500:
          throw Exception("Internal server error");
        default:
          throw Exception("Something happened");
      }
    }
  }

  /// Fetches the list of popular movies.
  ///
  /// Returns a [Future] that resolves to a list of [Movie] objects.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<List<Movie>> getPopularMovie() async {
    final response = await http.get(Uri.parse(_popularUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      switch (response.statusCode) {
        case 400:
         throw Exception("Bad request");
        case 404:
          throw Exception("Data not found");
        case 500:
          throw Exception("Internal server error");
        default:
          throw Exception("Something happened");
      }
    }
  }

  /// Fetches the list of favorite movies for the authenticated user.
  ///
  /// Returns a [Future] that resolves to a list of [Movie] objects.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<List<Movie>> getFavoriteMovie() async {
    final uri = Uri.parse(_favoriteUrl).replace(queryParameters: {
      'language': 'en-US',
      'page': '1',
      'sort_by': 'created_at.asc',
    });

    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AppAPIAttributes.accessTokenAuth}',
      });

    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}. Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  /// Fetches the list of watchlist movies for the authenticated user.
  ///
  /// Returns a [Future] that resolves to a list of [Movie] objects.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<List<Movie>> getWatchlistMovie() async {
    final uri = Uri.parse(_watchlistUrl).replace(queryParameters: {
      'language': 'en-US',
      'page': '1',
      'sort_by': 'created_at.asc',
    });

    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AppAPIAttributes.accessTokenAuth}',
      });

    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}. Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  /// Fetches a list of movies similar to the given [selectedMovie] based on genre.
  ///
  /// [selectedMovie] is used to determine the genres for the similarity search.
  ///
  /// Returns a [Future] that resolves to a list of [Movie] objects.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<List<Movie>> getSimilarMovies(Movie selectedMovie) async {
    final genreIdsParam = selectedMovie.genreIds!.join('|');
    final finalUrl = '${_similarMovieUrl}${genreIdsParam}';
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      var lsDecodedSimilarMovie = decodedData.map((movie) => Movie.fromJson(movie)).toList();
      var lsSimilarMovie = List<Movie>.empty(growable: true).obs;
      for(var e in lsDecodedSimilarMovie) {
        if (e.id != selectedMovie.id) {
          lsSimilarMovie.add(e);
        }
      }
      return lsSimilarMovie;
    } else {
      switch (response.statusCode) {
        case 400:
         throw Exception("Bad request");
        case 404:
          throw Exception("Data not found");
        case 500:
          throw Exception("Internal server error");
        default:
          throw Exception("Something happened");
      }
    }
  }

  /// Fetches the names of movie genres based on a list of [genreIds].
  ///
  /// [genreIds] is used to look up the genre names from the TMDb API.
  ///
  /// Returns a [Future] that resolves to a comma-separated string of genre names.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<String> getMovieGenre(List<int> genreIds) async {
    final response = await http.get(Uri.parse(_movieGenreUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['genres'] as List;
      final lsDecodedGenre = decodedData.map((genre) => Genre.fromJson(genre)).toList();
      var lsFixGenre = List<Genre>.empty(growable: true).obs;
      for(var e in genreIds) {
        final genre = lsDecodedGenre.firstWhereOrNull((element) => element.id == e);
        if (genre != null) {
          lsFixGenre.add(genre);
        }
      }

      return lsFixGenre.map((element) => element.name).join(', ');
    } else {
      switch (response.statusCode) {
        case 400:
         throw Exception("Bad request");
        case 404:
          throw Exception("Data not found");
        case 500:
          throw Exception("Internal server error");
        default:
          throw Exception("Something happened");
      }
    }
  }

  /// Adds or removes a movie from the user's favorites.
  ///
  /// [mediaId] is the ID of the movie to be added or removed.
  /// [isFavorite] indicates whether to add (`true`) or remove (`false`) the movie from favorites.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<void> postFavorite(int mediaId, bool isFavorite) async {
    final url = Uri.parse(_postFavoriteUrl);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppAPIAttributes.accessTokenAuth}',
    };

    final body = jsonEncode({
      'media_type': 'movie',
      'media_id': mediaId,
      'favorite': isFavorite,
    });
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Response favorite: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}. Response body: ${response.body}');
    }
  }

  /// Adds or removes a movie from the user's watchlist.
  ///
  /// [mediaId] is the ID of the movie to be added or removed.
  /// [isWatchList] indicates whether to add (`true`) or remove (`false`) the movie from the watchlist.
  ///
  /// Throws an [Exception] if the request fails or if the status code is not 200.
  Future<void> postWatchList(int mediaId, bool isWatchList) async {
    final url = Uri.parse(_postWatchListUrl);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppAPIAttributes.accessTokenAuth}',
    };

    final body = jsonEncode({
      'media_type': 'movie',
      'media_id': mediaId,
      'watchlist': isWatchList,
    });
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Response watchlist: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}. Response body: ${response.body}');
    }
  }
}
