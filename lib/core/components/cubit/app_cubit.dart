import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
    static AppCubit get(context) => BlocProvider.of(context);
 
  ThemeMode appmode = ThemeMode.dark;
  bool isdark = false;
  void changemode() {
    isdark = !isdark;
    emit(changemodestate());
  }
}

