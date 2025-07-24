import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lms/Module/Auth/Model/user_auth_model.dart';

import 'package:lms/Module/Auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  UserAuthModel? userAuthModel;
  // LOGIN
  TextEditingController emailLogctrl = TextEditingController(
    text: "eng.tayseermatar@gmail.com",
  );
  TextEditingController passWordLogctrl = TextEditingController(
    text: "1234/*-+Asa",
  );

  ///  RIGESTER
  final TextEditingController nameCtrl = TextEditingController(text: "tayseer");
  final TextEditingController emailRegCtrl = TextEditingController(
    text: "eng.tayseermtar@gmail.com",
  );
  final TextEditingController passwordRegCtrl = TextEditingController(
    text: "1234/*-+Asa",
  );
  final TextEditingController confirmPasswordCtrl = TextEditingController(
    text: "1234/*-+Asa",
  );

  final TextEditingController githubAccount = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  bool obscuretext = true;
  bool isEmail = true, showIsNotEmail = false;
  bool isPassWord = true;
  bool isPassWordconf = true;

//////////////   validation
  ///

  void showPassword() {
    obscuretext = !obscuretext;
    emit(ShowPassword());
  }

  void validEmail(String email) {
    if (GlobalFunc.validEmail(email)) {
      isEmail = true;
      showIsNotEmail = false;
      emit(IsEmail());
    } else {
      isEmail = false;
      showIsNotEmail = true;
      emit(IsNotEmail());
    }
  }

  void passwordValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit((FalsePasswordFormat()));
      isPassWord = false;
    } else {
      emit(TruePasswordFormat());
      isPassWord = true;
    }
  }

  void passwordConfValid({required String password}) {
    // Check length (>= 8)
    if (!GlobalFunc.passwordValid(password: password)) {
      emit((FalsePasswordConfirmationFormat()));
      isPassWordconf = false;
    } else {
      emit(TruePasswordconfirmationFormat());
      isPassWordconf = true;
    }
  }

////////////  login
  ///
  void logIn() async {
    if (emailLogctrl.text.isEmpty || passWordLogctrl.text.isEmpty) {
      emit(LogInvalidate());
    } else {
      emit(LogInLoading());

      try {
        final response = await DioHelper.postData(
          url: "login",
          postData: {
            'email': emailLogctrl.text,
            'password': passWordLogctrl.text,
          },
          headers: {"Accept": "application/json"},
        );

        print("Status Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          userAuthModel = UserAuthModel.fromJson(response.data);
          CacheHelper.saveData(key: "token", value: userAuthModel?.token);
          CacheHelper.saveData(key: "role", value: userAuthModel?.role);
          CacheHelper.saveData(key: "user_id", value: userAuthModel?.userId);

          print('token${userAuthModel?.token}');
          emit(LogInsucess());
        }
      } on DioException catch (e) {
        // Check if there's a response from the server
        if (e.response != null) {
          print("Error Status: ${e.response?.statusCode}");

          if (e.response?.statusCode == 401 || e.response?.statusCode == 422) {
            emit(CheckInfo());
          } else {
            emit(LogInError(message: "error"));
          }
        } else {
          // No response received (network error, timeout, etc.)
          print("Connection Error: $e");
          emit(LogInErrorConnection(message: "Connection Error"));
        }
      }
    }
  }

//// google login
  ///

   
 final GoogleSignIn _googleSignIn = GoogleSignIn(
   scopes: <String>[
    'openid',        
    'email',
    'profile',      
  ],

   
  clientId:  dotenv.env['GOOGLE_CLIENT_ID'],
);



Future<void> loginWithGoogle({bool forceChooser = false}) async {
 try {
    // 1️⃣ خَرْجْ المستخدم أولاً (يزيل الجلسة المخبَّأة)
    await _googleSignIn.signOut();

    // ملاحظة: إذا كنت تريد أيضاً إلغاء ربط التطبيق من الحساب
    // استخدم await _googleSignIn.disconnect();

    // 2️⃣ استدعِ شاشة اختيار الحساب
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account == null) {
      debugPrint('🔸 المستخدم ألغى العملية.');
      return;
    }

    // 3️⃣ احصل على التوكينات كالمعتاد
    final auth = await account.authentication;
    debugPrint('✅ ID‑Token: ${auth.idToken}');
    debugPrint('✅ Access‑Token: ${auth.accessToken}');
  } catch (e, st) {
    debugPrint('❌ خطأ: $e');
    debugPrint(st.toString());
  }
}




//////////   signup
  void signUp() async {
    if (nameCtrl.text.isEmpty ||
        emailRegCtrl.text.isEmpty ||
        passwordRegCtrl.text.isEmpty ||
        confirmPasswordCtrl.text.isEmpty) {
      emit(SignUpError(message: "All fields are required"));
      return;
    }

    if (passwordRegCtrl.text != confirmPasswordCtrl.text) {
      emit(SignUpError(message: "Passwords do not match"));
      return;
    }

    emit(SignUpLoading());

    try {
      final response = await DioHelper.postData(
        url: "register",
        postData: {
          "name": nameCtrl.text.trim(),
          "email": emailRegCtrl.text.trim(),
          "password": passwordRegCtrl.text,
          "password_confirmation": confirmPasswordCtrl.text,
          "gitHub_account": githubAccount.text,
          "bio": bioCtrl.text,
          "fcm_token": "",
          "image": ""
        },
        headers: {"Accept": "application/json"},
      );
      final responseData = response.data;

      if (response.statusCode == 200) {
        emit(SignUpSuccess());
        print(state);
        print(response.data);
        print("token${response.data['token']}");
        // CacheHelper.saveData(key: "access_token", value: response.data['token']);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error Status: ${e.response?.statusCode}");

        if (e.response?.statusCode == 422) {
          emit(SignUpError(
              message: "there is already an account with this email address"));
        } else {
          emit(SignUpError(message: "Error"));
        }
      } else {
        print("Connection Error: $e");
        emit(SignUpError(message: "Connection Error"));
      }
    }
  }

  //  refresh token
  Future<bool> refreshAccessToken() async {
    var token = CacheHelper.getData(key: "token");
    try {
      final response = await DioHelper.postData(
        url: 'token/refresh',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await CacheHelper.saveData(key: 'token', value: response.data['token']);

        return true;
      }
    } catch (e) {
      print(" Connection Error $e");
    }
    return false;
  }
}
