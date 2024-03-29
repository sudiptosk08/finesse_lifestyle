import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../components/button/k_button.dart';
import '../../../../components/textfield/k_fill_name.dart';
import '../../../../components/textfield/k_fill_phone.dart';
import '../../../../constants/shared_preference_constant.dart';
import '../../../../styles/k_colors.dart';
import '../../../../styles/k_text_style.dart';
import '../../cart/components/get_location.dart';

class AddAddress extends StatefulWidget {
  final String addressLabel;
  AddAddress({Key? key, required this.addressLabel}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

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
                DeliveryAddress(),
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
