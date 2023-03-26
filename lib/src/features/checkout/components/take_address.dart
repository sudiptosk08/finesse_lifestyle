import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/components/checkedbutton/k_checked_buttton.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/auth/login/controller/login_controller.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/auth/login/state/login_state.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/src/features/home/models/menu_data_model.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/appbar/k_app_bar.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int currentIndex = 1;
  int addressCurrentIndex = 1;

  String cityN = "";
  String zoneN = "";
  String areaN = "";
  String addressN = "";
  String userN = "";
  String contractN = "";
  bool isShippingAddressAdded = false;
 

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userState = ref.watch(menuDataProvider);
        final adressState = ref.watch(addressProvider);
        final User? userData = userState is MenuDataSuccessState ? userState.menuList!.user : null;
    

        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: KAppBar(checkTitle: true, title: 'Checkout'),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/stepper_one.svg'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Delivery Address',
                      style:
                          KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                    ),
                    InkWell( 
                      onTap: (){
                        ref.read(addressProvider.notifier).makeAddressNull(); 
                        Navigator.pushNamed(context, '/checkoutNewAddress');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: KColor.filterDividerColor,
                          border: Border.all(color: KColor.baseBlack),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                Container(
                                  alignment: Alignment.center,
                                  width: context.screenWidth * 0.2,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: KColor.blackbg,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Default',
                                    style: KTextStyle.caption2.copyWith(
                                      color: KColor.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // billingAddressMap['city'].toString()?? ''
                            const SizedBox(height: 8),
                            // Text(userN),
                            // Text(contractN),
                            // const SizedBox(height: 20),
                            // Text("${areaN}, ${zoneN}, ${cityN}"),
                    
                             Text(userData!.customer.customerName.toString()),
                            Text(userData.customer.contact.toString()),
                            const SizedBox(height: 20),
                            Text("${billingAddressMap['area'].toString()?? ''}, ${billingAddressMap['zone'].toString()?? ''}, ${billingAddressMap['city'].toString()?? ''}"),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (getJSONAsync(shippingAddress).isEmpty) {
                              setState(() {
                                isShippingAddressAdded = true;
                              });
                              ref.read(addressProvider.notifier).makeAddressNull();
                              Navigator.pushNamed(
                                  context, '/checkoutShippingAddress');
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: getJSONAsync(shippingAddress).isEmpty
                                  ? Colors.transparent
                                  : KColor.black,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: KColor.black, width: 1),
                            ),
                            child: getJSONAsync(shippingAddress).isEmpty
                                ? null
                                : Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Image.asset(AssetPath.NoticheckIcon),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                         getJSONAsync(shippingAddress).isEmpty? "Add Shipping Address":"Shipping Address Added",
                          style: KTextStyle.bodyText2,
                        ),
                      ],
                    )
                  
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.2),
                KButton(
                  title: 'Proceed to Payment',
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
                KBorderButton(
                  title: 'Go Back',
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}
