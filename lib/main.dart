import 'dart:io';

import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/logger/logger.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/route/route_generator.dart';
import 'package:finesse/service/navigation_service.dart';
import 'package:finesse/src/features/auth/login/controller/login_controller.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/home/controllers/category_controller.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/src/features/home/controllers/product_category_controller.dart';
import 'package:finesse/src/features/home/controllers/shop_controller.dart';
import 'package:finesse/src/features/home/controllers/slider_controller.dart';
import 'package:finesse/src/features/notification/controller/notification_controller.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/profile/controller/profile_controller.dart';
import 'package:finesse/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initialize();
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    initData();
  }

  bool _isLoggedIn = false;

  initData() {
    _isLoggedIn = getBoolAsync(isLoggedIn, defaultValue: false);
    if (_isLoggedIn) ref.read(loginProvider.notifier).userModel;
    ref.read(sliderProvider.notifier).fetchSliderDetails();
    ref.read(productCategoryProvider.notifier).fetchProductsCategoryDetails();
    ref.read(shopProvider.notifier).fetchShopProductList();
    ref.read(categoryProvider.notifier).fetchCategoryDetails();
    ref.read(allBrandsProvider.notifier).fetchAllBrands();
    ref.read(menuDataProvider.notifier).fetchMenuData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finesse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
      initialRoute: '/mainScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
