import 'package:flutter_bloc/flutter_bloc.dart';

class BirthDateCubit extends Cubit<DateTime?> {
  BirthDateCubit() : super(null);

  void selectDate(DateTime date) {
    emit(date);
  }
}
