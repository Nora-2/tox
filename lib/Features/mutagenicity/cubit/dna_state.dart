// ignore_for_file: camel_case_types

part of 'dna_cubit.dart';

@immutable
sealed class DnaState {}

final class DnaInitial extends DnaState {}
class changemodestate extends DnaState {}
class changeresultstate extends DnaState {}
