class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class LoadingRegister extends AuthState {}

final class SuccessRegister extends AuthState {}

final class FailureRegister extends AuthState {
  final String errorMessage;

  FailureRegister({required this.errorMessage});
}
