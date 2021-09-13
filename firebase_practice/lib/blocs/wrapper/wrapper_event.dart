part of 'wrapper_bloc.dart';

@immutable
abstract class WrapperEvent {}

@immutable
abstract class WrapperInitialEvent {}

@immutable
class UserSignedInEvent extends WrapperEvent {}

@immutable
class UserSignedOutEvent extends WrapperEvent {}
