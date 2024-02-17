import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'livercubit_state.dart';

class LivercubitCubit extends Cubit<LivercubitState> {
  LivercubitCubit() : super(LivercubitInitial());
  static LivercubitCubit get(context) => BlocProvider.of(context);

  bool result = false;
  void changeresult() {
    result = !result;
    emit(changeresultstate());
  }
  bool issubmit = false;
  void viewResult() {
    issubmit = !issubmit;
    emit(changemodestate());
  }
}
