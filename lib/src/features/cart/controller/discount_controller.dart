import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/cart/model/promocode_model.dart';
import 'package:finesse/src/features/cart/model/refferralcode_model.dart';
import 'package:finesse/src/features/cart/model/vouchercode_model.dart';
import 'package:finesse/src/features/cart/state/code_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final discountProvider = StateNotifierProvider<DiscountController, BaseState>(
  (ref) => DiscountController(ref: ref),
);

/// Controllers
class DiscountController extends StateNotifier<BaseState> {
  final Ref? ref;

  DiscountController({this.ref}) : super(const InitialState());
  PromoCodeModel? promoCodeModel;
  ReferralCodeModel? referralCodeModel;
  VoucherCodeModel? voucherCodeModel;
  int deliveryFee = 0;
  int roundingFee = 0;
  int subtotal = 0;
  int discount = 0;
  int discountAmount = 0;
  var countTotalFee;
  var totalFee;

  Future sendPromoCode({
    required String code,
    required bool clear,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'code': code,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.getPromoCode, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        promoCodeModel = PromoCodeModel.fromJson(responseBody);
        state = PromoCodeSuccessState(promoCodeModel);
        print("Send promo code Successful");
        if (clear == true) {
          cuponText = null;
          discountType = null;
        } else {
          cuponText = code;
          discountType = "Promo code";
        }

        totalAmount(state, clear);
        if(clear==true){
          state =  PromoCodeEmptyState(); 
          promoCodeModel = null; 
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

  Future sendCReferralCode({
    required String barCode,
    required bool clear,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'barCode': barCode,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.getReferralCode, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        referralCodeModel = ReferralCodeModel.fromJson(responseBody);
        state = ReferralCodeSuccessState(referralCodeModel);
        print("Send referral code  Successful");
        if (clear == true) {
          cuponText = null;
          discountType = null;
        } else {
          cuponText = barCode;
          discountType = "Referral code";
        }

        // NavigationService.navigateToReplacement(
        //     CupertinoPageRoute(builder: (context) => const CartPage()));
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future sendGiftVoucher({
    required String code,
    required bool clear,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'code': code,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.getGiftVoucher, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        voucherCodeModel = VoucherCodeModel.fromJson(responseBody);
        state = VoucherCodeSuccessState(voucherCodeModel);
        print("Gift voucher code Successful");
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  // void totalAmount(codeState, clear) {
  //   final PromoCodeModel? promoCodeData =
  //       codeState is PromoCodeSuccessState ? codeState.promoCodeModel : null;
  //   final ReferralCodeModel? referralCodeData =
  //       codeState is ReferralCodeSuccessState
  //           ? codeState.referralCodeModel
  //           : null;
  //   deliveryFee = ref?.read(zoneProvider.notifier).deliveryFee as int;
  //   subtotal = ref?.read(cartProvider.notifier).subtotal as int;
  //   int promoCodeDis = promoCodeData?.coupon.discount as int;
  //   print(promoCodeDis);
  //   int referralCodeDis = referralCodeData?.discount as int;
  //   print(referralCodeDis);
  //   countTotalFee = promoCodeData?.success == true
  //       ? '${deliveryFee + (subtotal - (subtotal * promoCodeDis) / 100).round()}' //promoCodeData?.coupon.discount.toString()
  //       : referralCodeData?.success == true
  //           ? '${deliveryFee + (subtotal - (subtotal * referralCodeDis) / 100).round()}'
  //           : 0;

  //   roundingFee = clear == true ? 0 : int.parse(countTotalFee) % 10;
  //   totalFee =
  //       clear == true ? subtotal : int.parse(countTotalFee) - roundingFee;
  //   discount = clear == false && promoCodeModel != null ?
  //   promoCodeDis : clear == false && referralCodeModel != null ? referralCodeDis:0 ;
  //   print(clear);
  //   print(countTotalFee);
  //   print(totalFee);
  // }

  void totalAmount(codeState, clear) {
    final PromoCodeModel? promoCodeData =
        codeState is PromoCodeSuccessState ? codeState.promoCodeModel : null;
    final ReferralCodeModel? referralCodeData =
        codeState is ReferralCodeSuccessState
            ? codeState.referralCodeModel
            : null;

    deliveryFee = ref?.read(zoneProvider.notifier).deliveryFee as int;
    subtotal = ref?.read(cartProvider.notifier).subtotal as int;
    if (clear == true) {
      discountValue = null;
    }
    print("delivery fee is : $deliveryFee");
    print("clear is $clear");
    print("subtotal fee is : $subtotal");
    // int promoCodeDis = promoCodeData?.coupon.discount as int; // previous code
    // print("discount of promocode: ${promoCodeDis}");
    print("------start------countTotalFee");
    //  int referralCodeDis = referralCodeData?.discount as int; // previous code
    //  int referralCodeDis = referralCodeData!.coupon.discount as int;
    // int referralCodeDis = 0;
    // print(referralCodeDis); // prvious code
    if (promoCodeData != null) {
      int promoCodeDis = promoCodeData.coupon.discount as int;
      countTotalFee = promoCodeData.success == true
          ? '${deliveryFee + (subtotal - (subtotal * promoCodeDis) / 100).round()}' //promoCodeData?.coupon.discount.toString()
          : 0;
      if (clear == false) {
        discountValue = promoCodeData.coupon.discount.toString();
      }
      discount = clear == false && promoCodeModel != null ? promoCodeDis : 0;
    } else if (referralCodeData != null) {
      int referralCodeDis = referralCodeData.discount as int;
      countTotalFee = referralCodeData.success == true
          ? '${deliveryFee + (subtotal - (subtotal * referralCodeDis) / 100).round()}'
          : 0;
      discount =
          clear == false && referralCodeModel != null ? referralCodeDis : 0;
      if (clear == false) {
        discountValue = referralCodeData.discount.toString();
      }
    }
    roundingFee = clear == true ? 0 : int.parse(countTotalFee) % 10;
    totalFee = clear == true
        ? (subtotal + deliveryFee)
        : int.parse(countTotalFee!) - roundingFee;
    discountAmount =
        clear == true ? 0 : (subtotal + deliveryFee) - int.parse(countTotalFee);
    print(clear);
    print(countTotalFee);
    print("Total fee:$totalFee");

    print("-----------------");
    print(discountType);
    print(discountValue);
    print(cuponText);

    print("-------------------");
  }
}

