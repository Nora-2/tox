
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'livercubit_state.dart';

class LivercubitCubit extends Cubit<LivercubitState> {
  LivercubitCubit() : super(LivercubitInitial());
  static LivercubitCubit get(context) => BlocProvider.of(context);

  
  bool issubmit = false;
  void changemode() {
    issubmit = !issubmit;
    emit(changemodestate());
  }
}
