import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:movie_flix/core/models/m_movie.dart';
import 'package:movie_flix/core/services/movie_api.dart';

/// Manages the state and operations related to the user's profile.
///
/// This controller handles fetching and updating the user's watchlist
/// and favorite movies. It uses [GetxController] for state management
/// and [GetTickerProviderStateMixin] for animations.
class ProfileController extends GetxController with GetTickerProviderStateMixin {
  /// Indicates whether data is currently being loaded.
  var isLoading = false.obs;

  /// The list of movies in the user's watchlist.
  var lsWatchlistMovie = List<Movie>.empty(growable: true).obs;

  /// The list of the user's favorite movies.
  var lsFavoriteMovie = List<Movie>.empty(growable: true).obs;

  /// Indicates whether the page needs to be updated.
  var isUpdatePage = false.obs;

  /// Provides methods to interact with movie-related APIs.
  final movieAPI = MovieAPI();

  /// Initializes the controller by loading the watchlist and favorite movies.
  ///
  /// Sets [isLoading] to true while loading the data and false when
  /// the loading is complete.
  @override
  void onInit() async {
    isLoading(true);
    lsWatchlistMovie.value = await movieAPI.getWatchlistMovie();
    lsFavoriteMovie.value = await movieAPI.getFavoriteMovie();
    isLoading(false);
    super.onInit();
  }

  /// Refreshes the watchlist and favorite movies.
  ///
  /// This method sets [isLoading] to true while fetching the updated data,
  /// then updates the lists and sets [isUpdatePage] to false. Finally,
  /// it sets [isLoading] to false to indicate that the refresh is complete.
  Future<void> onRefresh() async {
    isLoading(true);
    lsWatchlistMovie.value = await movieAPI.getWatchlistMovie();
    lsFavoriteMovie.value = await movieAPI.getFavoriteMovie();
    isUpdatePage.value = false;
    isLoading(false);
  }
}
