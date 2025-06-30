import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorGenderCubit extends Cubit<String> {
  SelectorGenderCubit() : super('');

  void selectGender(String gender) {
    emit(gender);
  }
}
