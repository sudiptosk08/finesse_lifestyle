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
final giftVoucherProvider =
    StateNotifierProvider<GiftVoucherController, BaseState>(
  (ref) => GiftVoucherController(ref: ref),
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
  var promoAmount = 0.0;
  var referralAmount = 0.0;
  int discount = 0;
  int discountAmount = 0;
  int voucherAmount = 0;
  var countTotalFee;
  var totalFee;
  makeDiscountNull() {
    roundingFee = 0;
    promoAmount = 0;
    referralAmount = 0.0;
    discount = 0;
    voucherAmount = 0;
    ref!.read(giftVoucherProvider.notifier).makeVoucherNull();
    state = PromoCodeEmptyState();
  }

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
          discountType = "Promo Discount";
        }

        totalAmount(state, clear, isPromo: true);
        if (clear == true) {
          state = PromoCodeEmptyState();
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
          discountType = "Referral Discount";
        }
        totalAmount(state, clear, isReferral: true);
        if (clear == true) {
          state = ReferralCodeEmptyState();
          referralCodeModel = null;
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

  // Future sendGiftVoucher({
  //   required String code,
  //   required bool voucherClear,
  // }) async {
  //   state = const LoadingState();
  //   dynamic responseBody;
  //   var requestBody = {
  //     'code': code,
  //   };
  //   try {
  //     responseBody = await Network.handleResponse(
  //       await Network.postRequest(API.getGiftVoucher, requestBody),
  //     );
  //     print(requestBody);
  //     if (responseBody != null) {
  //       voucherCodeModel = VoucherCodeModel.fromJson(responseBody);
  //       state = VoucherCodeSuccessState(voucherCodeModel);
  //       print("Gift voucher code Successful");
  //       totalAmountVoucher(state, voucherClear);
  //     } else {
  //       state = const ErrorState();
  //     }
  //   } catch (error, stackTrace) {
  //     print(error);
  //     print(stackTrace);
  //     state = const ErrorState();
  //   }
  // }

  setTotalFee(totalvalue) {
    totalFee = totalvalue;
  }

  setRoundingFee(roundingvalue) {
    roundingFee = roundingvalue;
  }

  setGiftVoucherAmount(voucherValue) {
    voucherAmount = voucherValue;
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

  void totalAmount(codeState, clear, {isReferral = false, isPromo = false}) {
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
    print("------start------countTotalFee");
    if (promoCodeData != null && isPromo) {
      int promoCodeDis = promoCodeData.coupon.discount as int;
      promoAmount = ((subtotal * promoCodeDis) / 100);
      countTotalFee = promoCodeData.success == true
          ? '${deliveryFee + (subtotal - (subtotal * promoCodeDis) / 100).round()}' //promoCodeData?.coupon.discount.toString()
          : 0;
      print("promo amount is");
      print("$promoAmount");
      if (clear == false) {
        discountValue = promoCodeData.coupon.discount.toString();
      }
      if (clear == false && promoCodeModel != null) {
        discount = promoCodeDis;
      }
      if (clear) {
        discount = 0;
        promoAmount = 0;
        state = ReferralCodeEmptyState();
      }

      // discount =
      //     clear == false && promoCodeModel != null ? promoCodeDis : 0;
    } else if (referralCodeData != null && isReferral) {
      int referralCodeDis = int.parse(referralCodeData.discount.toString());
      referralAmount = ((subtotal * referralCodeDis) / 100);

      countTotalFee = referralCodeData.success == true
          ? '${deliveryFee + (subtotal - (subtotal * referralCodeDis) / 100).round()}'
          : 0;
      if (clear == false && referralCodeModel != null) {
        discount = referralCodeDis;
      }
      if (clear) {
        discount = 0;
        referralAmount = 0;
        state = ReferralCodeEmptyState();
      }
      // discount =
      //     clear == false && referralCodeModel != null ? referralCodeDis : 0;
      if (clear == false) {
        discountValue = referralCodeData.discount.toString();
      }
      print("referral amount is : $referralAmount");
    }
    roundingFee = clear == true ? 0 : int.parse(countTotalFee) % 10;
    if (voucherAmount > 0) {
      totalFee = clear == true
          ? (subtotal - voucherAmount) + deliveryFee
          : int.parse(countTotalFee! - voucherAmount) - roundingFee + deliveryFee ;
      print("voucher in proo $totalFee");
    } else {
      totalFee = clear == true
          ? (subtotal + deliveryFee)
          : int.parse(countTotalFee!) - roundingFee;
      print("voucher not in proo $totalFee");
    }

    // voucherAmount =
    //     clear == true ? 0 : (subtotal + deliveryFee) - int.parse(countTotalFee);
    print(clear);
    print(countTotalFee);
    print("Total fee:$totalFee");

    print("-----------------");
    print(discountType);
    print(discountValue);
    print(cuponText);

    print("-------------------");
  }

  // totalAmountVoucher(codeState, clear) {
  //   deliveryFee = ref?.read(zoneProvider.notifier).deliveryFee as int;
  //   subtotal = ref?.read(cartProvider.notifier).subtotal as int;
  //   if (clear == true) {
  //     discountValue = null;
  //   }
  //   final PromoCodeModel? promoCodeData =
  //       codeState is PromoCodeSuccessState ? codeState.promoCodeModel : null;
  //   final ReferralCodeModel? referralCodeData =
  //       codeState is ReferralCodeSuccessState
  //           ? codeState.referralCodeModel
  //           : null;
  //   final VoucherCodeModel? voucherCodeData =
  //       codeState is VoucherCodeSuccessState
  //           ? codeState.voucherCodeModel
  //           : null;
  //   if (voucherCodeData != null) {
  //     voucherAmount = voucherCodeData.amount as int;

  //     clear == false && voucherCodeModel != null ? voucherAmount : 0;
  //     if (clear == false) {
  //       discountValue = voucherCodeData.amount.toString();
  //     }
  //   }
  //   // if(promoAmount>0 || referralAmount >0){
  //   //   if(promoAmount>0){
  //   //     totalFee = clear = true ? (subtotal -promoAmount) + deliveryFee :
  //   //   }
  //   // }
  //   if (clear == true) {
  //     voucherAmount = 0;
  //     promoAmount > 0
  //         ? (subtotal - promoAmount) + deliveryFee
  //         : referralAmount > 0
  //             ? (subtotal - referralAmount) + deliveryFee
  //             : totalFee = subtotal + deliveryFee;
  //   } else {
  //     totalFee = promoAmount > 0
  //         ? ((subtotal - promoAmount) - voucherAmount) + deliveryFee
  //         : referralAmount > 0
  //             ? ((subtotal - referralAmount) - voucherAmount) + deliveryFee
  //             : (subtotal - voucherAmount) + deliveryFee;
  //   }

  //   // totalFee = clear == true
  //   //     ? (subtotal + deliveryFee)
  //   //     : int.parse(countTotalFee!)-voucherAmount  ;
  //   print("total fee in voucher code ${totalFee}");
  //   // discountAmount =
  //   //     clear == true ? 0 : (subtotal + deliveryFee) - int.parse(countTotalFee);
  // }
}

class GiftVoucherController extends StateNotifier<BaseState> {
  final Ref? ref;

  GiftVoucherController({this.ref}) : super(const InitialState());
  PromoCodeModel? promoCodeModel;
  ReferralCodeModel? referralCodeModel;
  VoucherCodeModel? voucherCodeModel;
  int deliveryFee = 0;
  int roundingFee = 0;
  int subtotal = 0;
  var promoAmount = 0.0;
  var referralAmount = 0.0;
  int discount = 0;
  int discountAmount = 0;
  int voucherAmount = 0;
  var countTotalFee;
  var totalFee;

  Future sendGiftVoucher({
    required String code,
    required bool voucherClear,
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
        totalAmountVoucher(state, voucherClear);
         if (voucherClear == true) {
          voucherText = null;
          
        } else {
          voucherText = code;
          
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

  makeVoucherNull() {
    state = VoucherCodeEmptyState();
    voucherAmount = 0;
  }

  totalAmountVoucher(codeState, clear) {
    deliveryFee = ref?.read(zoneProvider.notifier).deliveryFee as int;
    subtotal = ref?.read(cartProvider.notifier).subtotal as int;
    promoAmount = ref!.read(discountProvider.notifier).promoAmount;
    referralAmount = ref!.read(discountProvider.notifier).referralAmount;
    // roundingFee = ref!.read(discountProvider.notifier).roundingFee;
    if (clear == true) {
      discountValue = null;
    }

    final VoucherCodeModel? voucherCodeData =
        codeState is VoucherCodeSuccessState
            ? codeState.voucherCodeModel
            : null;
    if (voucherCodeData != null) {
      voucherAmount = voucherCodeData.amount as int;

      if (clear == false) {
        discountValue = voucherCodeData.amount.toString();
        
      }
    }
    // if(promoAmount>0 || referralAmount >0){
    //   if(promoAmount>0){
    //     totalFee = clear = true ? (subtotal -promoAmount) + deliveryFee :
    //   }
    // }
    if (clear == true) {
      voucherAmount = 0;
      totalFee = promoAmount > 0
          ? (subtotal - promoAmount) + deliveryFee
          : referralAmount > 0
              ? (subtotal - referralAmount) + deliveryFee
              : subtotal + deliveryFee;
      // countTotalFee = promoAmount  > 0 ? (subtotal - promoAmount) + deliveryFee:
      // referralAmount > 0 ? (subtotal - referralAmount) + deliveryFee: 0;
      // if(countTotalFee>0){
      //   roundingFee =int.parse(countTotalFee) %10;
      //   totalFee = countTotalFee - roundingFee;
      // }else{
      //   roundingFee= 0;
      //   totalFee = subtotal + deliveryFee;
      // }
      ref!.read(discountProvider.notifier).setGiftVoucherAmount(voucherAmount);
      state = VoucherCodeEmptyState();
    } else {
      ref!.read(discountProvider.notifier).setGiftVoucherAmount(voucherAmount);
      totalFee = promoAmount > 0
          ? ((subtotal - promoAmount) - voucherAmount) + deliveryFee
          : referralAmount > 0
              ? ((subtotal - referralAmount) - voucherAmount) + deliveryFee
              : (subtotal - voucherAmount) + deliveryFee;
      roundingFee = clear == true ? 0 : (totalFee % 10).toInt();
      totalFee = (totalFee - roundingFee).toInt();
      // countTotalFee = promoAmount > 0
      //   ? ((subtotal - promoAmount) - voucherAmount) + deliveryFee
      //   : referralAmount > 0
      //       ? ((subtotal - referralAmount) - voucherAmount) + deliveryFee
      //       : (subtotal - voucherAmount) + deliveryFee;

      // roundingFee =int.parse(countTotalFee)  %10;
      //  totalFee = countTotalFee - roundingFee;
    }
    // ref!.read(discountProvider.notifier).setRoundingFee(roundingFee);
    ref!.read(discountProvider.notifier).setTotalFee(totalFee);

    // totalFee = clear == true
    //     ? (subtotal + deliveryFee)
    //     : int.parse(countTotalFee!)-voucherAmount  ;
    print("total fee in voucher code $totalFee");
    // discountAmount =
    //     clear == true ? 0 : (subtotal + deliveryFee) - int.parse(countTotalFee);

    print("voucher amout----------------");
    print("totalfee $totalFee");
    print("promoamount  $promoAmount");
    print("referral amoubt $referralAmount");
    print("subtotal $subtotal");
    print("voucher amout- end---------------");
  }
}
