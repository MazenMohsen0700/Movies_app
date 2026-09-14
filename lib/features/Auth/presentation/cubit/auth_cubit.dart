import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Register failed'));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
