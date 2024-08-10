/// Contains static constants for API configuration and authentication.
///
/// The `AppAPIAttributes` class provides constants used for accessing and
/// interacting with the TMDb API. These constants include the API key, account
/// ID, image base URL, and access token for authentication.
///
/// This class should not be instantiated or extended. Its members are accessed
/// statically.
class AppAPIAttributes {
  /// The API key used to authenticate requests to the TMDb API.
  ///
  /// This key is required for making authorized requests to the API.
  /// Replace this key with your own when using the API.
  static const APIKey = 'b52db1758fb8d19a182643000b543cbb';

  /// The account ID used to access user-specific endpoints on the TMDb API.
  ///
  /// This ID identifies the user account for fetching favorites, watchlists,
  /// and other account-specific data.
  static const accountIdAPI = '21428490';

  /// The base URL used for retrieving images from the TMDb API.
  ///
  /// The URL is followed by a specific image path to form the full image URL.
  /// For example, combining this with an image path will yield the complete URL
  /// to the image.
  static const imagePath = 'https://image.tmdb.org/t/p/w500';

  /// The access token used for authenticating requests to the TMDb API.
  ///
  /// This token must be included in the `Authorization` header of requests
  /// that require user authentication.
  ///
  /// Replace this token with your own when making authenticated requests.
  static const accessTokenAuth = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTJkYjE3NThmYjhkMTlhMTgyNjQzMDAwYjU0M2NiYiIsIm5iZiI6MTcyMzE2OTAxMy43NTQxOSwic3ViIjoiNjZiMzZlNjIzOWU5YWQ0YzQ1NThlZjIyIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.q3zhDM7GFPeT88VnSdgBp1ESPXoz096jfBhVLI-5jUs';
}
