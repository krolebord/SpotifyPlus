import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:spotify_plus/services/auth/auth_service_exception.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late final AuthService _authService;

  AuthCubit() :
    _authService = GetIt.instance.get<AuthService>(),
    super(AuthLoading())
  {
    _authService.authChanges.listen(_onAuthChanged);
  }

  void _onAuthChanged(AuthData? authData) {
    if(authData == null) {
      emit(AuthSignedOut());
    }
    else {
      emit(AuthSignedIn(authData));
    }
  }

  Future<void> signInWithSpotify() async {
    emit(AuthLoading());

    try {
      await _authService.signInWithSpotify();
    } on AuthServiceException catch(e) {
      emit(AuthError(e.errorMessage));
      emit(AuthSignedOut());
    }
  }
}
