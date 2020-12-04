import 'package:flutter_bloc/flutter_bloc.dart';

class OnChangedPhoneBloc extends Bloc<bool, bool> {
  OnChangedPhoneBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
