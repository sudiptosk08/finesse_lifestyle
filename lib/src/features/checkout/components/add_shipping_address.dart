import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../components/textfield/k_fill_name.dart';
import '../../../../components/textfield/k_fill_phone.dart';
import '../../../../styles/k_colors.dart';
import '../../../../styles/k_text_style.dart';
import '../../cart/components/get_location.dart';

// ignore: must_be_immutable
class AddShippingAddress extends StatefulWidget {
  TextEditingController nameCon;
  TextEditingController emailCon;
  TextEditingController phoneCon;
  TextEditingController addressCon;
  // TextEditingController nameCon;
  // TextEditingController nameCon;
  // TextEditingController nameCon;
  AddShippingAddress(
      {Key? key,
      required this.nameCon,
      required this.emailCon,
      required this.phoneCon,
      required this.addressCon})
      : super(key: key);

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  // TextEditingController nameCon = TextEditingController();
  // TextEditingController emailCon = TextEditingController();
  // TextEditingController phoneCon = TextEditingController();
  // TextEditingController addressCon = TextEditingController();
  // TextEditingController cityCon = TextEditingController();
  // TextEditingController zoneCon = TextEditingController();
  // TextEditingController areaCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: KColor.filterDividerColor,
        border: Border.all(color: KColor.baseBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _editInformation(
                  'Name',
                  KFillNormal(
                       controller: widget.nameCon
                      ..text = getJSONAsync(shippingAddress)['name'] ?? widget.nameCon.text,
                    hintText: 'Enter your name here...',
                    label: '',
                    readOnly: getJSONAsync(shippingAddress).isEmpty? false:true,
                  ),
                ),
                _editInformation(
                  'Email',
                  KFillNormal(
                    // controller: widget.emailCon
                    //   ..text = getJSONAsync(shippingAddress)['email'] == null ||
                    //           widget.emailCon.text.isNotEmpty
                    //       ? widget.emailCon.text
                    //       : getJSONAsync(shippingAddress)['email'],

                     controller: widget.emailCon
                      ..text = getJSONAsync(shippingAddress)['email']?? widget.emailCon.text,

                    hintText: 'Enter your email here...',
                    label: '',
                    readOnly: getJSONAsync(shippingAddress).isEmpty? false:true,
                  ),
                ),
                _editInformation(
                  'Phone Number',
                  KFillPhone(
          
                    
                       controller: widget.phoneCon,
                      
                      
                    hintText: getJSONAsync(shippingAddress)['phone'] ?? 'Enter your phone number here...',
                    label: '',
                    readOnly: getJSONAsync(shippingAddress).isEmpty? false:true,
                  ),
                ),
                _editInformation(
                  'Address',
                  KFillNormal(
                       controller: widget.addressCon
                      ..text = getJSONAsync(shippingAddress)['address'] ?? widget.addressCon.text,
                    hintText: 'Enter your address here...',
                    label: '',
                    readOnly: getJSONAsync(shippingAddress).isEmpty? false:true,
                  ),
                ),
                  _editInformation(
                  'Postal Code',
                  KFillNormal(
                    controller: widget.addressCon
                      ..text = getJSONAsync(shippingAddress)['postCode'] ??
                          widget.addressCon.text,
                    hintText: 'Enter your address here...',
                    label: '',
                    readOnly:
                        getJSONAsync(shippingAddress).isEmpty ? false : true,
                  ),
                ),
                DeliveryAddress(isShippingAddressPage: true),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.05),
            // Consumer(
            //   builder: (context, ref, child) {
            //     final addressState = ref.watch(addressProvider);
            //     return KButton(
            //         title: addressState is AddressLoadingState
            //             ? 'please wait...'
            //             : 'Add Address',
            //         onTap: () {
            //           if (addressState is! AddressLoadingState) {
            //             ref.read(addressProvider.notifier).AddShippingAddress(
            //                   context: context,
            //                   nameis: widget.nameCon.text,
            //                   emailis: emailCon.text,
            //                   phoneis: phoneCon.text,
            //                   addressis: addressCon.text,
            //                 );
            //           }
            //           // Navigator.pushNamed(context, '/accountDetails');
            //         });
            //   },
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
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
