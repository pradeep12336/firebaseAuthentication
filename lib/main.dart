import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nayaproject/bloc/confirm_password_bloc.dart';
import 'package:nayaproject/bloc/obscure_confirm_password_bloc.dart';
import 'package:nayaproject/bloc/obscutre_text_bloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedconfirmpasswordbloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedemailbloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangednamebloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchangedphonebloc.dart';
import 'package:nayaproject/bloc/on_changed_bloc/onchnagedpasswordbloc.dart';
import 'package:nayaproject/bloc/registration_bloc/registration_bloc.dart';
import 'package:nayaproject/bloc/sign_in_BLOC/sign_in_bloc.dart';
import 'package:nayaproject/view/SignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAuth.instance.createUserWithEmailAndPassword(email: "radipgautam6911@gmail.com", password: "AhsinamKc");
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ObscureTextBloc(),
          ),
          BlocProvider(
            create: (_) => ConfirmPasswordBloc('null'),
          ),
          BlocProvider(
            create: (_) => RegistrationBloc(),
          ),
          BlocProvider(
            create: (_) => SignInBloc(),
          ),
          BlocProvider(
            create: (_) => ObscureTextConfirmBloc(),
          ),
          BlocProvider(
            create: (_) => OnChnagedNameBloc(),
          ),
          BlocProvider(
            create: (_) => OnChangedEmailBloc(),
          ),
          BlocProvider(
            create: (_) => OnChangedPasswordBloc(),
          ),
          BlocProvider(
            create: (_) => OnChangedConfirmPasswordBloc(),
          ),
          BlocProvider(
            create: (_) => OnChangedPhoneBloc(),
          ),
        ],
        child: StartingWidget(),
      ),
    );
  }
}

class StartingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
