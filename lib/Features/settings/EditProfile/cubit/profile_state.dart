// ignore_for_file: camel_case_types
part of 'profile_cubit.dart';
@immutable
sealed class ProfileState {}
final class ProfileInitial extends ProfileState {}
class imagegalleryfailed extends ProfileState {}
class imagegallerysucssess extends ProfileState {}
class imagecamerafailed extends ProfileState {}
class imagecamerasucssess extends ProfileState {}
class uploadfailed extends ProfileState {}
class uploadsucssess extends ProfileState {}