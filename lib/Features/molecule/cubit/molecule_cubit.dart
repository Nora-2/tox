import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'molecule_state.dart';

class MoleculeCubit extends Cubit<MoleculeState> {
  MoleculeCubit() : super(MoleculeInitial());
  static MoleculeCubit get(context) => BlocProvider.of(context);

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
