import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyOrderCard extends StatelessWidget {
  final bool isChecked;
  final String id;
  final String date;
  final String userName;
  final String contract;
  final String grandTotal;
  final String paymentType;
  final String status;
  const MyOrderCard(
      {required this.isChecked,
      Key? key,
      required this.id,
      required this.date,
      required this.userName,
      required this.contract,
      required this.grandTotal,
      required this.paymentType,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: KColor.appBackground,
        boxShadow: [
          BoxShadow(
            color: KColor.shadowColor.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(4, 4), // changes position of shadow
          ),
          BoxShadow(
            color: KColor.shadowColor.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(-4, -4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: #$id",
                style: KTextStyle.subtitle1.copyWith(
                  color: KColor.blackbg,
                ),
              ),
              Text(
                // isChecked == true ? "Delivered" : "Shipped",
                status,
                style: KTextStyle.bodyText2.copyWith(
                  color: status == "Delivered" ? KColor.selectColor : KColor.red12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            // "Placed on 8 May",
            date,
            style: KTextStyle.bodyText1.copyWith(
              color: KColor.blackbg.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            userName,
            style: KTextStyle.bodyText1.copyWith(
              color: KColor.blackbg.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            contract,
            style: KTextStyle.bodyText1.copyWith(
              color: KColor.blackbg.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Text(
                  "Grand total: ",
                  style: KTextStyle.bodyText2.copyWith(
                    color: KColor.blackbg.withOpacity(0.7),
                  ),
                ),
                Text(
                  "৳ $grandTotal",
                  style: KTextStyle.bodyText2.copyWith(
                    color: KColor.blackbg.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/success.svg', height: 18),
                  const SizedBox(width: 3),
                  Text(
                    paymentType,
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              // review
              // if (status == "Delivered")
              //   InkWell(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/orderDetails');
              //     },
              //     child: Container(
              //       height: 40,
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(
              //           color: KColor.blackbg.withOpacity(0.7),
              //         ),
              //       ),
              //       child: Row(
              //         children: [
              //           Text(
              //             'Review',
              //             style: KTextStyle.subtitle1.copyWith(
              //               color: KColor.blackbg,
              //             ),
              //           ),
              //           const SizedBox(width: 3),
              //           SvgPicture.asset('assets/images/edit.svg', height: 20)
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
