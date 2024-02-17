// ignore_for_file: camel_case_types

part of 'molecule_cubit.dart';

@immutable
sealed class MoleculeState {}

final class MoleculeInitial extends MoleculeState {}
class changemodestate extends MoleculeState {}
class changeresultstate extends MoleculeState {}
