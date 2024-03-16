// ignore_for_file: camel_case_types

part of 'molecule_cubit.dart';

@immutable
sealed class MoleculeState {}

final class MoleculeInitial extends MoleculeState {}
class changemodestate extends MoleculeState {}
class changeresultstate extends MoleculeState {}
class gestersucssess extends MoleculeState {}
class gesterfailed extends MoleculeState {}
class predictsucssess extends MoleculeState {}
class predictfailed extends MoleculeState {}
class atomsucssess extends MoleculeState {}
class atomfailed extends MoleculeState {}
class d2sucssess extends MoleculeState {}
class d2failed extends MoleculeState {}
class sasucssess extends MoleculeState {}
class safailed extends MoleculeState {}
