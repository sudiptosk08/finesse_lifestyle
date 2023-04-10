import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/src/features/checkout/controller/address_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_billing_information.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: AppBar(
        backgroundColor: KColor.appBackground,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading:Consumer(  
          builder: (context,ref,child){
            return IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              ref.read(addressProvider.notifier).makeAddressNull();
              Navigator.of(context).pop();
            });
          },
        ) ,
        title: Text(
          'Billing Information',
          style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: AddBillingInformation(),
        ),
      ),
    );
  }
}
