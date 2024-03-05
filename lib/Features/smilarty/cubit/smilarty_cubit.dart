import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'smilarty_state.dart';

class SmilartyCubit extends Cubit<SmilartyState> {
  SmilartyCubit() : super(SmilartyInitial());
  static SmilartyCubit get(context) => BlocProvider.of(context);

  bool issubmit = false;
 viewResult()  {
    issubmit = !issubmit;
    emit(changemodestate());
  }
}
