import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Register failed'));
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  Future<void> logout() async {
    await auth.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
  }

  Future<void> loginWithGoogle() async {
    emit(GoogleLoading());

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoading());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordError(
        message: e.message ?? 'Something went wrong',
      ));
    } catch (e) {
      emit(ForgotPasswordError(
        message: e.toString(),
      ));
    }
  }
}
