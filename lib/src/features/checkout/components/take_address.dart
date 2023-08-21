import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/checkout/components/add_shipping_address.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/src/features/checkout/state/add_address.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
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
  bool addShippingAddress = false;

  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();

  @override
  initState() {
    super.initState();

    if (getJSONAsync(shippingAddress).isNotEmpty) {
      addShippingAddress = true;
    }
  }

  @override 
  void dispose() {
    // TODO: implement dispose
    super.dispose(); 
    nameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    addressCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userState = ref.watch(menuDataProvider);
        final User? userData =
            userState is MenuDataSuccessState ? userState.menuList!.user : null;
        final addressState = ref.watch(addressProvider);
        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: KAppBar(checkTitle: true, title: 'Checkout'),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/stepper_one.svg'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Billing Address',
                        style: KTextStyle.subtitle1
                            .copyWith(color: KColor.blackbg),
                      ),
                      InkWell(
                        onTap: () {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                  ),
                                  // Icon(
                                  //   Icons.edit,
                                  //   color: KColor.blackbg,
                                  //   size: 25,
                                  // )
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
                              Text(
                                  "${billingAddressMap['area'].toString()}, ${billingAddressMap['zone'].toString()}, ${billingAddressMap['city'].toString()}"),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // if (getJSONAsync(shippingAddress).isEmpty) {
                              //   setState(() {
                              //     addShippingAddress = true;
                              //   });
                              //   ref
                              //       .read(addressProvider.notifier)
                              //       .makeAddressNull();
                              //   Navigator.pushNamed(
                              //       context, '/checkoutShippingAddress');
                              // }
                              print("shipping address tap"); 
                              print(getJSONAsync(shippingAddress));
                              setState(() {
                                if (addShippingAddress == true) {
                                   nameCon.clear(); 
                          emailCon.clear(); 
                          phoneCon.clear(); 
                          addressCon.clear();
                                  removeKey(shippingAddress);
                                }
                                addShippingAddress = !addShippingAddress;
                              });
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: addShippingAddress == false
                                    ? Colors.transparent
                                    : KColor.black,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: KColor.black, width: 1),
                              ),
                              child: addShippingAddress == false
                                  ? null
                                  : Padding(
                                      padding: const EdgeInsets.all(2),
                                      child:
                                          Image.asset(AssetPath.NoticheckIcon),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            getJSONAsync(shippingAddress).isEmpty
                                ? "Add Different Shipping Address"
                                : "Shipping Address Added",
                            style: KTextStyle.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (addShippingAddress) ...[
                    AddShippingAddress(
                      nameCon: nameCon,
                      emailCon: emailCon,
                      phoneCon: phoneCon,
                      addressCon: addressCon,
                    )
                  ],
                  SizedBox(height: context.screenHeight * 0.2),
                  KButton(
                    
                     title:   addShippingAddress ? addressState is AddressLoadingState ?'Please wait':'Proceed to Payment' : 'Proceed to Payment',
                  
                      onTap: () {
                        if (addShippingAddress&& getJSONAsync(shippingAddress).isEmpty) {
                          if (addressState is! AddressLoadingState ) {
                            ref
                                .read(addressProvider.notifier)
                                .AddShippingAddress(
                                  context: context,
                                  nameis: nameCon.text,
                                  emailis: emailCon.text,
                                  phoneis: phoneCon.text,
                                  addressis: addressCon.text,
                                );
                          }
                        } else {
                         
                          Navigator.pushNamed(context, '/payment');
                        }
                      }),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
