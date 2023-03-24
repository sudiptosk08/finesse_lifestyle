import 'package:finesse/src/features/cart/state/code_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/cart_controller.dart';
import '../controller/discount_controller.dart';
import '../controller/zone_controller.dart';
import '../state/cart_state.dart';
import '../state/zone_state.dart';

// ignore: must_be_immutable
class CardTotal extends StatefulWidget {
  final String? subTotal;
  final String? deliveryFee;
  final String? rounding;
  final String? discount;
  String? total;

  CardTotal({
    Key? key,
    this.subTotal,
    this.deliveryFee,
    this.total,
    this.discount,
    this.rounding,
  }) : super(key: key);

  @override
  State<CardTotal> createState() => _CardTotalState();
}

class _CardTotalState extends State<CardTotal> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final discountState = ref.watch(discountProvider);
      final cartState = ref.watch(cartProvider);
      final zoneState = ref.watch(zoneProvider);
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
          decoration: BoxDecoration(
            color: KColor.filterDividerColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getTotal(
                'SubTotal',
                ref.read(cartProvider.notifier).subtotal.toString(),
              ),
              const SizedBox(height: 15),
              _getTotal(
                'Delivery',
                ref.read(zoneProvider.notifier).deliveryFee.toString(),
              ),
              const SizedBox(height: 15),
              _getTotal('Discount',
                  ref.read(discountProvider.notifier).discount.toString()),
              const SizedBox(height: 15),
              _getTotal('Rounding',
                  ref.read(discountProvider.notifier).roundingFee.toString(),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Divider(
                  color: KColor.dividerColor.withOpacity(0.2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: KTextStyle.sticker.copyWith(
                      color: KColor.blackbg.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    cartState is CartSuccessState &&
                            zoneState is! ZoneSuccessState
                        ? ref.read(cartProvider.notifier).subtotal.toString()
                        : zoneState is ZoneSuccessState &&
                                discountState is! PromoCodeSuccessState &&
                                discountState is! ReferralCodeSuccessState
                            ? ref
                                .read(zoneProvider.notifier)
                                .countTotalFee
                                .toString()
                            : ref
                                .read(discountProvider.notifier)
                                .totalFee
                                .toString(),
                    style: KTextStyle.sticker.copyWith(
                      color: KColor.blackbg.withOpacity(0.8),
                    ),
                  ),

                  // Text(
                  //   cartState is CartSuccessState &&
                  //           zoneState is! ZoneSuccessState
                  //       ? ref.read(cartProvider.notifier).subtotal.toString()
                  //       : zoneState is ZoneSuccessState &&
                  //               discountState is! PromoCodeSuccessState &&
                  //               discountState is! ReferralCodeSuccessState
                  //           ? ref
                  //               .read(zoneProvider.notifier)
                  //               .countTotalFee
                  //               .toString()
                  //           : ref
                  //               .read(discountProvider.notifier)
                  //               .totalFee
                  //               .toString(),
                  //   style: KTextStyle.sticker.copyWith(
                  //     color: KColor.blackbg.withOpacity(0.8),
                  //   ),
                  // ),
                ],
              ),
            ],
          ));
    });
  }

  Row _getTotal(title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: KTextStyle.sticker.copyWith(
            color: KColor.blackbg.withOpacity(0.4),
          ),
        ),
        Text(
          price,
          style: KTextStyle.sticker.copyWith(
            color: KColor.blackbg.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
//  subTotal: ref.read(cartProvider.notifier).subtotal.toString(),
//               deliveryFee:'100',// ref.read(zoneProvider.notifier).deliveryFee.toString(),
//               rounding: ref.read(discountProvider.notifier).roundingFee.toString(),
//               discount: ref.read(discountProvider.notifier).discount.toString(),
//               total: cartState is CartSuccessState ? //&& zoneState is! ZoneSuccessState
//               ref.read(cartProvider.notifier).subtotal.toString() :
//               zoneState is ZoneSuccessState  && discountState is! PromoCodeSuccessState &&
//                             discountState is! ReferralCodeSuccessState
//                         ?
//               ref.read(zoneProvider.notifier).countTotalFee.toString():
              
//               ref.read(discountProvider.notifier).totalFee.toString()