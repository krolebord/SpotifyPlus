part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthSignedOut extends AuthState {}

class AuthSignedIn extends AuthState {
  final AuthData authData;

  const AuthSignedIn(this.authData);

  @override
  List<Object> get props => [authData];
}
