import 'package:bot_toast/bot_toast.dart';
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
import 'package:nayaproject/bloc/registration_bloc/registration_event.dart';
import 'package:nayaproject/bloc/registration_bloc/registration_state.dart';

class RegistrationPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _rKey = GlobalKey<FormBuilderState>();
  TextEditingController _pController = TextEditingController();
  TextEditingController _cpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (BuildContext context, RegState) {
        if (RegState is OnDataRegistrationState) {
          BotToast.showText(text: "Registration Is Done");
        } else {
          BotToast.showText(text: "this email is Already Registered by   Othres users");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "Registration Page",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // padding: EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: FormBuilder(
              key: _rKey,
              autovalidateMode: AutovalidateMode.always,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: BlocBuilder<OnChnagedNameBloc, bool>(builder: (context, nameBool) {
                      return FormBuilderTextField(
                        onChanged: (value) {
                          BlocProvider.of<OnChnagedNameBloc>(context).add(!nameBool);
                        },
                        attribute: "name",
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                        decoration: InputDecoration(
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
                            hintText: "Enter the User Name",
                            labelText: "User Name",
                            filled: true,
                            fillColor: nameBool ? Colors.white : Colors.teal.withOpacity(0.4)),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: BlocBuilder<OnChangedEmailBloc, bool>(builder: (context, EmailBool) {
                      return FormBuilderTextField(
                        onChanged: (value) {
                          BlocProvider.of<OnChangedEmailBloc>(context).add(!EmailBool);
                        },
                        attribute: "email",
                        validators: [FormBuilderValidators.required(), FormBuilderValidators.email()],
                        decoration: InputDecoration(
                          hintText: "Enter the Email id",
                          labelText: "User Email",
                          filled: true,
                          fillColor: EmailBool ? Colors.white : Colors.teal[100],
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
                      );
                    }),
                  ),
                  BlocBuilder<ConfirmPasswordBloc, String>(builder: (context, snapshot) {
                    return BlocBuilder<ObscureTextBloc, bool>(builder: (context, obscuretext) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: BlocBuilder<OnChangedPasswordBloc, bool>(builder: (context, PassswordBool) {
                          return FormBuilderTextField(
                            attribute: "password",
                            controller: _pController,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(12),
                              FormBuilderValidators.minLength(8),
                            ],
                            decoration: InputDecoration(
                                hintText: "Password",
                                labelText: "Password",
                                filled: true,
                                fillColor: PassswordBool ? Colors.white : Colors.teal[100],
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
                                  color: obscuretext ? Colors.red : Colors.blueAccent,
                                  icon: Icon(obscuretext ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    BlocProvider.of<ObscureTextBloc>(context).add(!obscuretext);
                                  },
                                )),
                            onChanged: (string) {
                              BlocProvider.of<OnChangedPasswordBloc>(context).add(!PassswordBool);
                              BlocProvider.of<ConfirmPasswordBloc>(context).add(string);
                            },
                            obscureText: obscuretext,
                          );
                        }),
                      );
                    });
                  }),
                  BlocBuilder<ObscureTextConfirmBloc, bool>(builder: (context, boolValue) {
                    return BlocBuilder<ConfirmPasswordBloc, String>(builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: BlocBuilder<OnChangedConfirmPasswordBloc, bool>(builder: (context, CPasswordBool) {
                          return FormBuilderTextField(
                            attribute: "cPassword",
                            onChanged: (value) {
                              BlocProvider.of<OnChangedConfirmPasswordBloc>(context).add(!CPasswordBool);
                            },
                            controller: _cpController,
                            validators: [
                              FormBuilderValidators.required(),
                              (val) {
                                if (snapshot == val.toString()) {
                                  return null;
                                } else {
                                  return 'password doesnot match';
                                }
                              }
                            ],
                            decoration: InputDecoration(
                              hintText: "Re_Enter password",
                              labelText: "Confirm Password",
                              filled: true,
                              fillColor: CPasswordBool ? Colors.white : Colors.teal[100],
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
                                icon: Icon(
                                  boolValue ? Icons.visibility_off : Icons.visibility,
                                  color: boolValue ? Colors.red : Colors.blueAccent,
                                ),
                                onPressed: () {
                                  BlocProvider.of<ObscureTextConfirmBloc>(context).add(!boolValue);
                                },
                              ),
                            ),
                            obscureText: boolValue,
                          );
                        }),
                      );
                    });
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: BlocBuilder<OnChangedPhoneBloc, bool>(builder: (context, snapshot) {
                      return FormBuilderPhoneField(
                        onChanged: (value) {
                          BlocProvider.of<OnChangedPhoneBloc>(context).add(!snapshot);
                        },
                        attribute: 'phone',
                        validators: [FormBuilderValidators.required()],
                        defaultSelectedCountryIsoCode: 'NP',
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Phone Number",
                          filled: true,
                          fillColor: snapshot ? Colors.white : Colors.teal[100],
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
                      );
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: [
                      BlocBuilder<RegistrationBloc, RegistrationState>(builder: (context, snapshot) {
                        return RaisedButton(
                          color: Colors.redAccent,
                          onPressed: () {
                            _rKey.currentState.saveAndValidate();
                            final datass = _rKey.currentState.value;

                            BlocProvider.of<RegistrationBloc>(context).add(SubmitRegistrationEvent(name: datass['name'], email: datass['email'], password: datass['password']));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                      RaisedButton(
                        color: Colors.redAccent,
                        child: Text("Cancel", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
