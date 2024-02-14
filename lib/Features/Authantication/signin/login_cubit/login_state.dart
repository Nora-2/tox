// ignore_for_file: camel_case_types

part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loginloading extends LoginState {}

class Loginsucsess extends LoginState {}
class changepassstate extends LoginState {}

// ignore: must_be_immutable
class Loginfailure extends LoginState {
  String error;
  Loginfailure({required this.error});
}
