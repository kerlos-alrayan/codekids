import 'package:flutter_bloc/flutter_bloc.dart';

class StepCubit extends Cubit<int> {
  StepCubit() : super(1); // نبدأ من الخطوة رقم 1

  void nextStep(int totalSteps) {
    if (state < totalSteps) {
      emit(state + 1);
    }
  }

  void previousStep() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
