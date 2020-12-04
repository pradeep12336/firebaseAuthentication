import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignInEvent extends Equatable {}

class SubmitSignInEvent extends SignInEvent {
  final String email;
  final String password;
  final String phone;

  SubmitSignInEvent({@required this.email, @required this.password, @required this.phone});

  @override
  List<Object> get props => [email, password, phone];
}
