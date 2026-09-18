abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class GoogleLoading extends AuthState {}



class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ForgotPasswordError extends AuthState {
  final String message;

  ForgotPasswordError({
    required this.message,
  });
}
