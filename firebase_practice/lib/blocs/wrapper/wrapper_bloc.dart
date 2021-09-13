import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:meta/meta.dart';

part 'wrapper_event.dart';
part 'wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  AuthService authService;
  StreamSubscription? authSubscription;

  WrapperBloc({required this.authService}) : super(WrapperInitialState()) {
    _subscribe();
  }

  @override
  Stream<WrapperState> mapEventToState(WrapperEvent event) async* {
    if (event is UserSignedOutEvent) {
      yield UserSignedOutState();
    }
    else if (event is UserSignedInEvent) {
      yield UserSignedInState();
    }
  }

  void _subscribe() {
    this.authSubscription = authService.user.listen((user) {
      print('signed in: ${user?.toString()}');
      if (user == null) {
        add(UserSignedOutEvent());
      }
      else {
        add(UserSignedInEvent());
      }
    });
    print('auth subscription enabled!');
  }

  @override
  Future<void> close() {
    print('auth subscription cancelled!');
    this.authSubscription?.cancel();
    return super.close();
  }
}
