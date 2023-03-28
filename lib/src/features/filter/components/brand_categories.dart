import 'package:flutter/material.dart';

import '../../../../styles/k_colors.dart';
import '../../../../styles/k_text_style.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final int chipId;

  FilterChipWidget({Key? key, required this.chipName, required this.chipId})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: KTextStyle.bodyText1
          .copyWith(color: KColor.grey, fontWeight: FontWeight.normal),
      selected: _isSelected,
      showCheckmark: false,
      disabledColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: BorderSide(
            color: KColor.grey,
            width: 1.2,
          )),
      padding: EdgeInsets.only(left: 2.5, right: 2.5),
      backgroundColor: KColor.white,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          // store.dispatch(FilterTagAction(widget.chipId));
        });
      },
      labelPadding: EdgeInsets.symmetric(horizontal: 7),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      selectedColor: Colors.black,
    );
  }
}
