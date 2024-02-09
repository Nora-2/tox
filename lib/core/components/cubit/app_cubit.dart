
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

