import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/screens/wrapper.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Injector.registerObjects();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WrapperBloc(authService: AuthService()),
        child: Wrapper(),
      ),
    );
  }
}