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
                  // Expanded(
                  //   child: shopData!.isEmpty
                  //       ? const Center(child: Text('No products found!'))
                  //       : SingleChildScrollView(
                  //           child: GridView.builder(
                  //             physics: const ScrollPhysics(),
                  //             shrinkWrap: true,
                  //             gridDelegate:
                  //                 const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 2,
                  //               crossAxisSpacing: 3.0,
                  //               mainAxisSpacing: 6.0,
                  //               childAspectRatio: 7 / 10,
                  //             ),
                  //             itemCount: shopData.length,
                  //             scrollDirection: Axis.vertical,
                  //             itemBuilder: (context, index) {
                  //               return ProductCard(
                  //                   img: shopData[index].productImage,
                  //                   name: shopData[index].productName,
                  //                   genre: shopData[index]
                  //                       .allgroup
                  //                       .groupName
                  //                       .toString()
                  //                       .split('.')
                  //                       .last,
                  //                   offerPrice:
                  //                       shopData[index].sellingPrice.toString(),
                  //                   regularPrice: "",
                  //                   discount:
                  //                       shopData[index].discount.toString(),
                  //                   check: false,
                  //                   tap: () {
                  //                     ref
                  //                         .read(productDetailsProvider.notifier)
                  //                         .fetchProductsDetails(
                  //                             shopData[index].id);

                  //                     Navigator.pushNamed(
                  //                       context,
                  //                       '/productDetails',
                  //                       arguments: {
                  //                         'productName':
                  //                             shopData[index].productName,
                  //                         'productGroup': shopData[index]
                  //                             .allgroup
                  //                             .groupName
                  //                             .toString()
                  //                             .split('.')
                  //                             .last,
                  //                         'price': shopData[index]
                  //                             .sellingPrice
                  //                             .toString(),
                  //                         'description':
                  //                             shopData[index].briefDescription,
                  //                         'id': shopData[index].id,
                  //                       },
                  //                     );
                  //                     ref
                  //                         .read(productDetailsProvider.notifier)
                  //                         .fetchProductsDetails(
                  //                             shopData[index].id);
                  //                   },
                  //                   pressed: () {
                  //                     if (wishlistState is! LoadingState) {
                  //                       ref
                  //                           .read(wishlistProvider.notifier)
                  //                           .addWishlist(
                  //                               id: shopData[index]
                  //                                   .id
                  //                                   .toString());
                  //                     }
                  //                     ref
                  //                         .read(wishlistProvider.notifier)
                  //                         .fetchWishlistProducts();
                  //                   });
                  //             },
                  //           ),
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // filterPage() {

  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  //           child: Column(
  //             children: [
  //               SvgPicture.asset(AssetPath.cancelIcon),
  //               const SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     'Filters',
  //                     style: KTextStyle.headline3.copyWith(
  //                       color: KColor.blackbg,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     icon: const Icon(
  //                       Icons.close,
  //                       color: KColor.blackbg,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //           child: Divider(
  //             color: KColor.dividerColor.withOpacity(0.5),
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Column(
  //             children: [
  //               _categoryHeader('Main categories', () {}),
  //               const MainCategory(),
  //               _categoryHeader('View', () {}),
  //               const View(),
  //               _categoryHeader('Price range', () {}),
  //               const PriceRange(),
  //               _categoryHeader('Rating', () {}),
  //               const Rating(),
  //               _categoryHeader('Category', () {}),
  //               const OtherCategory(),
  //               _categoryHeader('Color', () {}),
  //               const SelectColor(),
  //               Row(
  //                 children: [
  //                   Flexible(
  //                     child: KBorderButton(
  //                       title: 'Reset All',
  //                       onTap: () {},
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Flexible(
  //                     child: KButton(
  //                       title: 'Add Filters',
  //                       onTap: () {},
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 36),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

// filterPage(context) {
//   var _chosenValue;
//   var _chosenValue2;
//   var _locationChosenValue3;
//   var dollarChosenValue;
//   return showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, setState) {
//             return Container(
//               height: KSize.getHeight(context, 708),
//               decoration: BoxDecoration(
//                   color: KColor.grey,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(50),
//                       topRight: Radius.circular(50))),
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: KSize.getWidth(context, 20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: KSize.getHeight(context, 10)),
//                       Center(
//                         child: Image.asset(
//                           'assets/images/bottomSheet.png',
//                           height: KSize.getHeight(context, 4),
//                           width: KSize.getWidth(context, 80),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 25)),

//                       /// Set Filters
//                       Center(
//                         child: Text(
//                           'Set Filters',
//                           style: KTextStyle.headline6
//                               .copyWith(fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 20)),
//                       Text('Category', style: KTextStyle.subtitle7),
//                       SizedBox(height: KSize.getHeight(context, 15)),

//                       ///  Category Dropdown
//                       Container(
//                         height: KSize.getHeight(context, 50),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: KColor.white),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: KSize.getWidth(context, 20)),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               value: _chosenValue,
//                               //elevation: 5,
//                               style: TextStyle(color: KColor.primary),
//                               items: <String>[
//                                 'UI/UX Design',
//                                 'Product Design',
//                                 'Visual Design',
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(
//                                     value,
//                                     style: GoogleFonts.inter(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: KColor.grey350),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   _chosenValue = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 15)),
//                       Text('Sub Category', style: KTextStyle.subtitle7),
//                       SizedBox(height: KSize.getHeight(context, 15)),

//                       /// Sub Category Dropdown
//                       Container(
//                         height: KSize.getHeight(context, 50),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: KColor.white),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: KSize.getWidth(context, 20)),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               value: _chosenValue2,
//                               style: TextStyle(color: KColor.primary),
//                               items: <String>[
//                                 'Graphics Design',
//                                 'Product Design',
//                                 'Visual Design',
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value,
//                                       style: KTextStyle.bodyText1
//                                           .copyWith(color: KColor.grey350)),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   _chosenValue2 = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 15)),

//                       /// Location .... Salary

//                       Text('Colors', style: KTextStyle.subtitle7),
//                       SizedBox(height: KSize.getHeight(context, 15)),

//                       /// Sub Category Dropdown
//                       Container(
//                         height: KSize.getHeight(context, 50),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: KColor.white),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: KSize.getWidth(context, 20)),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               icon: Icon(Icons.keyboard_arrow_down),
//                               value: _chosenValue2,
//                               style: TextStyle(color: KColor.primary),
//                               items: <String>[
//                                 'Graphics Design',
//                                 'Product Design',
//                                 'Visual Design',
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value,
//                                       style: KTextStyle.bodyText1
//                                           .copyWith(color: KColor.grey350)),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   _chosenValue2 = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 15)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Size', style: KTextStyle.subtitle7),
//                               SizedBox(height: KSize.getHeight(context, 16)),
//                               Container(
//                                 height: KSize.getHeight(context, 50),
//                                 width: KSize.getWidth(context, 160),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: KColor.white),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: KSize.getWidth(context, 10)),
//                                   child: Row(
//                                     children: [
//                                       // Image.asset('assets/images/location.png',
//                                       //     fit: BoxFit.cover,
//                                       //     height: KSize.getHeight(context, 20),
//                                       //     width: KSize.getWidth(context, 20)),
//                                       SizedBox(
//                                           width: KSize.getWidth(context, 15)),
//                                       DropdownButtonHideUnderline(
//                                         child: DropdownButton<String>(
//                                           icon: Icon(Icons.keyboard_arrow_down),
//                                           value: _locationChosenValue3,
//                                           style:
//                                               TextStyle(color: KColor.primary),
//                                           items: <String>[
//                                             'Canada',
//                                             'Nepal',
//                                             'India',
//                                           ].map<DropdownMenuItem<String>>(
//                                               (String value) {
//                                             return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     right: KSize.getWidth(
//                                                         context, 15.0)),
//                                                 child: Text(value,
//                                                     style: KTextStyle.bodyText1
//                                                         .copyWith(
//                                                             color: KColor
//                                                                 .grey350)),
//                                               ),
//                                             );
//                                           }).toList(),
//                                           onChanged: (String? value) {
//                                             setState(() {
//                                               _locationChosenValue3 = value;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Price', style: KTextStyle.subtitle7),
//                               SizedBox(height: KSize.getHeight(context, 16)),
//                               Container(
//                                 height: KSize.getHeight(context, 50),
//                                 width: KSize.getWidth(context, 160),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: KColor.white),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: KSize.getWidth(context, 10)),
//                                   child: Row(
//                                     children: [
//                                       // Image.asset('assets/images/wallet.png',
//                                       //     fit: BoxFit.cover,
//                                       //     //scale: 2.5,
//                                       //     height: KSize.getHeight(context, 20),
//                                       //     width: KSize.getWidth(context, 20)),
//                                       SizedBox(
//                                           width: KSize.getWidth(context, 15)),
//                                       DropdownButtonHideUnderline(
//                                         child: DropdownButton<String>(
//                                           icon: Icon(Icons.keyboard_arrow_down),
//                                           value: dollarChosenValue,
//                                           style:
//                                               TextStyle(color: KColor.primary),
//                                           items: <String>[
//                                             '\$2k-\$5k',
//                                             '\$5k-\$10k',
//                                             '\$7k-\$12k',
//                                           ].map<DropdownMenuItem<String>>(
//                                               (String value) {
//                                             return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     right: KSize.getWidth(
//                                                         context, 9.0)),
//                                                 child: Text(value,
//                                                     style: KTextStyle.bodyText1
//                                                         .copyWith(
//                                                             color: KColor
//                                                                 .grey350)),
//                                               ),
//                                             );
//                                           }).toList(),
//                                           onChanged: (String? value) {
//                                             setState(() {
//                                               dollarChosenValue = value;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 30)),

//                       /// Job Type
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Brand',
//                               style:
//                                   KTextStyle.headline6.copyWith(fontSize: 18)),
//                           Icon(Icons.more_horiz_sharp)
//                         ],
//                       ),
//                       SizedBox(height: KSize.getHeight(context, 20)),

//                       /// Job Type List
//                       Wrap(
//                         direction: Axis.horizontal,
//                         spacing: KSize.getWidth(context, 13),
//                         runSpacing: KSize.getHeight(context, 14),
//                         children: [
//                           CategoryList(
//                               index: 0,
//                               categoryList: 'Full Time',
//                               width: KSize.getWidth(context, 100)),
//                           CategoryList(
//                               index: 1,
//                               categoryList: 'Part Time',
//                               width: KSize.getWidth(context, 100)),
//                           CategoryList(
//                               index: 2,
//                               categoryList: 'Contract',
//                               width: KSize.getWidth(context, 95)),
//                           CategoryList(
//                               index: 3,
//                               categoryList: 'Freelance',
//                               width: KSize.getWidth(context, 100)),
//                           CategoryList(
//                               index: 4,
//                               categoryList: 'Remote',
//                               width: KSize.getWidth(context, 86)),
//                           CategoryList(
//                             categoryList: 'Show All Type',
//                             width: KSize.getWidth(context, 120),
//                             index: 5,
//                           )
//                         ],
//                       ),

//                       SizedBox(height: KSize.getHeight(context, 40)),
//                       KButton(
//                           title: 'Apply Filters',
//                           onTap: () {
//                             Navigator.pop(context);
//                           }),
//                       SizedBox(height: KSize.getHeight(context, 30)),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       });
// }


////
 