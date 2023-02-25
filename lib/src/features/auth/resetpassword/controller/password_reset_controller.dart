import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/service/navigation_service.dart';
import 'package:finesse/src/features/auth/login/view/login_page.dart';
import 'package:finesse/src/features/auth/resetpassword/view/send_code.dart';
import 'package:finesse/src/features/auth/signup/state/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final resetPasswordProvider = StateNotifierProvider<ResetPasswordController, BaseState>(
  (ref) => ResetPasswordController(ref: ref),
);

/// Controllers
class ResetPasswordController extends StateNotifier<BaseState> {
  final Ref? ref;

  ResetPasswordController({this.ref}) : super(const InitialState());

  Future sendPhone({
    required String phone,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'contact': phone,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.sendPhone, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const SignupSuccessState();
        print("Send phone number Successful");
        NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) =>  SendCode(phoneNumber: phone,)));
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future sendCodeAgain({
    required String phone,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'contact': phone,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.resetCode, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const SignupSuccessState();
        print("Send phone number again Successful");
//NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => const LoginPage()));
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future resetPassword({
    required String confirmPassword,
    required String password,
    required String token,
    required String phone,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'cpassword': confirmPassword,
      'password': password,
      'token': token,
      'contact': phone,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.resetPassword, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        state = const SignupSuccessState();
        print("Password reset Successful");
        NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => const LoginPage()));
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }
}
