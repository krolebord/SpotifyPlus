class ApiUrls {
  ApiUrls._();

  static const String scheme = "http";
  static const String authority = "localhost:5000";

  static const String apiPath = "$scheme://$authority";

  static String getSpotifyAuth() => "$apiPath/auth";
  static String getAuthData(String authKey) => "$apiPath/auth/$authKey";
}