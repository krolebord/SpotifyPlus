import 'package:spotify_plus/models/auth/auth_data.dart';

abstract class AuthService {
  AuthData? get currentAuth;

  Stream<AuthData?> get authChanges;

  Future<AuthData?> signInWithSpotify();
}