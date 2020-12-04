import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextConfirmBloc extends Bloc<bool, bool> {
  ObscureTextConfirmBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
