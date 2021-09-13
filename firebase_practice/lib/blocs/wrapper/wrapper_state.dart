part of 'wrapper_bloc.dart';

@immutable
abstract class WrapperState {}

class WrapperInitialState extends WrapperState {}

class UserSignedInState extends WrapperState {}

class UserSignedOutState extends WrapperState {}
