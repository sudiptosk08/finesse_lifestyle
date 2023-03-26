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
      child: Column(
        children: [
          Container(
            height: KSize.getHeight(context, 35),
            width: widget.width,
            alignment: Alignment.center,
            decoration: widget.index != 5
                ? BoxDecoration(
                    border: Border.all(
                        color: (_selectedItems.contains(widget.index))
                            ? KColor.transparent
                            : KColor.black),
                    color: (_selectedItems.contains(widget.index))
                        ? KColor.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10))
                : BoxDecoration(color: KColor.transparent),
            child: Text(
              widget.categoryList!,
              style: KTextStyle.button.copyWith(
                  color: widget.index != 2
                      ? (_selectedItems.contains(widget.index))
                          ? KColor.white
                          : KColor.grey350
                      : KColor.grey350),
            ),
          ),
        ],
      ),
    );
  }
}
