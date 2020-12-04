import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordBloc extends Bloc<String, String> {
  ConfirmPasswordBloc(String initialState) : super(initialState);

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
