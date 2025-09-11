import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;
  LoginBloc() : super(LoginInitial()) {
    on<EmailLoginEvent>(onEmailLogin);
    on<GoogleLoginEvent>(onGoogleLogin);
    on<SignUpEvent>(onSignUp);
  }

  FutureOr<void> onEmailLogin(
    EmailLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password.trim(),
      );
      emit(LoginLoaded(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? "Login failed"));
    }
  }

  FutureOr<void> onGoogleLogin(
    GoogleLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        emit(LoginError(message: "Missing ID token"));
        return;
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      emit(LoginLoaded(user: userCredential.user));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  FutureOr<void> onSignUp(SignUpEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password.trim(),
      );

      emit(LoginLoaded(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? "Sign up failed"));
    }
  }
}
