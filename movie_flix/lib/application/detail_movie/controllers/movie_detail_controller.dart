import 'package:get/get.dart';
import 'package:movie_flix/core/models/m_genre.dart';
import 'package:movie_flix/core/models/m_movie.dart';
import 'package:movie_flix/core/services/movie_api.dart';

/// A controller responsible for managing the state and data of a movie detail page.
///
/// The `MovieDetailController` fetches and manages the selected movie's details, including
/// similar movies and genre information. It uses the [MovieAPI] service to retrieve data
/// and updates the state in an observable way, allowing the UI to react to changes.
///
/// This controller is initialized with a map of arguments, typically including the selected
/// movie object.
///
/// Example usage:
/// 
/// ```dart
/// MovieDetailController controller = Get.put(MovieDetailController({'movie': selectedMovie}));
/// ```
class MovieDetailController extends GetxController with GetTickerProviderStateMixin {
  /// Creates an instance of [MovieDetailController] with the given [arguments].
  ///
  /// The [arguments] should include the selected movie, which is used to fetch
  /// similar movies and genre information.
  MovieDetailController(this.arguments);

  /// The arguments passed to the controller, typically including the selected movie.
  ///
  /// This map is expected to have a key 'movie' that corresponds to a [Movie] object.
  final Map arguments;

  /// Indicates whether the data is currently being loaded.
  ///
  /// This observable boolean value is used to show or hide loading indicators in the UI.
  var isLoading = false.obs;

  /// The selected movie whose details are being displayed.
  ///
  /// This observable value holds the movie object that was passed in the [arguments].
  var selectedMovie = Movie().obs;

  /// A list of similar movies to the selected movie.
  ///
  /// This observable list is populated by fetching data from the [MovieAPI].
  var lsSimilarMovie = List<Movie>.empty(growable: true).obs;

  /// The genre of the selected movie as a string.
  ///
  /// This observable string is populated by fetching the genre name(s) from the [MovieAPI]
  /// based on the genre IDs of the selected movie.
  var genre = ''.obs;

  /// The API service used to fetch movie data.
  ///
  /// This is an instance of the [MovieAPI] class, which provides methods for retrieving
  /// similar movies and genre information.
  final movieAPI = MovieAPI();

  /// Initializes the controller and fetches the necessary movie data.
  ///
  /// This method is called automatically when the controller is created. It starts by setting
  /// [isLoading] to true, then fetches the selected movie's details, similar movies, and genre
  /// information. Once the data is fetched, [isLoading] is set to false.
  @override
  void onInit() async {
    isLoading(true);
    
    // Retrieve the selected movie from the passed arguments.
    selectedMovie.value = arguments['movie'];
    
    // Fetch similar movies from the API and update the list.
    lsSimilarMovie.value = await movieAPI.getSimilarMovies(arguments['movie']);
    
    // Fetch the genre name(s) based on the genre IDs of the selected movie.
    genre.value = await movieAPI.getMovieGenre(arguments['movie'].genreIds);
    
    isLoading(false);
    super.onInit();
  }
}
