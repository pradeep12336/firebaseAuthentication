import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FirebaseAuthProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> RegisterAccount({String email, String password}) async {
    UserCredential regData = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    //await firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: )
    return regData;
  }

  Future<UserCredential> SignIn({String email, String pass, String phone, BuildContext context}) async {
    final formKey = GlobalKey<FormBuilderState>();
    /*UserCredential sigData = await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
    ConfirmationResult phDta = await firebaseAuth.signInWithPhoneNumber(
      phone,
    );*/

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential authCredential) async {},
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("insert otp"),
                content: FormBuilder(
                  autovalidateMode: AutovalidateMode.always,
                  key: formKey,
                  child: FormBuilderTextField(
                    attribute: 'otpCode',
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text("submit"),
                    onPressed: () async {
                      if (formKey.currentState.saveAndValidate()) {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: formKey.currentState.value['otpCode'],
                        );
                        await firebaseAuth.signInWithCredential(credential);
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });

        // PhoneAuthCredential credential =
        // PhoneAuthProvider.credential(verificationId: verificationId, smsCode: forceResendingToken.toString());
        // await firebaseAuth.signInWithCredential(credential);

        // return print("phone number $verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Time out");
      },
      timeout: Duration(seconds: 60),
    );

    return null;
  }

  // Stream<User> get CurrentUser => firebaseAuth.authStateChanges();
  // Future<UserCredential> SignWithUserCredential(AuthCredential credential) async {
  //   return firebaseAuth.signInWithCredential(credential);
  // }

  Future<void> Signout() async {
    return await firebaseAuth.signOut();
  }
}
