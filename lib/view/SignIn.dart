import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _cController = TextEditingController();
  TextEditingController _pcontroller = TextEditingController();
  final GlobalKey<FormBuilderState> _gkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (BuildContext context, state) {
        if (state is SubmitSignInState) {
          // print("sign in data is ${state.signInData.user}");
          if (state.signInData.user.emailVerified) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HomePage(user: state.signInData.user);
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
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
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
                    attribute: 'password',
                    validators: [
                      FormBuilderValidators.required(),
                      // FormBuilderValidators.numeric(),
                      FormBuilderValidators.maxLength(10),
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
                    FormBuilderValidators.required(),
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
                Center(
                  child: RaisedButton(
                    child: Text("SignIn"),
                    onPressed: () {
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
                        // final cont = _pcontroller.text.trim();
                        // SingInUser(cont, context);
                      }
                    },
                  ),
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
  //                             builder: (_) => HomePage(user: user),
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
