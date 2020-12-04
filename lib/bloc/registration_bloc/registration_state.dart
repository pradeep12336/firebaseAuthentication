import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyRegistrationState extends RegistrationState {}

class LoaderRegistrationState extends RegistrationState {}

class OnDataRegistrationState extends RegistrationState {
  final UserCredential Datas;
  // final ConfirmationResult phData;
  OnDataRegistrationState({
    @required this.Datas,
  });
  @override
  List<Object> get props => [Datas];
}

class FailedRegistrationState extends RegistrationState {
  final String message;
  FailedRegistrationState({this.message});
  @override
  List<Object> get props => [message];
}
