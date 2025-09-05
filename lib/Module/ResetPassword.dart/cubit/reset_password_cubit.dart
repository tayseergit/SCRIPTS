import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:lms/Module/ResetPassword.dart/cubit/reset_password_state.dart';
import 'package:lms/generated/l10n.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit() : super(PasswordResetInitial());

  final token = CacheHelper.getData(key: "token");
  final userId = CacheHelper.getData(key: "user_id");

  final oldPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmNewPasswordCtrl = TextEditingController();
  bool isPassword = true;
  bool isConfirmationPassword = true;

  void passwordValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit((ChangePassword()));
      isPassword = false;
    } else {
      emit(ChangePassword());
      isPassword = true;
    }
  }

  void passwordConfValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit((ChangePassword()));
      isConfirmationPassword = false;
    } else {
      emit(ChangePassword());
      isConfirmationPassword = true;
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    final oldPassword = oldPasswordCtrl.text.trim();
    final newPassword = newPasswordCtrl.text.trim();
    final confirmPassword = confirmNewPasswordCtrl.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(PasswordResetError(S.of(context).check_info));
      return;
    }

    if (!isPassword) {
      emit(PasswordResetError(
          S.of(context).at_least_8_char_lower_upper_symbols));
      return;
    }

    if (newPassword == oldPassword) {
      emit(PasswordResetError(S.of(context).error_old_password));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(PasswordResetError(S.of(context).passwords_do_not_match));
      return;
    }

    try {
      emit(PasswordResetLoading());
      final response = await DioHelper.postData(
        url: "password/reset",
        postData: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(PasswordResetSuccess(S.of(context).done));
      } else if (response.statusCode == 422) {
        emit(PasswordResetError(S.of(context).error_old_password));
      } else if (response.statusCode == 401 &&
          response.data['message'] == "Unauthenticated.") {
        emit(UnAuth());
      } else if (response.statusCode == 401 &&
          response.data['message'] == "Wrong old password!") {
        emit(PasswordResetError(S.of(context).error_old_password));
      } else {
        emit(PasswordResetError(S.of(context).error_occurred));
      }
    } catch (e) {
      emit(PasswordResetError(S.of(context).error_in_server));
    }
  }
}
