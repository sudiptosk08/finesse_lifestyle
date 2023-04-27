import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/stepper/k_stepper.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/src/features/profile/model/order_model.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/textfield/k_search_field.dart';
import '../../../../components/textfield/k_text_field.dart';

class TrackOrder extends StatefulWidget {
  final OrderData orderData;
  TrackOrder({Key? key, required this.orderData}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("in track");
    print(widget.orderData);
    print("after track");
  }

  @override
  Widget build(BuildContext context) {
    // aftear track
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Track Order'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "ID: #${widget.orderData.id.toString()} ",
                  style: KTextStyle.headline4.copyWith(
                    color: KColor.blackbg,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Placed on",
                        style: KTextStyle.subtitle1.copyWith(
                          color: KColor.blackbg,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        // "6 May",
                        "${widget.orderData.createdAt.toString()}",
                        style: KTextStyle.bodyText1.copyWith(
                          color: KColor.blackbg.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Delivery",
                        style: KTextStyle.subtitle1.copyWith(
                          color: KColor.blackbg,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   "6 May - 12 May",
                      //   style: KTextStyle.bodyText1.copyWith(
                      //     color: KColor.blackbg.withOpacity(0.4),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Tracking Details",
                style: KTextStyle.subtitle1.copyWith(
                  color: KColor.blackbg,
                ),
              ),
              const SizedBox(height: 16),
              const KStepper(checkStepper: false),
              SizedBox(height: context.screenHeight * 0.04),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Info",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: KColor.appBackground,
                      boxShadow: [
                        BoxShadow(
                          color: KColor.shadowColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset:
                              const Offset(4, 4), // changes position of shadow
                        ),
                        BoxShadow(
                          color: KColor.shadowColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: const Offset(
                              -4, -4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/watch-two.png',
                          height: 49,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hanging Clock',
                              style: KTextStyle.bodyText2.copyWith(
                                color: KColor.blackbg,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$44.90",
                                  style: KTextStyle.subtitle1.copyWith(
                                    color: KColor.blackbg,
                                  ),
                                ),
                                SizedBox(width: context.screenWidth * 0.35),
                                Text(
                                  "(x2)",
                                  style: KTextStyle.description.copyWith(
                                    color: KColor.baseBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reciept",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetPath.confirmIcon,
                            height: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "Payment made via Paypal",
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(AssetPath.paypalLogo, height: 24)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
