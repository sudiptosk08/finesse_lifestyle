import 'dart:convert';

import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/product_details/model/review_model.dart';
import 'package:finesse/src/features/product_details/state/product_details_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final reviewsProvider = StateNotifierProvider<ReviewsController, BaseState>(
  (ref) => ReviewsController(ref: ref),
);

class ReviewsController extends StateNotifier<BaseState> {
  final Ref? ref;
  ReviewsController({this.ref}) : super(const InitialState());

  List<ReviewModel> reviewsList = [];

  Future fetchProductReviews(productId) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.productReviews(productId: productId)),
      );
      if (responseBody != null) {
        // ignore: deprecated_member_use

        reviewsList = (responseBody['reviews'] as List<dynamic>)
            .map((x) => ReviewModel.fromJson(x))
            .toList();
        state = ReviewsSuccessState(reviewsList);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print('fetchProductReviews() error = $error');
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future addProductReviews({
        required String rating,
        required String comment,
        required String productId,
        required String  userId, 
        }) async {
   
    state = const LoadingState();

    dynamic responseBody;
    var requestBody = {
       'rating': rating,
       'content': comment,
       'productId': productId,
       'userId': userId,
    };
    try {
      responseBody = await Network.handleResponse(await Network.postRequest(
          API.addProductReviews, requestBody));
      if (responseBody != null) {
        print("ResponseBody for reivew =$responseBody");
        state = const AddReviewSuccessState();
        toast("Reviews Add", bgColor: KColor.selectColor);
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

  // Future login({
  //   required String phone,
  //   required String password,
  // }) async {
  //   state = const LoadingState();
  //   dynamic responseBody;
  //   var requestBody = {
  // 'contact': phone,
  // 'password': password,
  //   };
  //   try {
  //     responseBody = await Network.handleResponse(
  //       await Network.postRequest(API.login, requestBody),
  //     );
  //     if (responseBody != null) {
  //       if (responseBody['token'] != null) {
  //         userModel = User.fromJson(responseBody['user']);
  //         print("response body usermodel  = ${responseBody['user']}\n");
  //         print("usermodel = $userModel\n");

  //         state = LoginSuccessState(userModel);
  //         setValue(isLoggedIn, true);
  //         setValue(token, responseBody['token']);
  //         setValue(rememberToken, responseBody['token']);
  //         toast("Login Successful", bgColor: KColor.selectColor);

  //         NavigationService.navigateToReplacement(
  //           CupertinoPageRoute(
  //             builder: (context) => const MainScreen(),
  //           ),
  //         );
  //       }
  //     } else {
  //       state = const ErrorState();
  //     }
    // } catch (error, stackTrace) {
    //   print(error);
    //   print(stackTrace);
    //   state = const ErrorState();
    // }
  //  }