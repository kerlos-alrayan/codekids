import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);
  void changeIndex(int newIndex) => emit(newIndex);
}
