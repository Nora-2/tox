// ignore_for_file: camel_case_types

part of 'smilarty_cubit.dart';

@immutable
sealed class SmilartyState {}

final class SmilartyInitial extends SmilartyState {}
class changemodestate extends SmilartyState {}
class changeresultstate extends SmilartyState {}
