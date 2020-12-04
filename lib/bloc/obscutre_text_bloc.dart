import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextBloc extends Bloc<bool, bool> {
  ObscureTextBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
