import "package:finesse/constants/shared_preference_constant.dart";
import "package:finesse/core/base/base_state.dart";
import "package:finesse/core/network/api.dart";
import "package:finesse/core/network/network_utils.dart";
import "package:finesse/src/features/auth/login/model/user_model.dart";
import "package:finesse/src/features/cart/controller/cart_controller.dart";
import "package:finesse/src/features/cart/controller/discount_controller.dart";
import "package:finesse/src/features/cart/controller/zone_controller.dart";
import "package:finesse/src/features/home/controllers/menu_data_controller.dart";
import "package:finesse/src/features/profile/state/profile_state.dart";
import "package:finesse/styles/k_colors.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:nb_utils/nb_utils.dart";

final checkoutProvider = StateNotifierProvider<CheckoutController, BaseState>(
    (ref) => CheckoutController(ref: ref));

class CheckoutController extends StateNotifier<BaseState> {
  Ref? ref;
  CheckoutController({this.ref}) : super(const InitialState());
  Future<void> placeOrder(int totalFee, context) async {
    User? user = ref?.read(menuDataProvider.notifier).menuList!.user;
    var roundfee = ref!.read(discountProvider.notifier).roundingFee;

    state = const LoadingState();
    try {
      if (billingAddressMap['address'] == null &&
          user!.customer.address == null) {
        toast('Set Billing Address.');
        state = const ErrorState();
      }
      else if (billingAddressMap['postCode'] == null && user!.customer.postCode == null) {
        
         toast('Set Billing postal Code.');
        state = const ErrorState();
      }
      //  else if (phoneis.isEmpty) {
      //   state = AddressErrorState();
      //   toast('phone not Set!');
      // } else if (cityis == null) {
      //   toast('City not Set!');
      //   state = AddressErrorState();
      // } else if (zoneis == null) {
      //   toast('Zone not Set!');
      //   state = AddressErrorState();
      // } else if (areais == null) {
      //   toast('area not Set!');
      //   state = AddressErrorState();
      // } else if (addressis.isEmpty) {
      //   toast('Address not Set!');
      //   state = AddressErrorState();
      // }
      
      else {
        var requestBody;
        getJSONAsync(shippingAddress).isEmpty
            ? requestBody = {
                "billingAddress":
                    billingAddressMap['address'] ?? user!.customer.address,
                "billingArea": billingAddressMap['area'] ,
                "billingCity": billingAddressMap['city'],
                "billingZone": billingAddressMap['zone'],
                "contact": user!.customer.contact.toString(),
                "coupon": cuponText ?? '', // promo code
                "date": DateTime.now().day,
                "dgAmount": 0,
                "discount": discountValue ?? 0, //
                "discountType": discountType ?? '', // promocode,  referral code
                "email": user.email,
                "giftVoucherAmount":
                    ref!.read(giftVoucherProvider.notifier).voucherAmount,
                "giftVoucherCode": voucherText,
                "grandTotal": totalFee - ref!.read(zoneProvider.notifier).deliveryFee,
                "invoiceTotal": ref!.read(cartProvider.notifier).subtotal,
                "isDGMoney": 0,
                "isDifferentShipping":
                    getJSONAsync(shippingAddress).isEmpty ? 0 : 1,
                "membershipDiscount": 0,
                "membershipDiscountAmount": 0,
                "name": user.name,
                "notes": '',
                "paymentType": paymentOption,
                "postCode":  billingAddressMap['postCode'] ?? user.customer.postCode ,
                "promoDiscount":
                    ref!.read(discountProvider.notifier).promoCodeModel != null
                        ? ref!
                            .read(discountProvider.notifier)
                            .promoCodeModel!
                            .discount
                        : 0,
                "promoDiscountAmount":
                   ref!.read(discountProvider.notifier).promoAmount == 0.0
                        ? 0
                        : ref!.read(discountProvider.notifier).promoAmount,
                "referralCode": cuponText,
                "refferalDiscount":
                    ref!.read(discountProvider.notifier).referralCodeModel !=
                            null
                        ? ref!
                            .read(discountProvider.notifier)
                            .referralCodeModel!
                            .discount
                        : 0,
                "refferalDiscountAmount":
                    ref!.read(discountProvider.notifier).referralAmount == 0.0
                        ? 0
                        : ref!.read(discountProvider.notifier).referralAmount,
                "roundAmount": roundfee == 0 ? 0 : roundfee,
                "shippingPrice": billingAddressMap['deliveryFee'] ??
                    ref!.read(zoneProvider.notifier).deliveryFee.toString(), 
                "subTotal": ref!.read(cartProvider.notifier).subtotal,
                
              }
            : 
        requestBody = {
                "billingAddress":
                    billingAddressMap['address'] ?? user!.customer.address,
                "billingArea": billingAddressMap['area'],
                "billingCity": billingAddressMap['city'],
                "billingZone": billingAddressMap['zone'],
                "contact": user!.customer.contact.toString(),
                "coupon": cuponText ?? '', // promo code
                "date": DateTime.now().day,
                "dgAmount": 0,
                "discount": discountValue ?? 0, //
                "discountType": discountType ?? '', // promocode,  referral code
                "email": user.email,
                "giftVoucherAmount": ref!.read(giftVoucherProvider.notifier).voucherAmount,
                "giftVoucherCode":voucherText ,
                "grandTotal": totalFee -( ref!.read(zoneProvider.notifier).deliveryFee),
                "invoiceTotal": ref!.read(cartProvider.notifier).subtotal,
                "isDGMoney": 0,
                "isDifferentShipping":
                    getJSONAsync(shippingAddress).isEmpty ? 0 : 1,
                "membershipDiscount": 0,
                "membershipDiscountAmount": 0,
                "name": user.name,
                "notes": '',
                "paymentType": paymentOption,
                "postCode": user.customer.postCode ?? billingAddressMap['postCode'],
                "promoDiscount":
                    ref!.read(discountProvider.notifier).promoCodeModel != null
                        ? ref!
                            .read(discountProvider.notifier)
                            .promoCodeModel!
                            .discount
                        : 0,
                "promoDiscountAmount":
                    ref!.read(discountProvider.notifier).promoAmount == 0.0
                        ? 0
                        : ref!.read(discountProvider.notifier).promoAmount,
                "referralCode": cuponText,
                "refferalDiscount":
                    ref!.read(discountProvider.notifier).referralCodeModel !=
                            null
                        ? ref!
                            .read(discountProvider.notifier)
                            .referralCodeModel!
                            .discount
                        : 0,
                "refferalDiscountAmount": ref!.read(discountProvider.notifier).referralAmount == 0.0
                        ? 0
                        : ref!.read(discountProvider.notifier).referralAmount,
                "roundAmount": roundfee == 0 ? 0 : roundfee,
                "shippingPrice":billingAddressMap['deliveryFee'] ??
                    ref!.read(discountProvider.notifier).deliveryFee,
                "shippingDetails": {
                  'name': getJSONAsync(shippingAddress)['name'],
                  'email': getJSONAsync(shippingAddress)['email'],
                  'contact': getJSONAsync(shippingAddress)['contact'],
                  'shippingCity': getJSONAsync(shippingAddress)['city'],
                  'shippingZone': getJSONAsync(shippingAddress)['zone'],
                  'shippingArea': getJSONAsync(shippingAddress)['area'],
                  'postCode': getJSONAsync(shippingAddress)['postCode'],
                  'address': getJSONAsync(shippingAddress)['address']
                },
                "subTotal": ref!.read(cartProvider.notifier).subtotal,

                
              };

        // print("request body is:  ${requestBody}");
        print("Shpping Address :${getJSONAsync(shippingAddress)['address']}");

        dynamic responseBody;

        try {
          responseBody = await Network.handleResponse(
            await Network.postRequest(API.addOrder, requestBody),
          );
          if (responseBody != null) {
            print("-----------");
            print("success is : $responseBody");
            removeKey(shippingAddress);

            paymentOption = null;
            paymentOptionIndex = null;
            state = const OrderSuccessState();
            Navigator.pushReplacementNamed(context, '/confirmOrder');
          } else {
            print("print response is in null :$responseBody");
            state = const ErrorState();
          }
        } catch (error, stackTrace) {
          print("error state");
          print(error);
          print(stackTrace);
          state = const ErrorState();
          toast("Something went wrong!", bgColor: KColor.red);
        }
      }
    } catch (e) {
      state = const ErrorState();
    }
  }
}
