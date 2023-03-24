import 'package:finesse/components/appbar/k_app_bar.dart';
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

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController zoneCon = TextEditingController();
  TextEditingController areaCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Shipping Address'),
      ),
      body:Container( 
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          controller: nameCon,
                          hintText: 'Enter your name here...',
                          label: '',
                          readOnly: false,
                        ),
                      ),
                      _editInformation(
                        'Email',
                        KFillNormal(
                          controller: emailCon,
                          hintText: 'Enter your email here...',
                          label: '',
                          readOnly: false,
                        ),
                      ),
                     
                      _editInformation(
                        'Phone Number',
                        KFillPhone(
                          controller:phoneCon,
                          hintText: 'Enter your phone number here...',
                          label: '',
                          readOnly: false,
                        ),
                      ),
                      _editInformation(
                       '',
                        DeliveryAddress( isShippingAddressPage:  true),
                      ),
                       _editInformation(
                        'Address',
                        KFillNormal(
                          controller: addressCon,
                          hintText: 'Enter your address here...',
                          label: '',
                          readOnly: false,
                        ),
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
                                ref.read(addressProvider.notifier).AddShippingAddress(context: context,nameis: nameCon.text, emailis: emailCon.text, phoneis: phoneCon.text, addressis: addressCon.text ,);
                            }
                            // Navigator.pushNamed(context, '/accountDetails');
                          }
                        
                     );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
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
