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
  Future<void> placeOrder(int totalFee , context) async {
    User? user = ref?.read(menuDataProvider.notifier).menuList!.user;
    final discountState = ref!.watch(discountProvider);
    final cartState = ref!.watch(cartProvider);
    final zoneState = ref!.watch(zoneProvider);
    var subtotal = ref!.read(discountProvider.notifier).subtotal;
    var roundfee = ref!.read(discountProvider.notifier).roundingFee;
    var discount = ref!.read(discountProvider.notifier).discount;

    state = const LoadingState();
    var requestBody = {
      // "billingAddress": billingAddressMap['address'],
      "billingAddress": billingAddressMap['address'],
      "billingArea": billingAddressMap['area'],
      "billingCity": billingAddressMap['city'],
      "billingZone": billingAddressMap['zone'],
      "contact": user!.customer.contact.toString(),
      "coupon": cuponText ?? '', // promo code
      "date": DateTime.now().toString().substring(0,10),
      "dgAmount": 0.toString(),
      "discount": discountValue ?? '', //
      "discountType": discountType ?? '', // promocode,  referral code
      "email": user.email,
      "giftVoucherAmount": 0.toString(),
      "giftVoucherCode": '',
      "grandTotal": totalFee.toString(),
      "isDGMoney": 0.toString(),
      "isDifferentShipping": getJSONAsync(shippingAddress).isEmpty ? 0 : 1,
      "membershipDiscount": "",
      "membershipDiscountAmount": "",
      "name": user.name,
      "notes": "",
      "paymentType": paymentOption,
      "postCode": user.customer.postCode.toString(),
      "promoDiscount":
          ref!.read(discountProvider.notifier).promoCodeModel != null
              ? ref!.read(discountProvider.notifier).promoCodeModel!.discount
              : '',
      "promoDiscountAmount":
          ref!.read(discountProvider.notifier).discountAmount.toString(),
      "referralCode": '',
      "refferalDiscount": '',
      "refferalDiscountAmount": '',
      "roundAmount": roundfee.toString(),
      "shippingPrice": ref!.read(discountProvider.notifier).deliveryFee.toString(),
      "shippingDetails['name']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['name'],
      "shippingDetails['email']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['email'],
      "shippingDetails['contact']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['phone'],
      "shippingDetails['shippingCity']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['city'],
      "shippingDetails['shippingZone']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['zone'],
      "shippingDetails['shippingArea']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['area'],
      "shippingDetails['postCode']": "",
      "shippingDetails['address']": getJSONAsync(shippingAddress).isEmpty
          ? ""
          : getJSONAsync(shippingAddress)['address'],
      "subTotal": ref!.read(cartProvider.notifier).subtotal.toString(),

      "totalSellingPrice": ref!.read(cartProvider.notifier).subtotal.toString(),
    };

    // print("request body is:  ${requestBody}");

    dynamic responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addOrder, requestBody),
      );
      if (responseBody != null) {
        print("-----------");
        print("success is : ${responseBody}");
        removeKey(shippingAddress); 
        paymentOption = null; 
        paymentOptionIndex = null; 
        state = const OrderSuccessState();
                Navigator.pushReplacementNamed(context, '/confirmOrder');
      } else {
        print("print response is in null :${responseBody}");
        state = ErrorState();
      }
    } catch (error, stackTrace) {
      print("error state");
      print(error);
      print(stackTrace);
      state = const ErrorState();
      toast("Something went wrong!", bgColor: KColor.red);
    }
  }
}
