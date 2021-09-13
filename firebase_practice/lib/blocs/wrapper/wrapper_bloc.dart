import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wrapper_event.dart';
part 'wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(WrapperInitial());

  @override
  Stream<WrapperState> mapEventToState(
    WrapperEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
