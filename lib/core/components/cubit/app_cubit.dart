import 'package:Toxicon/core/components/cachhelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode appmode = ThemeMode.dark;
  // bool isdark = false;
  // void changemode() {
  //   isdark = !isdark;
  //   emit(changemodestate());
  
     List data = [];
  getdata() async {
  QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  data.addAll(quarysnapshot.docs);
      emit(GetDataFromfirebasState());
}

  bool isdark = false;
  void changemode({fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;

      print(isdark);
      emit(GetDataFromSharedState());
    } else {
      isdark = !isdark;
      print(isdark);
      CacheHelper.setBoolean(key: 'isDark', value: isdark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }
}
