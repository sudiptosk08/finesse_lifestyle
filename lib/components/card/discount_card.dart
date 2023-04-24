import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';

import '../textfield/k_field.dart';

class CouponCodeCard extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? buttonText;
  final TextEditingController? controller;
  final VoidCallback? tap;
  final bool? readOnly;

  const CouponCodeCard({
    Key? key,
    this.title,
    this.readOnly,
    this.hintText,
    this.buttonText,
    this.controller,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: KTextStyle.subtitle1.copyWith(
            color: KColor.blackbg,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              flex: 2,
              child:  KTextField(
                readOnly: readOnly!,
                controller: controller!,
                hintText: hintText!,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: KButton(title: buttonText, onTap: tap),
            ),
          ],
        ),
      ],
    );
  }
}
