// ignore_for_file: camel_case_types

part of 'livercubit_cubit.dart';

@immutable
sealed class LivercubitState {}

final class LivercubitInitial extends LivercubitState {}
class changemodestate extends LivercubitState {}
class changeresultstate extends LivercubitState {}