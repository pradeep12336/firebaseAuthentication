import 'package:flutter_bloc/flutter_bloc.dart';

class OnChnagedNameBloc extends Bloc<bool, bool> {
  OnChnagedNameBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
