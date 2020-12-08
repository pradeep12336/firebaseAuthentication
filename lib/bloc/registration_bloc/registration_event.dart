import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitRegistrationEvent extends RegistrationEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  SubmitRegistrationEvent({@required this.name, @required this.email, @required this.password, @required this.phone});
}
