// ignore_for_file: camel_case_types

part of 'dna_cubit.dart';

@immutable
sealed class DnaState {}

final class DnaInitial extends DnaState {}
class changemodestate extends DnaState {}
class changeresultstate extends DnaState {}
class d2sucssess extends DnaState {}
class d2failed extends DnaState {}
class gestersucssess extends DnaState {}
class gesterfailed extends DnaState {}
class predictsucssess extends DnaState {}
class predictfailed extends DnaState {}
class atomsucssess extends DnaState {}
class atomfailed extends DnaState {}
class sdfsucssess extends DnaState {}
class sdffailed extends DnaState {}
class sdftosmilesucssess extends DnaState {}
class sdffilesucssess extends DnaState {}
class sdffilefailed extends DnaState {}
