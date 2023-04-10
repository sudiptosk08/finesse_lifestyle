import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/components/shimmer/k_shimmer.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/login/view/login_page.dart';
import 'package:finesse/src/features/cart/components/products_amount.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/model/cart_model.dart';
import 'package:finesse/src/features/cart/state/cart_state.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/src/features/wishlist/view/empty_product_page.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../auth/login/model/user_model.dart';
import '../../home/controllers/menu_data_controller.dart';
import '../../home/state/menu_data_state.dart';
import '../../main_screen.dart';

class CartPage extends StatefulWidget {
  final bool isFromBottomNav;
  const CartPage({Key? key, this.isFromBottomNav = false}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    bool checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);

    return checkLogin
        ? Scaffold(
            backgroundColor: KColor.appBackground,
            body: Consumer(
              builder: (contex, ref, child) {
                final cartState = ref.watch(cartProvider);
                final List<CartModel> cartData =
                    cartState is CartSuccessState ? cartState.cartList : [];
                final menuData = ref.watch(menuDataProvider);
                User? user = menuData is MenuDataSuccessState
                    ? menuData.menuList!.user
                    : null;
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cartState is LoadingState) ...[
                          const KLoading(shimmerHeight: 123)
                        ],
                        if (cartState is CartSuccessState) ...[
                          cartData.isEmpty
                              ? const EmptyProductPage(
                                  message: 'Your cart is empty')
                              : Column(
                                  children: [
                                    const ProductsAmount(),
                                    SizedBox(
                                        height: context.screenHeight * 0.05),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: KBorderButton(
                                            title: 'Go Back',
                                            onTap: () =>Navigator.push(context, MaterialPageRoute(builder: ((context) =>const MainScreen())),
                                          ),
                                        ),),
                                        const SizedBox(width: 16),
                                        Flexible(
                                          child: Consumer(
                                            builder: ((context, ref, child) {
                                              return KButton(
                                                title: 'Checkout',
                                                onTap: () async {
                                                  if (await ref
                                                      .read(addressProvider
                                                          .notifier)
                                                      .isLocationSet(user!
                                                          .customer.address)) {
                                                            ref.read(addressProvider.notifier).makeAddressNull();
                                                    Navigator.pushNamed(context,
                                                        '/addressPage');
                                                  }
                                                },
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 36),
                                  ],
                                )
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const LoginPage();
  }
}
