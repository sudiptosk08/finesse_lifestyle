import 'dart:io';

import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/components/textfield/k_text_field.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/login/controller/login_controller.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/auth/login/state/login_state.dart';
import 'package:finesse/src/features/profile/controller/profile_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/textfield/k_fill_name.dart';
import '../../../../components/textfield/k_fill_phone.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  TextEditingController reason = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController description = TextEditingController();
  String? valueChoose;
  List<String> listItem = [
    "Delivery agent took Extra/Less money",
    "Issue with delivery agent",
    "I want to cancel my order",
    "I want to change the delivery information",
    "I want to change my registered mobile number",
    "Mistakenly place a double order",
    "Order status wrong",
    "Payment status wrong",
    "Put the delivery on hold",
    "Request to Exchange my order",
    "Requesting deliver on a fixed time and date",
    "The product was damage",
    "The product has not been delivered yet"
  ];
  File? image;
  var userID = getIntAsync(userId);

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final reportState = ref.watch(reportProvider);
        final userState = ref.watch(loginProvider);
        final User? userData =
            userState is LoginSuccessState ? userState.userModel : null;

        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: KAppBar(checkTitle: true, title: 'Report Issue'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Reason*',
                    style: KTextStyle.subtitle7.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //const KDropdown(hint: 'Select a reason'),

                  Padding(
                    padding: EdgeInsets.only(left: 3.1, right: 3.1),
                    child: Container(
                      padding: EdgeInsets.only(left: 3.1, right: 3.1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: KColor.grey.withOpacity(0.1),
                      ),
                      child: DropdownButton(
                        hint: Text(
                          "Select",
                          style: KTextStyle.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        dropdownColor: Colors.grey[250],
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                        value: valueChoose,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = newValue.toString();
                          });
                        },
                        items: listItem.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: KTextStyle.bodyText1.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'Order ID*',
                    style: KTextStyle.subtitle7.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  KFillPhone(
                    controller: id,
                    readOnly: false,
                    label: '',
                    hintText: 'Order ID',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description*',
                    style: KTextStyle.subtitle7.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  KFillNormal(
                    controller: description,
                    readOnly: false,
                    label: '',
                    hintText: 'Description',
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Container(
                      width: context.screenWidth,
                      height: 175,
                      decoration: BoxDecoration(
                        color: KColor.searchColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 24,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Click or drag files here to upload',
                                  style: KTextStyle.bodyText1.copyWith(
                                    color: KColor.blackbg.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            )
                          : Image.file(
                              image!,
                              height: 175,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.05),
                  KButton(
                    title: reportState is LoadingState
                        ? 'Please wait...'
                        : 'Save Changes',
                    onTap: () {
                      if (reportState is! LoadingState) {
                        ref.read(reportProvider.notifier).report(
                              description: description.text,
                              reason: valueChoose.toString(),
                              orderId: id.text,
                              userId: userID.toString(),
                              image: image.toString(),
                            );
                      }
                      Navigator.pushNamed(context, '/mainScreen');
                    },
                  ),

                  const SizedBox(height: 16),
                  KBorderButton(
                    title: 'View Report List',
                    onTap: () {
                      ref.read(reportProvider.notifier).fetchReports();
                      Navigator.pushNamed(context, '/reportList');
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
