// ignore_for_file: camel_case_types

part of 'livercubit_cubit.dart';

@immutable
sealed class LivercubitState {}

final class LivercubitInitial extends LivercubitState {}
class changemodestate extends LivercubitState {}
class changeresultstate extends LivercubitState {}
class gestersucssess extends LivercubitState {}
class gesterfailed extends LivercubitState {}
class predictsucssess extends LivercubitState {}
class predictfailed extends LivercubitState {}
class atomsucssess extends LivercubitState {}
class atomfailed extends LivercubitState {}
class d2sucssess extends LivercubitState {}
class d2failed extends LivercubitState {}