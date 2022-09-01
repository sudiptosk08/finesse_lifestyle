import 'package:flutter/material.dart';
import '../../styles/k_colors.dart';
import '../../styles/k_text_style.dart';

// ignore: must_be_immutable
class KFillNormal extends StatefulWidget {
  final String label;
  final String hintText;
  final bool readOnly;

  KFillNormal({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.readOnly,
  }) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  State<KFillNormal> createState() => _KFillNormalState();
}

class _KFillNormalState extends State<KFillNormal> {
  final FocusNode _focusNode = FocusNode();
  Color _color = KColor.searchColor.withOpacity(0.8);

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _color = Colors.transparent;
        });
      } else {
        setState(() {
          _color = KColor.searchColor.withOpacity(0.8);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        String pattern = r'^[a-z A-Z]';
        RegExp regExp = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Please FillUp';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter valid name';
        }
        return null;
      },
      readOnly: widget.readOnly,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: _focusNode.hasFocus
            ? KTextStyle.subtitle3.copyWith(
                color: KColor.blackbg.withOpacity(0.8),
              )
            : KTextStyle.subtitle3.copyWith(
                color: KColor.blackbg.withOpacity(0.4),
              ),
        labelText: widget.label,
        labelStyle: KTextStyle.subtitle3.copyWith(
          color: KColor.blackbg.withOpacity(0.4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: KColor.blackbg.withOpacity(0.8),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: _color,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      focusNode: _focusNode,
    );
  }
}
