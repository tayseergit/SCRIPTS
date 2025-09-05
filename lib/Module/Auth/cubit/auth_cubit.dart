import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lms/Module/Auth/Model/user_auth_model.dart';
import 'package:http_parser/http_parser.dart';

import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/generated/l10n.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _startTokenRefreshTimer();
  }
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  UserAuthModel? userAuthModel;
  File? rigesterImage;
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

  // Start timer when the cubit is created
  Timer? _timer;
  void _startTokenRefreshTimer() {
    print("timer start"); // this should print immediately
    _timer = Timer.periodic(Duration(minutes: 15), (_) async {
      print("Timer tick"); // this will print every minute
      try {
        await refreshAccessToken();
      } catch (e) {
        print("Refresh token error: $e");
      }
    });
  }

  void setPickedImage(File image) {
    rigesterImage = image;
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
      final fullUrl = "${DioHelper.dio.options.baseUrl}login";
      print("🔗 Full URL: $fullUrl");

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
      print("Base URL from Dio: ${DioHelper.dio.options.baseUrl}");

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

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'openid',
    'email',
    'profile',
  ], clientId: "${dotenv.env['GOOGLE_CLIENT_ID']}");

  Future<void> loginWithGoogle(BuildContext context) async {
    emit(LogInLoading());

    try {
      debugPrint("🔄 تسجيل خروج من Google (لتجنب جلسة قديمة)...");
      await _googleSignIn.signOut();
      debugPrint("📌 بدء عملية تسجيل الدخول بحساب Google...");

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      debugPrint("🔑 Tokens من Google:");

      if (account == null) {
        debugPrint('🔸 المستخدم ألغى العملية.');
        return;
      }
      debugPrint(
          "✅ المستخدم اختار الحساب: ${account.email} - ID: ${account.id}");
      debugPrint("🌐 إرسال الطلب إلى السيرفر Laravel...");
      final auth = await account.authentication;
      debugPrint('✅ ID‑Token: ${auth.idToken}');
      debugPrint('✅ Access‑Token: ${auth.accessToken}');
      final response = await DioHelper.postData(
        url: "auth/google",
        postData: {
          'id_token': auth.accessToken,
          "fcm_token": "${CacheHelper.getData(key: "fcm")}"
        },
        headers: {"Accept": "application/json"},
      ).then((value) {
        debugPrint("📥 رد السيرفر وصل (StatusCode: ${value.statusCode})");
        print(value.statusCode);
        if (value.statusCode == 200) {
          userAuthModel = UserAuthModel.fromJson(value.data);
          CacheHelper.saveData(key: "token", value: userAuthModel?.token);
          CacheHelper.saveData(key: "role", value: userAuthModel?.role);
          CacheHelper.saveData(key: "user_id", value: userAuthModel?.userId);

          print('token: ${userAuthModel?.token}');
          emit(LogInsucess());
        } else {
          emit(LogInError(message: S.of(context).error_occurred));
        }
      }).catchError((value) {
        print(value.statusCode);

        emit(LogInError(message: S.of(context).error_in_server));
      });
    } catch (e) {
      print(e.toString());

      emit(LogInError(message: S.of(context).error_in_server));
    }
  }

//////////   signup
  Future<void> signUp(BuildContext context) async {
    emit(SignUpLoading());
    try {
      Map<String, dynamic> dataMap = {
        "name": nameCtrl.text.trim(),
        "email": emailRegCtrl.text.trim(),
        "password": passwordRegCtrl.text.trim(),
        "password_confirmation": confirmPasswordCtrl.text.trim(),
        "gitHub_account": githubAccount.text.trim(),
        "bio": bioCtrl.text.trim(),
        "fcm_token": CacheHelper.getData(key: "fcm"),
        "image": ""
      };
      print(
        rigesterImage!.path,
      );
      print("ddddddd");
      if (rigesterImage != null) {
        String extension = rigesterImage!.path.split('.').last.toLowerCase();
        String mimeType =
            extension == 'png' ? 'png' : 'jpeg'; // adjust if needed

        dataMap["image"] = await MultipartFile.fromFile(
          rigesterImage!.path,
          filename: rigesterImage!.path.split('/').last,
          contentType: MediaType('image', mimeType),
        );
      }
      FormData formData = FormData.fromMap(dataMap);
      formData.fields.forEach((f) => print("Field: ${f.key} = ${f.value}"));
      formData.files
          .forEach((f) => print("File: ${f.key} = ${f.value.filename}"));

      final response = await DioHelper.postFormData(
        url: "register",
        postData: formData,
        headers: {
          "Accept": "application/json",
          // "Authorization": "Bearer $token",
        },
      );
      // print();
      print(response.data['errors']);

      if (response.statusCode == 200) {
        emit(SignUpSuccess());
        print(state);
        print(response.data);
      } else if (response.statusCode == 422) {
        emit(SignUpError(message: "${response.data['errors']}"));
      } else {
        emit(SignUpError(message: S.of(context).error_occurred));
        print(response.data['message']);
      }
    } catch (error) {
      emit(SignUpError(message: S.of(context).error_in_server));

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
        print('refresh');
        return true;
      }
    } catch (e) {
      print(" Connection Error $e");
    }
    return false;
  }

  void logOut(BuildContext context) async {
    emit(LogOutLoading());

    try {
      final response = await DioHelper.postData(
        url: "logout",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        CacheHelper.removeData(key: "token");
        CacheHelper.removeData(key: "role");
        CacheHelper.removeData(key: "user_id");

        print('token: ${userAuthModel?.token}');
        print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccb');
        emit(LogOutSuccess());
      } else if (response.statusCode == 401) {
        print(response.data['message']);
        emit(UnAuth());
      } else {
        print(response.data['message']);

        emit(LogOutError(message: S.of(context).error_occurred));
      }
    } catch (e) {
      print("Login Exception: $e");
      emit(LogOutError(message: S.of(context).error_in_server));
      print('bbbbbbbbbbbbbbbbbbbbbbbbbbzzzzzzzzzzzzzzzzzbbbbbbbbbbbbbbbbbbbb');
    }
  }

  ///// github

  Future<void> loginWithGithub() async {
    final clientId = dotenv.env['GITHUB_CLIENT_ID'];
    final redirectUri = "myapp://callback"; // must match GitHub OAuth
    final scope = "read:user,user:email";
    final state =
        DateTime.now().millisecondsSinceEpoch.toString(); // unique state

    try {
      // Open GitHub login
      final result = await FlutterWebAuth2.authenticate(
        url:
            "https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&state=$state",
        callbackUrlScheme: "myapp",
      );

      // Extract the code from the callback URL
      final code = Uri.parse(result).queryParameters['code'];
      final returnedState = Uri.parse(result).queryParameters['state'];

      if (code == null || returnedState != state) {
        throw Exception("OAuth failed or state mismatch!");
      }

      print("GitHub Auth Code: $code");

      // TODO: Send `code` to your backend to exchange for an access token
    } catch (e) {
      print("GitHub login error: $e");
    }
  }
}
