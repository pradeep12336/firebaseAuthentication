import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> RegisterAccount({String email, String password}) async {
    UserCredential regData = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    //await firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: )
    return regData;
  }

  Future<UserCredential> SignIn({String email, String pass, String phone}) async {
    UserCredential sigData = await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
    //ConfirmationResult phDta = await firebaseAuth.signInWithPhoneNumber(phone);
    // await firebaseAuth.verifyPhoneNumber(
    //   phoneNumber: phone,
    //   verificationCompleted: (AuthCredential authCredential) {
    //     firebaseAuth.signInWithCredential(authCredential).then((UserCredential value) {
    //       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
    //       // return HomePage();
    //       //}));
    //     }).catchError((e) {
    //       print(e);
    //     });
    //   },
    //   verificationFailed: (FirebaseAuthException authException) {
    //     print(authException.message);
    //   },
    //   codeSent: (String verificationId, [int forceResendingToken]) {
    //     AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: forceResendingToken.toString());
    //     //UserCredential sig =firebaseAuth.signInWithCredential(credential);
    //     // User user = sig.user;
    //
    //     return print("phone number $verificationId");
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     verificationId = verificationId;
    //     print(verificationId);
    //     print("Time out");
    //   },
    //   timeout: Duration(seconds: 60),
    // );

    return sigData;
  }

  Future<void> Signout() async {
    return await firebaseAuth.signOut();
  }
}
