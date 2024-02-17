// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
   bool ispassword = true;
   
    void changepass() {
      ispassword = !ispassword;
      emit(changepassstate());
    }
   Future<void> registerUser(
      {required String email, required String password,}) async {
    emit(Registerloading());
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword
          (email: email, password: password,);
      emit(Registersucsess());
    }on FirebaseAuthException catch (ex) {
                              if (ex.code == 'weak-password') {
                                 emit(Registerfailure(error: 'weak-password'));
                              } else if (ex.code == 'email-already-in-use') {
                              
                                
      emit(Registerfailure(error: 'email-already-in-use'));
                              }
                            

    }
    catch(e){
        emit(Registerfailure(error: 'somthing went wrong'));
    }
  }

  

}

