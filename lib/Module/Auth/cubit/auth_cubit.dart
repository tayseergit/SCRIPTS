import 'dart:io';

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
import 'package:http_parser/http_parser.dart';

import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/generated/l10n.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  UserAuthModel? userAuthModel;
  File? pickedImage;
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

  void setPickedImage(File image) {
    pickedImage = image;
    emit(PickedImageUpdated()); // create this state if needed
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
  void logIn(BuildContext context) async {
    if (emailLogctrl.text.isEmpty ||
        passWordLogctrl.text.isEmpty ||
        !isPassWord ||
        !isEmail) {
      emit(LogInvalidate());
      return;
    }

    emit(LogInLoading());

    try {
      final response = await DioHelper.postData(
        url: "login",
        postData: {
          'email': emailLogctrl.text,
          'password': passWordLogctrl.text,
          "fcm_token": CacheHelper.getData(key: "fcm"),
        },
        headers: {"Accept": "application/json"},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        userAuthModel = UserAuthModel.fromJson(response.data);
        CacheHelper.saveData(key: "token", value: userAuthModel?.token);
        CacheHelper.saveData(key: "role", value: userAuthModel?.role);
        CacheHelper.saveData(key: "user_id", value: userAuthModel?.userId);

        print('token: ${userAuthModel?.token}');
        emit(LogInsucess());
      } else if (response.statusCode == 422 || response.statusCode == 401) {
        emit(CheckInfo());
      } else {
        emit(LogInError(message: S.of(context).error_occurred));
      }
    } catch (e) {
      print("Login Exception: $e");
      emit(LogInError(message: S.of(context).error_in_server));
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
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
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
  Future<void> signUp(BuildContext context) async {
    emit(SignUpLoading());
    try {
      // Build map without "image" first
      // final Map<String, dynamic> data = {
      //   "name": nameCtrl.text.trim(),
      //   "email": emailRegCtrl.text.trim(),
      //   "password": passwordRegCtrl.text.trim(),
      //   "password_confirmation": confirmPasswordCtrl.text.trim(),
      //   "gitHub_account": githubAccount.text.trim(),
      //   "bio": bioCtrl.text.trim(),
      //   "fcm_token": CacheHelper.getData(key: "fcm"),
      //   "image": ""
      // };

      // // Add image only if pickedImage is not null
      // if (pickedImage != null) {
      //   data["image"] = await MultipartFile.fromFile(
      //     pickedImage!.path,
      //     filename: pickedImage!.path.split('/').last,
      //     // or 'png'
      //   );
      // }

      // print(
      //   pickedImage!.path,
      // );
      // print("fffffssssssssssss");

      final response = await DioHelper.postData(
        url: "register",
        postData: {
          "name": nameCtrl.text.trim(),
          "email": emailRegCtrl.text.trim(),
          "password": passwordRegCtrl.text.trim(),
          "password_confirmation": confirmPasswordCtrl.text.trim(),
          "gitHub_account": githubAccount.text.trim(),
          "bio": bioCtrl.text.trim(),
          "fcm_token": CacheHelper.getData(key: "fcm"),
          "image": ""
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        emit(SignUpSuccess());
        print(state);
        print(response.data);
      } else if (response.statusCode == 422) {
        emit(SignUpError(message: S.of(context).email_already_exist));
      }
    } catch (error) {
      print("❌ Dio POST Error: $error");
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
