import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nayaproject/bloc/registration_bloc/registration_event.dart';
import 'package:nayaproject/bloc/registration_bloc/registration_state.dart';
import 'package:nayaproject/firebaseauth/firebase_auth.dart';
import 'package:nayaproject/firestore_provider/firestore_provider.dart';
import 'package:nayaproject/model/data_model.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();
  FirestoreProvider firestoreProvider = FirestoreProvider();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  RegistrationBloc() : super(EmptyRegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is SubmitRegistrationEvent) {
      yield LoaderRegistrationState();
      try {
        final datas = await firebaseAuthProvider.RegisterAccount(email: event.email, password: event.password);
        Map<String, dynamic> data = {
          'name': event.name,
          'email': event.email,
          'phone': event.phone,
        };
        DataModel dataModel = DataModel.fromMap(data);
        await firestoreProvider.insertDataToFirestore(dataModel);
        yield OnDataRegistrationState(Datas: datas);
      } catch (e) {
        print("error in   registreation $e");
      }
    }
  }
}
