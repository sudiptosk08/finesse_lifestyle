import 'package:finesse/components/slider/k_slider.dart';
import 'package:finesse/src/features/home/components/category_section.dart';
import 'package:finesse/src/features/home/components/featured_products.dart';
import 'package:finesse/src/features/home/components/new_arrivals.dart';
import 'package:finesse/src/features/home/components/popular_category.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/shop_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const KSlider(selectSliders: 1),
              const SizedBox(height: 15),
              _categoryHeader(
                'Categories',
                () => Navigator.pushNamed(context, '/category'),
              ),
              const CategorySection(),
              const SizedBox(height: 12),
              _categoryHeader('Popular Right Now', () {}),
              const SizedBox(height: 8),
              const PopularCategory(),
              const SizedBox(height: 15),
              _categoryHeader('New Arrivals', () {
                ref
                    .read(shopProvider.notifier)
                    .fetchShopProductList(groupId: "", categoryId: "", str: "");
                Navigator.pushNamed(context, '/shop');
              }, showViewAll: true),
              const NewArrivals(),
              const SizedBox(height: 15),
              _categoryHeader('Featured Products', () {
                ref
                    .read(shopProvider.notifier)
                    .fetchShopProductList(groupId: "", categoryId: "", str: "");
                Navigator.pushNamed(context, '/shop');
              }, showViewAll: true),
              const FeaturedProducts(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Column _categoryHeader(title, tap, {bool showViewAll = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: KTextStyle.headline2.copyWith(color: KColor.blackbg),
            ),
            if (showViewAll)
              InkWell(
                onTap: tap,
                child: Text(
                  'View all',
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
