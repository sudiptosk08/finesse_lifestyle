import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/src/features/auth/login/state/login_state.dart';
import 'package:finesse/src/features/profile/components/update_profile.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/button/k_button.dart';
import '../../../../components/textfield/k_fill_name.dart';
import '../../../../components/textfield/k_fill_phone.dart';
import '../../../../components/textfield/k_text_field.dart';
import '../../../../constants/shared_preference_constant.dart';
import '../../../../core/base/base_state.dart';
import '../../../../styles/k_colors.dart';
import '../../../../styles/k_text_style.dart';
import '../../auth/login/controller/login_controller.dart';
import '../../auth/login/model/user_model.dart';
import '../../cart/components/get_location.dart';
import '../../profile/controller/profile_controller.dart';

class AddHome extends StatefulWidget {
  const AddHome({Key? key}) : super(key: key);

  @override
  State<AddHome> createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  String? _cities;
  String? _zones;
  var username = getStringAsync(userName);
  var useremail = getStringAsync(userEmail);
  var contact = getStringAsync(userContact);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _editInformation(
                  'Name',
                  KFillNormal(
                    controller: name..text = username,
                    hintText: 'Enter your name here...',
                    label: '',
                    readOnly: false,
                  ),
                ),
                _editInformation(
                  'Email',
                  KFillNormal(
                    controller: email..text = useremail,
                    hintText: 'Enter your email here...',
                    label: '',
                    readOnly: false,
                  ),
                ),
                _editInformation(
                  'Address',
                  KFillNormal(
                    controller: address,
                    hintText: 'Enter your address here...',
                    label: '',
                    readOnly: false,
                  ),
                ),
                _editInformation(
                  'Phone Number',
                  KFillPhone(
                    controller: phone..text = contact,
                    hintText: 'Enter your phone number here...',
                    label: '',
                    readOnly: true,
                  ),
                ),
                _editInformation(
                  'City',
                  DeliveryAddress(
                    cities: _cities,
                    zones: _zones,
                    checkCities: true,
                  ),
                ),
                _editInformation(
                  'Zone',
                  DeliveryAddress(
                    cities: _cities,
                    zones: _zones,
                    checkCities: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.05),
            KButton(
              title: 'Add Address',
              onTap: () {
                Navigator.pushNamed(context, '/accountDetails');
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Column _editInformation(String title, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
        ),
        const SizedBox(height: 16),
        field,
        const SizedBox(height: 24),
      ],
    );
  }
}
