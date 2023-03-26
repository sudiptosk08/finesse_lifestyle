import 'package:finesse/components/checkedbutton/k_checked_buttton.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:flutter/material.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentCategory extends StatefulWidget {
  const PaymentCategory({Key? key}) : super(key: key);

  @override
  State<PaymentCategory> createState() => _PaymentCategoryState();
}

class _PaymentCategoryState extends State<PaymentCategory> {
  List<String> payment = [
    // "PayPal",
    // "Visa Card",
    // "Master Card",
    // "bKash",
    "Cash On Delivery",
  ];
  bool isChecked = true;
  List<dynamic> paymentIcons = [
    // AssetPath.visa,
    // AssetPath.visa,
    // AssetPath.masterCard,
    // AssetPath.bKash,
    AssetPath.cashOnDelivery,
  ];
  int selectedIndex = -1; 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int selectedIndex = paymentOptionIndex ==null ? -1:  paymentOptionIndex!;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: payment.length,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: KColor.filterDividerColor,
            border: Border.all(
              color: KColor.baseBlack,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            paymentOption = null; 
                            paymentOption = payment[index];
                            selectedIndex = index;
                            paymentOptionIndex = null;
                            paymentOptionIndex = index;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: KColor.black),
                              borderRadius: BorderRadius.circular(5),
                              color: index == selectedIndex
                                  ? KColor.baseBlack
                                  : Colors.transparent),
                          child: index == selectedIndex
                              ? Image.asset(AssetPath.NoticheckIcon)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        payment[index],
                        style: KTextStyle.bodyText2.copyWith(
                          color: KColor.baseBlack,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    AssetPath.cashOnDelivery,
                    height: 32,
                  )
                ],
              ),
              // if (index == 0) const SizedBox(height: 18),
            ],
          ),
        );
      },
    );
  }
}
