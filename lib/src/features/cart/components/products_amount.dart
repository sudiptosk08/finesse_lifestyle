import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/cart/components/cart_items.dart';
import 'package:finesse/src/features/cart/components/cart_total.dart';
import 'package:finesse/src/features/cart/components/get_discount.dart';
import 'package:finesse/src/features/cart/components/get_location.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/login/model/user_model.dart';

class ProductsAmount extends StatefulWidget {
  const ProductsAmount({Key? key}) : super(key: key);

  @override
  State<ProductsAmount> createState() => _ProductsAmountState();
}

class _ProductsAmountState extends State<ProductsAmount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final menuData = ref.watch(menuDataProvider);
        User? user =
            menuData is MenuDataSuccessState ? menuData.menuList!.user : null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CartItems(),
            DeliveryAddress(
              isCheckoutPage: true,
            ),
            Text(
              "Address",
              style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
            ),
            const SizedBox(height: 20),
            Container(
                color: KColor.white,
                child: TextFormField(
                  readOnly: false,
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
                    RegExp regExp = RegExp(pattern);
                    if (value == null || value.isEmpty) {
                      return 'Please FillUp';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  initialValue:
                      user!.customer.address ?? billingAddressMap['address'],
                  decoration: InputDecoration(
                    hintText: "#House No,#Road No",
                    hintStyle:
                        KTextStyle.bodyText1.copyWith(color: KColor.grey),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 19.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KColor.textBorder.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KColor.textBorder.withOpacity(0.8),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: KColor.blackbg, width: 1.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    setState(() {
                      billingAddressMap['address'] = value;
                    });
                  },
                )),
            const SizedBox(height: 20),
            Text(
              "Postal Code",
              style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
            ),
            const SizedBox(height: 20),
            Container(
                color: KColor.white,
                child: TextFormField(
                  readOnly: false,
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
                    RegExp regExp = RegExp(pattern);
                    if (value == null || value.isEmpty) {
                      return 'Please FillUp';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  initialValue:
                      user.customer.postCode ?? billingAddressMap['postCode'],
                  decoration: InputDecoration(
                    hintText: "#post code",
                    hintStyle:
                        KTextStyle.bodyText1.copyWith(color: KColor.grey),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 19.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KColor.textBorder.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KColor.textBorder.withOpacity(0.8),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: KColor.blackbg, width: 1.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    setState(() {
                      billingAddressMap['postCode'] = value;
                    });
                  },
                )),
            const SizedBox(height: 20),
            const GetDiscount(),
            SizedBox(height: context.screenHeight * 0.05),
            CardTotal(),
            SizedBox(height: context.screenHeight * 0.05),
          ],
        );
      },
    );
  }
}
