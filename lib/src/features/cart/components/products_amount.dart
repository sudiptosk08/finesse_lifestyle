import 'package:finesse/src/features/cart/components/cart_items.dart';
import 'package:finesse/src/features/cart/components/cart_total.dart';
import 'package:finesse/src/features/cart/components/get_discount.dart';
import 'package:finesse/src/features/cart/components/get_location.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/cart_controller.dart';

class ProductsAmount extends StatefulWidget {
  const ProductsAmount({Key? key}) : super(key: key);

  @override
  State<ProductsAmount> createState() => _ProductsAmountState();
}

class _ProductsAmountState extends State<ProductsAmount> {
  String? _cities;
  String? _zones;
  String? _areas;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        //final discountState = ref.watch(discountProvider);
        final cartState = ref.watch(cartProvider);
        //final zoneState = ref.watch(zoneProvider);
        // final PromoCodeModel? promoCodeData = discountState is PromoCodeSuccessState
        //     ? discountState.promoCodeModel
        //     : null;
        // final ReferralCodeModel? referralCodeData =
        //     discountState is ReferralCodeSuccessState
        //         ? discountState.referralCodeModel
        //         : null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CartItems(),
            DeliveryAddress(
              cities: _cities,
              zones: _zones,
              areas: _areas,
              checkCities: true,
              checkZones: true,
            ),
            const SizedBox(height: 20),
            DeliveryAddress(
              cities: _cities,
              zones: _zones,
              checkCities: false,
              checkZones: true,
              areas: _areas,
            ),
            const SizedBox(height: 20),
            DeliveryAddress(
                cities: _cities,
                zones: _zones,
                checkCities: false,
                checkZones: false,
                areas: _areas),
            const SizedBox(height: 20),
            const GetDiscount(),
            SizedBox(height: context.screenHeight * 0.05),
            CardTotal(
             
            ),
            SizedBox(height: context.screenHeight * 0.05),
          ],
        );
      },
    );
  }
}
