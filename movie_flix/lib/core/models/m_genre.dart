/// Represents a genre with an identifier and name.
///
/// The `Genre` class contains information about a genre including its unique
/// identifier and name.
///
/// Attributes:
/// - [id]: Unique identifier for the genre.
/// - [name]: Name of the genre.
class Genre {
  /// Unique identifier for the genre.
  final int id;

  /// Name of the genre.
  final String name;

  /// Creates a new [Genre] instance with the provided [id] and [name].
  ///
  /// The [id] parameter must not be null.
  /// The [name] parameter must not be null.
  Genre({
    required this.id,
    required this.name,
  });

  /// Creates a [Genre] instance from a JSON object.
  ///
  /// The [json] parameter must be a [Map<String, dynamic>] containing the keys
  /// and values for the genre attributes.
  ///
  /// Example:
  /// ```dart
  /// final genre = Genre.fromJson({
  ///   "id": 1,
  ///   "name": "Action"
  /// });
  /// ```
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  /// Converts the [Genre] instance to a JSON object.
  ///
  /// Returns a [Map<String, dynamic>] containing the genre attributes.
  ///
  /// Example:
  /// ```dart
  /// final genreJson = genre.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
