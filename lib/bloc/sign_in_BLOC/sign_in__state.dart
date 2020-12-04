import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptySiginInState extends SignInState {}

class LoaderSignInState extends SignInState {}

class SubmitSignInState extends SignInState {
  final UserCredential signInData;
  // final ConfirmationResult phData;
  SubmitSignInState({
    this.signInData,
  });
}
