import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/components/dialog/k_dialog.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../../components/textfield/k_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController prePassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Change Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Previous Password',
                    style: KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                  ),
                  const SizedBox(height: 16),
                  KTextField(
                    controller: prePassword,
                    hintText: '*************',
                    labelText: '',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'New Password',
                    style: KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                  ),
                  const SizedBox(height: 16),
                  KTextField(
                    controller: newPassword,
                    hintText: '*************',
                    labelText: '',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Confirm New Password',
                    style: KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                  ),
                  const SizedBox(height: 16),
                  KTextField(
                    controller: confirmPassword,
                    hintText: '*************',
                    labelText: '',
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.27),
              KButton(
                title: 'Change Password',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const KDialog(message: 'Password Changed!');
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              KBorderButton(
                title: 'Go Back',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
