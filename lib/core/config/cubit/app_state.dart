// ignore_for_file: camel_case_types

part of 'app_cubit.dart';

@immutable
abstract class AppState {}

final class AppInitial extends AppState {}
class changemodestate extends AppState {}

class ChangeThemeModeState extends AppState {}

class GetDataFromSharedState extends AppState {}
class GetDataFromfirebasState extends AppState {}
