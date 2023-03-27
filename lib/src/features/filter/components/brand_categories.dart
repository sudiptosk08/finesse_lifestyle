import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../styles/k_colors.dart';
import '../../../../styles/k_size.dart';
import '../../../../styles/k_text_style.dart';

class CategoryList extends StatefulWidget {
  final String? categoryList;
  final double? width;
  final int? index;

  const CategoryList({
    Key? key,
    this.categoryList,
    this.index,
    this.width,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_selectedItems.contains(widget.index)) {
          setState(() {
            _selectedItems.removeWhere((val) => val == widget.index);
          });
        } else {
          setState(() {
            _selectedItems.add(widget.index!);
          });
        }
      },
      child: Expanded(
        child: Container(
          height: KSize.getHeight(context, 35),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: (_selectedItems.contains(widget.index))
                      ? KColor.transparent
                      : KColor.black),
              color: (_selectedItems.contains(widget.index))
                  ? KColor.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.categoryList!,
            style: KTextStyle.button.copyWith(
                color: (_selectedItems.contains(widget.index))
                    ? KColor.white
                    : KColor.grey350),
          ),
        ),
      ),
    );
  }
}
