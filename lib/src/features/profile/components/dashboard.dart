import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/appbar/k_app_bar.dart';
import '../../../../styles/k_colors.dart';
import '../../../../styles/k_text_style.dart';
import '../../home/controllers/menu_data_controller.dart';
import '../../home/models/menu_data_model.dart';
import '../../home/state/menu_data_state.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userState = ref.watch(menuDataProvider);
        final MenuDataModel? userData =
            userState is MenuDataSuccessState ? userState.menuList : null;

        return Scaffold(
            backgroundColor: KColor.appBackground,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: KAppBar(checkTitle: true, title: 'DashBoard'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Hello, ${userData!.user.customer.customerName == null ? "" : userData.user.customer.customerName.toString()}",
                    style: KTextStyle.description.copyWith(
                        color: KColor.blackbg, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "From your account dashboard. you can easily check & view your recent orders, manage your shipping and billing addresses and edit your password and account details.",
                    style: KTextStyle.description
                        .copyWith(color: KColor.blackbg, height: 1.5),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
