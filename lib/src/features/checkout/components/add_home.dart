import 'package:finesse/src/features/checkout/components/add_new_address.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/src/features/checkout/state/add_address.dart';
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
                  DeliveryAddress(),
                ),
               
              ],
            ),
            SizedBox(height: context.screenHeight * 0.05),
            Consumer(
              builder: (context,ref,child){
                 final addressState  = ref.watch(addressProvider);
                 return KButton(
                    title:addressState is AddressLoadingState ?'please wait...':   'Add Address',
                    onTap: () {
                      if(addressState is! AddressLoadingState){
                          ref.read(addressProvider.notifier).AddAddress(nameis: name.text, emailis: email.text, phoneis: phone.text, addressLabel: homeAddress, addressis: address.text);
                      }
                      // Navigator.pushNamed(context, '/accountDetails');
                    }
                  
               );
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
