// ignore_for_file: non_constant_identifier_names

import 'package:Toxicon/Features/convertScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/home/presentation/view/home.dart';
import 'package:Toxicon/Features/settings/presentation/view/setting.dart';


part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit() : super(HomecubitInitial());
  static HomecubitCubit get(context) => BlocProvider.of(context);
 
  List<Widget> Screens = [
   const homeScreen(),
   const SettingScreen(),
   const convertScreen()
  ];
  int indexBottomNavBar = 0;
  void changeIndexBottom(int x) {
    indexBottomNavBar = x;
    emit(BottomNavBarChanged());
  }
}
