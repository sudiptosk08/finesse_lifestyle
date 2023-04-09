import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/card/product_card.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/home/controllers/category_controller.dart';
import 'package:finesse/src/features/home/controllers/shop_controller.dart';
import 'package:finesse/src/features/home/models/shop_data_model.dart';
import 'package:finesse/src/features/home/state/shop_state.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/textfield/k_search_field.dart';
import '../../filter/filter_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController controller = TextEditingController();
  int pageNum = 1;
  bool isPageLoading = false;
  String query = "";
  List<Product>? searchResult = [];
  List<Product>? storesData = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final wishlistState = ref.watch(wishlistProvider);
        final shopState = ref.watch(shopProvider);
        final List<Product>? shopData = shopState is ShopSuccessState
            ? shopState.shopDataModel?.products
            : [];
        return Scaffold(
          backgroundColor: KColor.appBackground,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: KAppBar(checkTitle: true, title: 'Shop'),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: SearchTextField(
                          callbackFunction: (query) => ref
                              .read(shopProvider.notifier)
                              .fetchShopProductList(
                                str: query,
                                categoryId: "",
                                groupId: "",
                              ),
                          controller: controller,
                          readOnly: false,
                          hintText: 'Search here...',
                        ),
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FilterPage()));
                          ref
                              .read(categoryProvider.notifier)
                              .fetchCategoryDetails();
                          ref
                              .read(colorAndSizeProvider.notifier)
                              .fetchAllColorAndSize();
                          filterPage(context);
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: KColor.searchColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Image.asset(AssetPath.filterIcon,
                                  height: 24)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (shopState is LoadingState) ...[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "Loading ...",
                              style: KTextStyle.bodyText3
                                  .copyWith(color: KColor.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(
                              color: KColor.grey,
                            )
                          ],
                        ),
                      ],
                      if (shopState is ShopSuccessState) ...[
                        Expanded(
                          child: shopData!.isEmpty
                              ? const Center(child: Text('No products found!'))
                              : SingleChildScrollView(
                                  child: GridView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3.0,
                                      mainAxisSpacing: 6.0,
                                      childAspectRatio: 7 / 10,
                                    ),
                                    itemCount: shopData.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                          img: shopData[index].productImage,
                                          name: shopData[index].productName,
                                          genre: shopData[index]
                                              .allgroup
                                              .groupName
                                              .toString()
                                              .split('.')
                                              .last,
                                          offerPrice: shopData[index]
                                              .sellingPrice
                                              .toString(),
                                          regularPrice: "",
                                          discount: shopData[index]
                                              .discount
                                              .toString(),
                                          check: false,
                                          tap: () {
                                            ref
                                                .read(productDetailsProvider
                                                    .notifier)
                                                .fetchProductsDetails(
                                                    shopData[index].id);

                                            Navigator.pushNamed(
                                              context,
                                              '/productDetails',
                                              arguments: {
                                                'productName':
                                                    shopData[index].productName,
                                                'productGroup': shopData[index]
                                                    .allgroup
                                                    .groupName
                                                    .toString()
                                                    .split('.')
                                                    .last,
                                                'price': shopData[index]
                                                    .sellingPrice
                                                    .toString(),
                                                'description': shopData[index]
                                                    .briefDescription,
                                                'id': shopData[index].id,
                                              },
                                            );
                                            ref
                                                .read(productDetailsProvider
                                                    .notifier)
                                                .fetchProductsDetails(
                                                    shopData[index].id);
                                          },
                                          pressed: () {
                                            if (wishlistState
                                                is! LoadingState) {
                                              ref
                                                  .read(
                                                      wishlistProvider.notifier)
                                                  .addWishlist(
                                                      id: shopData[index]
                                                          .id
                                                          .toString());
                                            }
                                            ref
                                                .read(wishlistProvider.notifier)
                                                .fetchWishlistProducts();
                                          });
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _categoryHeader(title, tap) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
            ),
            InkWell(
              onTap: tap,
              child: Text(
                'Reset',
                style: KTextStyle.bodyText3.copyWith(
                  color: KColor.baseBlack.withOpacity(0.3),
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