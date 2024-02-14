// ignore_for_file: unused_local_variable

import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
   static LoginCubit get(context) => BlocProvider.of(context);
   bool ispassword = true;
   
    void changepass() {
      ispassword = !ispassword;
      emit(changepassstate());
    }

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(Loginloading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(Loginsucsess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(Loginfailure(error: 'user-not-found'));
      } else if (ex.code == 'wrong-password') {
        emit(Loginfailure(error: 'wrong-password'));
      }
    } catch (e) {
      emit(Loginfailure(error: 'somthing went wrong'));
    }
    
    bool _validate(
            String name, String email, String password, String rePassword) =>
        Checker.checkName(name) &&
        Checker.checkEmail(email) &&
        Checker.checkPassword(password) &&
        password == rePassword;

    void _wrongCase(BuildContext context, String name, String email,
        String password, String rePassword) {
      if (!Checker.checkName(name) || name.isEmpty) {
        AppMessage.customSnackBar(context: context, content: "Invalid name");
      } else if (!Checker.checkEmail(email) || email.isEmpty) {
        AppMessage.customSnackBar(context: context, content: "Invalid email");
      } else if (!Checker.checkPassword(password) || password.isEmpty) {
        AppMessage.customSnackBar(
            context: context, content: "Invalid password");
      } else if (!(password == rePassword) || rePassword.isEmpty) {
        AppMessage.customSnackBar(
            context: context, content: "Password must match");
      }
    }
  }
}
