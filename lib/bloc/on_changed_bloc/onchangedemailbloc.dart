import 'package:flutter_bloc/flutter_bloc.dart';

class OnChangedEmailBloc extends Bloc<bool, bool> {
  OnChangedEmailBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
