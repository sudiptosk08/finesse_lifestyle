import 'package:finesse/styles/b_style.dart';
import 'package:flutter/material.dart';

class KCheckedButton extends StatefulWidget {
   KCheckedButton({required this.height, required this.radius, required this.width, Key? key}) : super(key: key);

  final double width;
  final double height;
  final double radius;
  @override
  State<KCheckedButton> createState() => _KCheckedButtonState();
}

class _KCheckedButtonState extends State<KCheckedButton> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Checkbox(
        value: isChecked,
        // visualDensity: VisualDensity.comfortable,
        activeColor: KColor.blackbg,
        checkColor: KColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        side: const BorderSide(color: KColor.black),
        onChanged:(value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
