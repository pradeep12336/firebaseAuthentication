import 'package:flutter_bloc/flutter_bloc.dart';

class OnChangedPhoneBloc extends Bloc<String, bool> {
  OnChangedPhoneBloc() : super(false);

  @override
  Stream<bool> mapEventToState(String event) async* {
    if (event != null) {
      if (event.isNotEmpty) {
        yield true;
      } else {
        yield false;
      }
    } else {
      yield false;
    }
  }
}
