import 'package:finesse/components/button/k_text_button.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/cart/components/cart_total.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/controller/discount_controller.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/cart/state/cart_state.dart';
import 'package:finesse/src/features/cart/state/code_state.dart';
import 'package:finesse/src/features/cart/state/zone_state.dart';
import 'package:finesse/src/features/checkout/components/selected_iteams.dart';
import 'package:finesse/src/features/checkout/controller/checkout_controller.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../components/appbar/k_app_bar.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String userN = "";
  String contractN = "";
  String cityN = "";
  String zoneN = "";
  String areaN = "";
  Map<String, dynamic> shippingAddressN = {};
  @override
  void initState() {
    super.initState();
    shippingAddressN = getJSONAsync(shippingAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Checkout'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final cartState = ref.watch(cartProvider);
        User user = ref.read(menuDataProvider.notifier).menuList!.user;
       final checkoutProviderState =   ref.watch(checkoutProvider);
       final zoneState =   ref.watch(zoneProvider);
       final discountState =   ref.watch(discountProvider);
                       
       int totalFee =  cartState is CartSuccessState &&
                            zoneState is! ZoneSuccessState &&
                            discountState is! PromoCodeSuccessState &&
                            discountState is! ReferralCodeSuccessState
                        ? ref.read(cartProvider.notifier).totalAmount
                        : zoneState is ZoneSuccessState &&
                                discountState is! PromoCodeSuccessState &&
                                discountState is! ReferralCodeSuccessState
                            ? ref.read(zoneProvider.notifier).countTotalFee
                            :ref.read(discountProvider.notifier).totalFee;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/stepper_three.svg'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SelectedItems(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: KColor.filterDividerColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Billing Information',
                                        style: KTextStyle.subtitle1
                                            .copyWith(color: KColor.blackbg),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${user.customer.customerName}',
                                    style: KTextStyle.bodyText1.copyWith(
                                        color: KColor.blackbg.withOpacity(0.6)),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '${user.customer.contact}',
                                    style: KTextStyle.bodyText1.copyWith(
                                        color: KColor.blackbg.withOpacity(0.6)),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${billingAddressMap['area']}, ${billingAddressMap['zone']}, ${billingAddressMap['city']}",
                                    style: KTextStyle.bodyText1.copyWith(
                                        color: KColor.blackbg.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              if(getJSONAsync(shippingAddress).isNotEmpty)...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Shipping Address',
                                          style: KTextStyle.subtitle1
                                              .copyWith(color: KColor.blackbg),
                                        ),
                                        // InkWell(
                                        //     onTap: () {
                                        //       NavigationService
                                        //           .navigateToReplacement(
                                        //         CupertinoPageRoute(
                                        //           builder: (_) => AddNewAddress(),
                                        //         ),
                                        //       );
                                        //     },
                                        //     child: SvgPicture.asset(
                                        //         AssetPath.editIcon)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '${getJSONAsync(shippingAddress)['name']}',
                                      style: KTextStyle.bodyText1.copyWith(
                                          color: KColor.blackbg.withOpacity(0.6)),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                       '${getJSONAsync(shippingAddress)['phone']}',
                                      style: KTextStyle.bodyText1.copyWith(
                                          color: KColor.blackbg.withOpacity(0.6)),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(maxLines: 777777,
                                      "${getJSONAsync(shippingAddress)['address']}, ${getJSONAsync(shippingAddress)['area']}, ${getJSONAsync(shippingAddress)['zone']}, ${getJSONAsync(shippingAddress)['city']}",
                                      style: KTextStyle.bodyText1.copyWith(
                                          color: KColor.blackbg.withOpacity(0.6)),
                                    ),
                                  ],
                                )
                              ]
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Payment',
                            style: KTextStyle.subtitle1
                                .copyWith(color: KColor.blackbg),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${paymentOption}',
                            style: KTextStyle.bodyText1.copyWith(
                                color: KColor.blackbg.withOpacity(0.6)),
                          ),
                          const SizedBox(height: 7),
                          // Text(
                          //   'Mariam Crane',
                          //   style: KTextStyle.bodyText1.copyWith(
                          //       color: KColor.blackbg.withOpacity(0.6)),
                          // ),
                        ],
                      ),
                    ),
                    CardTotal(),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.03),
                KTextButton(
                  title:checkoutProviderState is LoadingState ?'Please wait': 'Place Order',
                  isPrice: false,
                  onTap: () {
                    // Navigator.pushNamed(context, '/confirmOrder'); 

                    if(user!= null && billingAddressMap.isNotEmpty  && checkoutProviderState is! LoadingState){
                         
                        ref.read(checkoutProvider.notifier).placeOrder(totalFee,context);
                    }
                  
                  },
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      }),
    );
  }
}
