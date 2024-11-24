import 'package:chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/firestore/firestore_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/firestore/models/users.dart' as myuser;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(LoginLoading());
          try {
            final credential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email.trim(),
              password: event.password,
            );
            emit(LoginSuccess());
          } on FirebaseAuthException catch (e) {
            emit(LoginFailure(errorMessage: e.code));
          }
        }

        if (event is RegisterEvent) {
          emit(LoadingRegister());
          try {
            final credential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email.trim(),
              password: event.password,
            );
            await FirestoreHandler.createUser(
              myuser.User(
                email: event.email.trim(),
                id: credential.user!.uid,
                name: event.name,
              ),
            );
            emit(SuccessRegister());
          } on FirebaseAuthException catch (e) {
            emit(FailureRegister(errorMessage: e.code));
          } catch (e) {
            emit(FailureRegister(errorMessage: e.toString()));
          }
        }
      },
    );
  }
}
