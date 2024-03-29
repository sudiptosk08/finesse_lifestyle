import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/src/features/main_screen.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: KAppBar(checkTitle: false,
        dotCheck: true,
        onTap: () {
          Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) =>  MainScreen())),
                (route) => false);
        },
        
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Image.asset(
              AssetPath.confirm,
              height: context.screenHeight * 0.35,
            ),
            SizedBox(height: context.screenHeight * 0.02),
            Text(
              textAlign: TextAlign.center,
              'Congratulations!\nOrder Placed Successfully.',
              style: KTextStyle.headline2.copyWith(color: KColor.blackbg),
            ),
            const SizedBox(height: 16),
            Text(
              'Estimated Delivery in 7 days',
              style: KTextStyle.bodyText1.copyWith(
                color: KColor.blackbg.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
            // Text(
            //   'Order Number #99045677',
            //   style: KTextStyle.bodyText1.copyWith(
            //     color: KColor.blackbg.withOpacity(0.6),
            //   ),
            // ),
            SizedBox(height: context.screenHeight * 0.05),
            KButton(
              title: 'Continue Shopping',
              onTap: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => MainScreen()) ), (route) => false);
              },
            ),
            const SizedBox(height: 16),
            // KBorderButton(
            //   title: 'Track Order',
            //   onTap: () {
            //     Navigator.pushNamed(context, '/mainScreen');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
