import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/auth/login/controller/login_controller.dart';
import 'package:finesse/src/features/auth/login/view/login_page.dart';
import 'package:finesse/src/features/cart/components/products_amount.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../checkout/components/take_address.dart';

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
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(widget.isFromBottomNav ? 0 : 56),
              child: const KAppBar(
                  checkTitle: true, dotCheck: false, title: 'Cart'),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProductsAmount(),
                    SizedBox(height: context.screenHeight * 0.05),
                    Row(
                      children: [
                        Flexible(
                          child: KBorderButton(
                            title: 'Go Back',
                            onTap: () => Navigator.pushNamed(context, '/home'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Consumer(
                            builder: ((context, ref, child) {
                              return KButton(
                                title: 'Checkout',
                                onTap: () async {
                                 if( await ref.read(zoneProvider.notifier).isLocationSet(addressName)){
                                   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddressPage(
                                                )));
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
                ),
              ),
            ),
          )
        : const LoginPage();
  }
}
