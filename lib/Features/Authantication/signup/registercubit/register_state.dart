part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class Registerloading extends RegisterState {}

class Registersucsess extends RegisterState {}
class changepassstate extends RegisterState {}

// ignore: must_be_immutable
class Registerfailure extends RegisterState {
  String error;
  Registerfailure({required this.error});
}

