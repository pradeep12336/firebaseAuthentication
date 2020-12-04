import 'package:flutter_bloc/flutter_bloc.dart';

class OnChangedConfirmPasswordBloc extends Bloc<bool, bool> {
  OnChangedConfirmPasswordBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
