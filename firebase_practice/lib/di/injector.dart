import 'package:firebase_practice/screens/authenticate/authenticate.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class Injector {
  const Injector._();

  static GetIt get _instance => GetIt.instance;

  static GlobalKey<NavigatorState> get navigatorKey => _instance.get<GlobalKey<NavigatorState>>();

  static void registerObjects() {
    {
      _instance.registerSingleton<GlobalKey<NavigatorState>>(
        GlobalKey<NavigatorState>(),
      );
    }
  }
}