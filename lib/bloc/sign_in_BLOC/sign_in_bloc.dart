import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in__state.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in_event.dart';
import 'package:nayaproject/firebaseauth/firebase_auth.dart';
import 'package:nayaproject/firestore_provider/firestore_provider.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();
  FirestoreProvider firestoreProvider = FirestoreProvider();
  SignInBloc() : super(EmptySiginInState());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SubmitSignInEvent) {
      yield LoaderSignInState();
      try {
        UserCredential signinData = await firebaseAuthProvider.SignIn(
          email: event.email,
          pass: event.password,
          phone: event.phone,
        );
        await signinData.user.sendEmailVerification();
        yield SubmitSignInState(signInData: signinData);
      } catch (e) {
        print("error in signing $e");
      }
    }
  }
}
