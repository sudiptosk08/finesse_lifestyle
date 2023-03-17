
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/service/navigation_service.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/auth/login/state/login_state.dart';
import 'package:finesse/src/features/auth/login/view/login_page.dart';
import 'package:finesse/src/features/main_screen.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final loginProvider = StateNotifierProvider<LoginController, BaseState>(
  (ref) => LoginController(ref: ref),
);

/// Controllers
class LoginController extends StateNotifier<BaseState> {
  final Ref? ref;

  LoginController({this.ref}) : super(const InitialState());
  User? userModel;

  Future login({
    required String phone,
    required String password,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'contact': phone,
      'password': password,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.login, requestBody),
      );
      if (responseBody != null) {
        if (responseBody['token'] != null) {
          userModel = User.fromJson(responseBody['user']);
          print("response body usermodel  = ${responseBody['user']}\n");
          print("usermodel = $userModel\n");
          state = LoginSuccessState(userModel);
          setValue(isLoggedIn, true);
          setValue(token, responseBody['token']);
          setValue(rememberToken, responseBody['token']);
          setValue(userId, userModel!.id);
          setValue(userName, userModel!.name);
          setValue(userEmail, userModel!.email);
          setValue(userContact, userModel!.contact);
          toast("Login Successful", bgColor: KColor.selectColor );

          NavigationService.navigateToReplacement(
            CupertinoPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future logout() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.logout),
      );
      if (responseBody != null) {
        setValue(isLoggedIn, false);
        // var userData;
        state = LoginSuccessState(userModel);
        toast("Logout", bgColor: KColor.selectColor);
        NavigationService.popNavigate();
        NavigationService.navigateToReplacement(
          CupertinoPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}
