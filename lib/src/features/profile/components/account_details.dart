import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/src/features/home/models/menu_data_model.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/controllers/menu_data_controller.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userState = ref.watch(menuDataProvider);
        final MenuDataModel? userData =
            userState is MenuDataSuccessState ? userState.menuList : null;

        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: KAppBar(checkTitle: true, title: 'Account Details'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _editProfile('Name',
                      userData!.user.customer.customerName.toString(), () {}),
                  _editProfile('Email', userData.user.email.toString(), () {}),
                  _editProfile('Address',
                      userData.user.customer.address ?? "Not set yet", () {}),
                  _editProfile(
                      'Phone Number', userData.user.contact.toString(), () {}),
                  SizedBox(height: context.screenHeight * 0.28),
                  KButton(
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pushNamed(context, '/changePassword');
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column _editProfile(String title, String info, onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
          style: KTextStyle.subtitle1.copyWith(
            color: KColor.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 24),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  info.toString(),
                  style: KTextStyle.description.copyWith(
                    color: KColor.blackbg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
