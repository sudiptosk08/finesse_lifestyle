import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/checkout/components/add_address.dart';
import 'package:finesse/src/features/checkout/components/add_office.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Billing Information'),
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
