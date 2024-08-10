import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:movie_flix/core/models/m_movie.dart';
import 'package:movie_flix/core/services/movie_api.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Manages the state and logic for the home page of the movie application.
///
/// This controller handles fetching and managing movies that are now playing
/// and popular, as well as checking and updating favorite and watchlist movies.
class HomeController extends GetxController with GetTickerProviderStateMixin {
  /// The tab controller for the home page tabs.
  TabController? tabsController;

  /// The service for fetching movie data from the API.
  final movieAPI = MovieAPI();

  /// Indicates whether the data is currently being loaded.
  var isLoading = false.obs;

  /// The list of movies that are currently playing in theaters.
  var lsNowPlayingMovie = List<Movie>.empty(growable: true).obs;

  /// The list of popular movies.
  var lsPopularMovie = List<Movie>.empty(growable: true).obs;

  /// The tabs for the home page.
  final List<Tab> tabs = const [
    Tab(text: 'Now Playing'),
    Tab(text: 'Popular'),
  ];

  @override
  void onInit() async {
    /// Initializes the controller by setting up the tab controller and
    /// fetching movie data.
    isLoading(true);
    tabsController = TabController(length: tabs.length, vsync: this);
    lsNowPlayingMovie.value = await movieAPI.getNowPlayingMovie();
    lsPopularMovie.value = await movieAPI.getPopularMovie();
    onCheckFavoriteMovie();
    onCheckWatchlistMovie();
    isLoading(false);
    super.onInit();
  }

  /// Checks which movies are marked as favorite and updates their state.
  ///
  /// This method updates the `isFavorite` property of movies in the now playing
  /// and popular lists based on the favorite movies fetched from the API.
  void onCheckFavoriteMovie() async {
    var lsFavoriteMovie = await movieAPI.getFavoriteMovie();
    for (var e in lsFavoriteMovie) {
      print(e.title);
    }
    for (var e in lsNowPlayingMovie) {
      final temp = lsFavoriteMovie.firstWhereOrNull((element) => element.id == e.id);
      if (temp != null) {
        print("masukk favorite");
        e.isFavorite.value = true;
      }
    }

    for (var e in lsPopularMovie) {
      final temp = lsFavoriteMovie.firstWhereOrNull((element) => element.id == e.id);
      if (temp != null) {
        print("masukk favorite");
        e.isFavorite.value = true;
      }
      print("temp: ${temp}");
    }
  }

  /// Checks which movies are on the watchlist and updates their state.
  ///
  /// This method updates the `isWatchList` property of movies in the now playing
  /// and popular lists based on the watchlist movies fetched from the API.
  void onCheckWatchlistMovie() async {
    var lsWatchlistMovie = await movieAPI.getWatchlistMovie();
    for (var e in lsNowPlayingMovie) {
      final temp = lsWatchlistMovie.firstWhereOrNull((element) => element.id == e.id);
      if (temp != null) {
        print("masukk favorite");
        e.isWatchList.value = true;
      }
    }

    for (var e in lsPopularMovie) {
      final temp = lsWatchlistMovie.firstWhereOrNull((element) => element.id == e.id);
      if (temp != null) {
        print("masukk watchlist");
        e.isWatchList.value = true;
      }
    }
  }

  /// Saves an image from the given [imageUrl] to the device's gallery.
  ///
  /// Requests storage permission, downloads the image, and saves it to the gallery.
  /// 
  /// [imageUrl] is the URL of the image to be saved.
  Future<void> saveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    await [Permission.storage].request();
    final time = DateTime.now();
    final filename = 'screenshot_$time';
    await ImageGallerySaver.saveImage(response.bodyBytes, name: filename);
  }

  /// Toggles the favorite status of a movie based on the selected tab and index.
  ///
  /// Updates the favorite status of the movie at the given [index] in the list
  /// corresponding to the [selectedTab]. Also updates the status in the other list
  /// if the movie is present.
  /// 
  /// [selectedTab] indicates which tab is currently selected (0 for now playing, 1 for popular).
  /// [index] is the position of the movie in the selected tab's list.
  void updateFavoriteButton(int selectedTab, int index) {
    if (selectedTab == 0) {
      lsNowPlayingMovie[index].isFavorite.value = !lsNowPlayingMovie[index].isFavorite.value;
      for (var e in lsPopularMovie) {
        if (e.id == lsNowPlayingMovie[index].id) {
          e.isFavorite.value = lsNowPlayingMovie[index].isFavorite.value;
          break;
        }
      }
    } else {
      lsPopularMovie[index].isFavorite.value = !lsPopularMovie[index].isFavorite.value;
      for (var e in lsNowPlayingMovie) {
        if (e.id == lsPopularMovie[index].id) {
          e.isFavorite.value = lsPopularMovie[index].isFavorite.value;
          break;
        }
      }
    }                 
  }

  /// Toggles the watchlist status of a movie based on the selected tab and index.
  ///
  /// Updates the watchlist status of the movie at the given [index] in the list
  /// corresponding to the [selectedTab]. Also updates the status in the other list
  /// if the movie is present.
  /// 
  /// [selectedTab] indicates which tab is currently selected (0 for now playing, 1 for popular).
  /// [index] is the position of the movie in the selected tab's list.
  void updateWatchlistButton(int selectedTab, int index) {
    if (selectedTab == 0) {
      lsNowPlayingMovie[index].isWatchList.value = !lsNowPlayingMovie[index].isWatchList.value;
      for (var e in lsPopularMovie) {
        if (e.id == lsNowPlayingMovie[index].id) {
          e.isWatchList.value = lsNowPlayingMovie[index].isWatchList.value;
          break;
        }
      }
    } else {
      lsPopularMovie[index].isWatchList.value = !lsPopularMovie[index].isWatchList.value;
      for (var e in lsNowPlayingMovie) {
        if (e.id == lsPopularMovie[index].id) {
          e.isWatchList.value = lsPopularMovie[index].isWatchList.value;
          break;
        }
      }
    }                 
  }
}
