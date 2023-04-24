import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
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

class AddBillingInformation extends StatefulWidget {
  const AddBillingInformation({Key? key}) : super(key: key);

  @override
  State<AddBillingInformation> createState() => AddBillingInformationState();
}

class AddBillingInformationState extends State<AddBillingInformation> {
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
        final menuData = ref.watch(menuDataProvider);
        User? user =
            menuData is MenuDataSuccessState ? menuData.menuList!.user : null;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _editInformation(
                  'Name',
                  KFillNormal(
                    controller: name..text = user!.customer.customerName!,
                    hintText: 'Enter your name here...',
                    label: '',
                    readOnly: true,
                  ),
                ),
                _editInformation(
                  'Email',
                  KFillNormal(
                    controller: email..text = user.customer.email!,
                    hintText: 'Enter your email here...',
                    label: '',
                    readOnly: true,
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
                  'Address',
                  KFillNormal(
                    controller: address..text = user.customer.address!,
                    hintText: 'Enter your address here...',
                    label: '',
                    readOnly: false,
                  ),
                ),
                DeliveryAddress(
                  isBilliingInfoPage: true,
                ),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.05),
            Consumer(
              builder: (context, ref, child) {
                final addressState = ref.watch(addressProvider);
                return KButton(
                    title: addressState is LoadingState
                        ? 'please wait...'
                        : 'Update',
                    onTap: () {
                      if (addressState is! LoadingState) {
                        ref.read(addressProvider.notifier).addBillingINfo(
                              context: context,
                              nameis: name.text,
                              emailis: email.text,
                              phoneis: phone.text,
                              addressis: address.text,
                            );
                        print(
                            "Address Text ===================${address.text}");
                      }
                      // Navigator.pushNamed(context, '/accountDetails');
                    });
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
