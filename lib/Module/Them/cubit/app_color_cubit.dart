import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(_getInitialTheme());

  static ThemeState _getInitialTheme() {
    final isLight = CacheHelper.getData(key: "lightMode");
    if (isLight == null) {
      return ThemeState.dark(); // الافتراضي إذا لا يوجد قيمة محفوظة
    } else if (isLight == true) {
      return ThemeState.light();
    } else {
      return ThemeState.dark();
    }
  }

  void toggleTheme() {
    if (state.isDarkMode) {
      emit(ThemeState.light());
      CacheHelper.saveData(key: "lightMode", value: true);
    } else {
      emit(ThemeState.dark());
      CacheHelper.saveData(key: "lightMode", value: false);
    }
  }
}
