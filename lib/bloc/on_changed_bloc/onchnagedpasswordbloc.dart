import 'package:flutter_bloc/flutter_bloc.dart';

class OnChangedPasswordBloc extends Bloc<bool, bool> {
  OnChangedPasswordBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
