// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/Features/home/presentation/view/home.dart';
import 'package:sports_app/Features/settings/presentation/view/setting.dart';


part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit() : super(HomecubitInitial());
  static HomecubitCubit get(context) => BlocProvider.of(context);
 
  List<Widget> Screens = [
   const homeScreen(),
   const SettingScreen()
  ];
  int indexBottomNavBar = 0;
  void changeIndexBottom(int x) {
    indexBottomNavBar = x;
    emit(BottomNavBarChanged());
  }
}
