import 'package:finesse/components/card/notification_card.dart';
import 'package:finesse/components/textfield/k_search_field.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: KColor.blackbg),
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: KColor.appBackground,
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pushNamed(context, '/mainScreen');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
        ),
        actions: [
          PopupMenuButton(
            color: KColor.appBackground,
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text(
                  'Mark all as read',
                  style: KTextStyle.subtitle3.copyWith(
                    color: KColor.blackbg.withOpacity(0.7),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Clear all',
                  style: KTextStyle.subtitle3.copyWith(
                    color: KColor.blackbg.withOpacity(0.7),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Settings',
                  style: KTextStyle.subtitle3.copyWith(
                    color: KColor.blackbg.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            SearchTextField(
              controller: search,
              readOnly: false,
              hintText: 'Search...',
              lable: 'Search',
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style:
                          KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            extentRatio: 0.85,
                            dismissible: DismissiblePane(
                              onDismissed: () async {},
                            ),
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (index) {},
                                backgroundColor: KColor.deleteColor,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline_outlined,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                              ),
                            ],
                          ),
                          child: Column(
                            children: const [
                              NotificationCard(),
                              SizedBox(height: 8)
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
