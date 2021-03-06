import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:nayaproject/bloc/confirm_password_bloc.dart';
import 'package:nayaproject/bloc/obscure_confirm_password_bloc.dart';
import 'package:nayaproject/bloc/obscutre_text_bloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedconfirmpasswordbloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedemailbloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangednamebloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedphonebloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchnagedpasswordbloc.dart';
import 'package:nayaproject/bloc/registration_bloc/registration_bloc.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in__state.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in_bloc.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in_event.dart';
import 'package:nayaproject/view/RegistrationPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _cController = TextEditingController();
  TextEditingController _pcontroller = TextEditingController();
  final GlobalKey<FormBuilderState> _gkey = GlobalKey<FormBuilderState>();
  bool isFacebookLoginIn = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (BuildContext context, state) {
        if (state is SubmitSignInState) {
          print("sign in data is ${state.signInData.user}");
          if (state.signInData.user.emailVerified) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return Container();
            }));
          } else {
            BotToast.showText(text: "Email is Not verified, please verify ");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Sign  in Page"),
          centerTitle: true,
        ),
        body: Container(
            //color: Colors.teal[100],
            child: FormBuilder(
          key: _gkey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                FormBuilderTextField(
                  attribute: 'email',
                  validators: [
                    //   FormBuilderValidators.required(),
                    //   FormBuilderValidators.email(),
                  ],
                  decoration: InputDecoration(
                    hintText: 'pradipgautam@email.com ',
                    labelText: 'Email',
                    fillColor: Colors.red,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                BlocBuilder<ObscureTextBloc, bool>(builder: (context, snapshot) {
                  return FormBuilderTextField(
                    controller: _pcontroller,
                    attribute: 'password',
                    validators: [
                      // FormBuilderValidators.required(),
                      // FormBuilderValidators.numeric(),
                      // FormBuilderValidators.maxLength(10),
                    ],
                    decoration: InputDecoration(
                        hintText: 'Passsword',
                        labelText: 'Password',
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(snapshot ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            BlocProvider.of<ObscureTextBloc>(context).add(!snapshot);
                          },
                        )),
                    obscureText: snapshot,
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                FormBuilderPhoneField(
                  attribute: 'phone',
                  validators: [
                    //  FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(14, errorText: "phone number cannot be greTHER THAN 10")
                  ],
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    labelText: "Phone Number",
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  defaultSelectedCountryIsoCode: 'Np',
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SignInButton(
                      Buttons.Email,
                      onPressed: () {
                        {
                          if (_gkey.currentState.saveAndValidate()) {
                            final value = _gkey.currentState.value;
                            print(" sign in value $value");
                            BlocProvider.of<SignInBloc>(context).add(
                              SubmitSignInEvent(
                                email: value['email'],
                                password: value['password'],
                                phone: value['phone'],
                              ),
                            );
                          }
                        }
                      },
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      onPressed: () {
                        facebookLogins(context).then((user) {
                          if (user != null) {
                            print("Login is successfully");
                          }
                        });

                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => HomePage(),
                        //   ),
                        // );
                      },
                    ),
                    RaisedButton(
                      elevation: 5,
                      child: Text('Continue With Phone Number'),
                      onPressed: () {
                        if (_gkey.currentState.saveAndValidate()) {
                          final value = _gkey.currentState.value;
                          verifyPhoneNumber(context, phone: value['phone']);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "If You haven't any account  please click here!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 90,
                    right: 90,
                  ),
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text("Click Here"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<ObscureTextBloc>(context),
                            child: BlocProvider.value(
                                value: BlocProvider.of<ConfirmPasswordBloc>(context),
                                child: BlocProvider.value(
                                    value: BlocProvider.of<RegistrationBloc>(context),
                                    child: BlocProvider.value(
                                      value: BlocProvider.of<ObscureTextConfirmBloc>(context),
                                      child: BlocProvider.value(
                                          value: BlocProvider.of<OnChnagedNameBloc>(context),
                                          child: BlocProvider.value(
                                            value: BlocProvider.of<OnChangedEmailBloc>(context),
                                            child: BlocProvider.value(
                                              value: BlocProvider.of<OnChangedPasswordBloc>(context),
                                              child: BlocProvider.value(
                                                value: BlocProvider.of<OnChangedConfirmPasswordBloc>(context),
                                                child: BlocProvider.value(
                                                  value: BlocProvider.of<OnChangedPhoneBloc>(context),
                                                  child: RegistrationPage(),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ))),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<User> facebookLogins(BuildContext context) async {
    User currentUsers;
    try {
      FacebookLoginResult facebookLoginResult = await FacebookLogin().logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      if (facebookLoginResult.status == FacebookLoginStatus.Success) {
        FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken.token);
        UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        final User users = userCredential.user;
        print("current users ingfo is ${users.photoURL}");
        assert(users.email != null);
        assert(users.displayName != null);
        assert(!users.isAnonymous);
        assert(await users.getIdToken() != null);
        currentUsers = await firebaseAuth.currentUser;
        assert(users.uid == currentUsers.uid);
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog();
            });

        // return currentUsers;
      }
    } catch (e) {
      print("error in facebookLogin$e");
    }
  }

  void verifyPhoneNumber(BuildContext context, {String phone}) async {
    final formKey = GlobalKey<FormBuilderState>();

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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Time out");
      },
      timeout: Duration(seconds: 60),
    );
  }

  // Future SingInUser(phone, BuildContext context) async {
  //   firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (AuthCredential authCredential) {},
  //     verificationFailed: (FirebaseAuthException authException) {
  //       print(authException.message);
  //     },
  //     codeSent: (String verificationId, [int ForceResendingToken]) {
  //       showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text("Give the Code?"),
  //               content: Column(
  //                 children: [
  //                   TextField(
  //                     controller: _cController,
  //                   )
  //                 ],
  //               ),
  //               actions: [
  //                 FlatButton(
  //                   child: Text("Confirm"),
  //                   textColor: Colors.white,
  //                   onPressed: () async {
  //                     final code = _cController.text.trim();
  //                     AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
  //                     UserCredential result = await firebaseAuth.signInWithCredential(authCredential);
  //                     User user = result.user;
  //                     if (user != null) {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (_) => HomePage(),
  //                           ));
  //                     }
  //                   },
  //                 )
  //               ],
  //             );
  //           });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //       print(verificationId);
  //       print("Time out");
  //     },
  //   );
  // }
}
