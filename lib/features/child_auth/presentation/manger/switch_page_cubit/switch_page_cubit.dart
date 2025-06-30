import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchPageCubit extends Cubit<int> {
  SwitchPageCubit() : super(0);

  void nextStep() {
    if (state < 2) emit(state + 1);
  }

  void previousStep() {
    if (state > 0) emit(state - 1);
  }
}
