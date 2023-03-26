import 'package:flutter/material.dart';

import '../../styles/k_colors.dart';
import '../../styles/k_text_style.dart';

class KTextButton extends StatelessWidget {
  final String? title;
  final String? price;
  final bool isPrice;
  final VoidCallback? onTap;

  const KTextButton({this.price, this.title, this.onTap,required this.isPrice, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        height: 54,
        decoration: BoxDecoration(
          color: KColor.blackbg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
           mainAxisAlignment: isPrice
              ? MainAxisAlignment.spaceBetween :  MainAxisAlignment.center,
          children: [
            Text('$title',
                style: KTextStyle.subtitle1
                    .copyWith(color: KColor.whiteBackground)),
            isPrice ? Text('$price',
                style: KTextStyle.subtitle1
                    .copyWith(color: KColor.whiteBackground)) : Container(),
          ],
        ),
      ),
    );
  }
}
