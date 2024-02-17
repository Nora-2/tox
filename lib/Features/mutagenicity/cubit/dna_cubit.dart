import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dna_state.dart';

class DnaCubit extends Cubit<DnaState> {
  DnaCubit() : super(DnaInitial());
  static DnaCubit get(context) => BlocProvider.of(context);

  bool result = false;
  void changeresult() {
    result = !result;
    emit(changeresultstate());
  }

  bool issubmit = false;
  void changemode() {
    issubmit = !issubmit;
    emit(changemodestate());
  }
}
