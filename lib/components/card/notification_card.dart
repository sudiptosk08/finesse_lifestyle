import 'package:finesse/components/dialog/k_confirm_dialog.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../styles/k_colors.dart';
import '../../styles/k_text_style.dart';

class NotificationCard extends StatefulWidget {
  final String? msg;
  final String? date;
  String? seen;
  final VoidCallback? cancel;
  final VoidCallback? delete;
  NotificationCard({
    this.cancel,
    this.delete,
    this.seen ,
    Key? key,
    this.msg,
    this.date,
  }) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isSwapToLeft = false; 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   setState(() {
      //     // widget.seen = 0;
      //   });
      // },
      child: Dismissible(
        key: UniqueKey(),
        dragStartBehavior: DragStartBehavior.start,
        movementDuration: const Duration(milliseconds: 200),
        resizeDuration: const Duration(milliseconds: 1000),
        onDismissed: (direction) {
          switch (direction) {
            case DismissDirection.startToEnd:
              break;
            case DismissDirection.endToStart:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return KConfirmDialog(
                    message: 'Delete product',
                    subMessage: 'Are you sure you want to delete this product?',
                    onCancel: widget.cancel,
                    onDelete: widget.delete,
                  );
                },
              );
              break;
            default:
              break;
          }
        },
        secondaryBackground: _endToStartBackground(),
        background: _startToEndBackground(),
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 8, left: 2, right: 2),
          padding: const EdgeInsets.only(left: 20),
          height: 114,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // borderRadius: BorderRadius.only(
            //   topLeft:isSwapToLeft Radius.circular(0.0), 
            //   bottomLeft : 0 , 
            // ),
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
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  // fit:StackFit.expand,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: KColor.cirColor.withOpacity(0.6),
                    ),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/images/sound.png',
                        fit: BoxFit.contain,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    if (widget.seen.toString() == "0")
                      Positioned(
                        top: 7,
                        right: 7,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: KColor.blackbg.withOpacity(.8),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        widget.msg.toString(),
                        // style:widget.isRead ? KTextStyle.bodyText1.copyWith(color: KColor.blackbg.withOpacity(0.7)):
                        //  KTextStyle.bodyText2.copyWith(color: KColor.blackbg.withOpacity(0.7)),
                        style: widget.seen.toString() == "0"
                            ? KTextStyle.bodyText2.copyWith(
                                color: KColor.blackbg.withOpacity(0.7))
                            : KTextStyle.bodyText1.copyWith(
                                color: KColor.blackbg.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.date.toString(),
                      style: KTextStyle.caption1
                          .copyWith(color: KColor.blackbg.withOpacity(0.3)),
                    )
                  ],
                ),
              ),
              //const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Container _startToEndBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      margin: const EdgeInsets.only(top: 10, bottom: 8, left: 2, right: 2),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AssetPath.NoticheckIcon,
            height: 23,
          ),
        ],
      ),
    );
  }

  Container _endToStartBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      margin: const EdgeInsets.only(top: 10, bottom: 8, left: 2, right: 2),
      decoration: const BoxDecoration(
        color: KColor.deleteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            AssetPath.notiDeleteIcon,
            height: 23,
          ),
        ],
      ),
    );
  }
}
