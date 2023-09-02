import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/home/controllers/shop_controller.dart';
import 'package:finesse/src/features/home/controllers/slider_controller.dart';
import 'package:finesse/src/features/home/models/slider_model.dart';
import 'package:finesse/src/features/home/state/slider_state.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/product_details/view/product_details.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularCategory extends StatefulWidget {
  const PopularCategory({Key? key}) : super(key: key);

  @override
  State<PopularCategory> createState() => _PopularCategoryState();
}

class _PopularCategoryState extends State<PopularCategory> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final sliderState = ref.watch(sliderProvider);
        final List<PopularSubCategory>? popularCategory =
            sliderState is SliderSuccessState
                ? sliderState.homeSliderModel?.popularSubCategory
                : [];
        final List<MiddleBanner>? middleBanner =
            sliderState is SliderSuccessState
                ? sliderState.homeSliderModel?.middleBanner
                : [];

        return Column(
          children: [
            SizedBox(
              height: 36,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: popularCategory!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(shopProvider.notifier).fetchShopProductList(
                              categoryId: popularCategory[index].id,
                              groupId: "",
                              str: "");

                          Navigator.pushNamed(context, '/shop');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: KColor.blackbg.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              popularCategory[index].catName.toString(),
                              style: KTextStyle.bodyText3.copyWith(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 172,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: middleBanner!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //   ref.read(shopProvider.notifier).fetchShopProductList(
                      //     groupId: "",
                      //     categoryId: "",
                      //     str: "");
                      // Navigator.pushNamed(context, '/shop');
                       ref
                          .read(productDetailsProvider.notifier)
                          .fetchProductsDetails(middleBanner[index].appLink);
                      ref.read(cartProvider.notifier).cartDetails();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const ProductDetails(
                            ),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Image.network(middleBanner[index].image),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
