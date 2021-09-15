import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class Injector {
  const Injector._();

  static GetIt get _instance => GetIt.instance;

  static GlobalKey<NavigatorState> get navigatorKey => _instance.get<GlobalKey<NavigatorState>>();

  static GlobalKey<FormState> get formKey => _instance.get<GlobalKey<FormState>>();

  static void registerObjects() {
    {
      _instance.registerSingleton<GlobalKey<NavigatorState>>(
        GlobalKey<NavigatorState>(),
      );
    }

    {
      _instance.registerSingleton<GlobalKey<FormState>>(
        GlobalKey<FormState>(),
      );
    }
  }
}