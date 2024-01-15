
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/filter/model/color_and_size_model.dart';
import 'package:finesse/src/features/home/controllers/category_controller.dart';
import 'package:finesse/src/features/home/controllers/shop_controller.dart';
import 'package:finesse/src/features/home/models/category_model.dart';
import 'package:finesse/src/features/home/state/category_state.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/product_details/model/all_branda.dart';
import 'package:finesse/src/features/product_details/state/product_details_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/button/k_button.dart';
import '../../../../styles/k_size.dart';

filterPage(context) {
  var _chosenCatValue; // category
  String? categoryId = '';
  String? subCatId = '';
  var _chosenColorValue; // colorvalue
  var dollarChosenValue;
  var _chosenSizeValue; // size
  String? priceString;
  String? brandId = '';
  List<Group> subCategoryData = [];
  List<String> brandIdList = [];
  String? selectSubCat = null; // subcategory

  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Consumer(builder: (contex, ref, child) {
              final brandState = ref.watch(allBrandsProvider);
              final colorAndSizeState = ref.watch(colorAndSizeProvider);
              List<Brand> allBrandData = brandState is AllBrandsSuccessState
                  ? brandState.brandModel!.brands
                  : [];
              // final categoryState = ref.watch(categoryProvider);
              // final List<Group>? categoryData =
              //     categoryState is CategorySuccessState
              //         ? categoryState.categoryModel?.groups
              //         : [];
              final categoryState = ref.watch(categoryProvider);
              final List<Group>? categoryData =
                  categoryState is CategorySuccessState
                      ? categoryState.categoryModel?.groups
                      : [];
              final List<ColorAndSize> colorData =
                  colorAndSizeState is AllColorAndSizeSuccessState
                      ? colorAndSizeState.colorAndSizeModel!.colors
                      : [];
              final List<ColorAndSize> sizeData =
                  colorAndSizeState is AllColorAndSizeSuccessState
                      ? colorAndSizeState.colorAndSizeModel!.sizes
                      : [];

              // print("list of subgategory ${subCategoryData.isEmpty? []: subCategoryData[0].category.length}");
              // final List<Category>? subCategoryData   = selectSubCat !=null?
              // categoryState is CategorySuccessState ? categoryState.categoryModel?.groups.where((element) => element.groupName == selectSubCat ).toList() : []: [] ;
              //  final List<OrderData>? orderList = orderState is FetchOrderSuccessState ? orderState.orderModel?.order.data.where((element) => (element.status == widget.OrderStatus)).toList() : [];
              return Container(
                height: KSize.getHeight(context, 708),
                decoration: const BoxDecoration(
                    color: KColor.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: KSize.getWidth(context, 20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: KSize.getHeight(context, 10)),
                        Center(
                          child: Image.asset(
                            'assets/images/bottomSheet.png',
                            height: KSize.getHeight(context, 4),
                            width: KSize.getWidth(context, 80),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: KSize.getHeight(context, 25)),

                        /// Set Filters
                        Center(
                          child: Text(
                            'Set Filters',
                            style: KTextStyle.headline6
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: KSize.getHeight(context, 20)),
                        Text('Category', style: KTextStyle.subtitle7),
                        SizedBox(height: KSize.getHeight(context, 15)),

                        ///  Category Dropdown
                        Container(
                          height: KSize.getHeight(context, 50),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: KColor.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: KSize.getWidth(context, 20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (categoryState is LoadingState) ...{
                                  const Center(
                                      child: CupertinoActivityIndicator()),
                                },
                                if (categoryState is CategorySuccessState) ...{
                                  DropdownButtonHideUnderline(
                                      child: SizedBox(
                                    height: KSize.getHeight(context, 50),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      hint: const Text("Category"),
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      value: _chosenCatValue,
                                      //elevation: 5,
                                      // style: TextStyle(color: KColor.primary),
                                      items: categoryData!
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: e.groupName,
                                          child: Text(
                                            e.groupName.toString(),
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: KColor.grey350),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _chosenCatValue = value;
                                          selectSubCat = null;
                                          categoryId = categoryData
                                              .where((element) =>
                                                  element.groupName == value)
                                              .first
                                              .id
                                              .toString();
                                          subCategoryData = [];

                                          subCategoryData = categoryData
                                              .where((element) =>
                                                  element.groupName == value)
                                              .toList();
                                          print(
                                              "subcategory data is : $subCategoryData");
                                        });
                                      },
                                    ),
                                  ))
                                }
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: KSize.getHeight(context, 15)),

                        if (subCategoryData.isNotEmpty) ...{
                          Text('Sub Category', style: KTextStyle.subtitle7),
                          SizedBox(height: KSize.getHeight(context, 15)),
                        },

                        // /// Sub Category Dropdown
                        if (subCategoryData.isNotEmpty) ...{
                          Container(
                            height: KSize.getHeight(context, 50),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: KColor.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: KSize.getWidth(context, 20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (categoryState is LoadingState) ...{
                                    const Center(
                                        child: CupertinoActivityIndicator()),
                                  },
                                  if (subCategoryData.isNotEmpty) ...{
                                    DropdownButtonHideUnderline(
                                      child: SizedBox(
                                        height: KSize.getHeight(context, 50),
                                        child: DropdownButton<String>(
                                          alignment: Alignment.center,
                                          hint: const Text("Sub-Category"),
                                          isExpanded: true,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          value: selectSubCat,
                                          //elevation: 5,
                                          style: const TextStyle(
                                              color: KColor.primary),
                                          items: subCategoryData.isEmpty
                                              ? []
                                              : subCategoryData[0].category.map<
                                                      DropdownMenuItem<String>>(
                                                  (e) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    alignment: Alignment.center,
                                                    value: e.catName,
                                                    child: Text(
                                                      e.catName.toString(),
                                                      style: GoogleFonts.inter(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              KColor.grey350),
                                                    ),
                                                  );
                                                }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectSubCat = value;
                                              subCatId = subCategoryData[0]
                                                  .category
                                                  .where((element) =>
                                                      element.catName == value)
                                                  .first
                                                  .id
                                                  .toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ),
                        },
                        SizedBox(height: KSize.getHeight(context, 15)),

                        /// Location .... Salary

                        Text('Price', style: KTextStyle.subtitle7),
                        SizedBox(height: KSize.getHeight(context, 15)),

                        // / colors Dropdown
                        Container(
                          height: KSize.getHeight(context, 50),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: KColor.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: KSize.getWidth(context, 20)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset('assets/images/wallet.png',
                                //     fit: BoxFit.cover,
                                //     //scale: 2.5,
                                //     height: KSize.getHeight(context, 20),
                                //     width: KSize.getWidth(context, 20)),
                                // SizedBox(
                                //     width: KSize.getWidth(context, 17)),
                                DropdownButtonHideUnderline(
                                  child: SizedBox(
                                    height: KSize.getHeight(context, 50),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      hint: const Text("Price"),
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      value: dollarChosenValue,
                                      style: const TextStyle(color: KColor.primary),
                                      items: <String>[
                                        '৳500 - ৳1000',
                                        '৳500 - ৳5000',
                                        '৳5000 - ৳10000',
                                        '৳10000 - ৳20000',
                                        '৳20000 - ৳50000',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: value,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: KSize.getWidth(
                                                    context, 6.0)),
                                            child: Text(value,
                                                style: KTextStyle.bodyText3
                                                    .copyWith(
                                                        color: KColor.grey350)),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          if (value != null) {
                                            priceString =
                                                value.replaceAll('৳', '');
                                            priceString = priceString!
                                                .replaceAll('-', ',');
                                            priceString = priceString!
                                                .replaceAll(' ', '');
                                          }

                                          dollarChosenValue = value;
                                          print("price is :$priceString");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: KSize.getHeight(context, 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Size', style: KTextStyle.subtitle7),
                                SizedBox(height: KSize.getHeight(context, 16)),
                                Container(
                                  height: KSize.getHeight(context, 50),
                                  width: KSize.getWidth(context, 160),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: KColor.white),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            KSize.getWidth(context, 10)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (colorAndSizeState
                                            is LoadingState) ...{
                                          const Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                        },
                                        if (colorAndSizeState
                                            is AllColorAndSizeSuccessState) ...{
                                          DropdownButtonHideUnderline(
                                              child: SizedBox(
                                            height:
                                                KSize.getHeight(context, 50),
                                            child: DropdownButton<String>(
                                              alignment: Alignment.center,
                                              hint: const Text("Size"),
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: _chosenSizeValue,
                                              //elevation: 5,
                                              style: const TextStyle(
                                                  color: KColor.primary),
                                              items: sizeData.isEmpty
                                                  ? []
                                                  : sizeData.map<
                                                      DropdownMenuItem<
                                                          String>>((e) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        alignment:
                                                            Alignment.center,
                                                        value: e.value,
                                                        child: Text(
                                                          e.value.toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: KColor
                                                                      .grey350),
                                                        ),
                                                      );
                                                    }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _chosenSizeValue = value;
                                                });
                                              },
                                            ),
                                          ))
                                         
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Color', style: KTextStyle.subtitle7),
                                SizedBox(height: KSize.getHeight(context, 16)),
                                Container(
                                  height: KSize.getHeight(context, 50),
                                  width: KSize.getWidth(context, 160),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: KColor.white),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            KSize.getWidth(context, 20)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (colorAndSizeState
                                            is LoadingState) ...{
                                          const Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                        },
                                        if (colorAndSizeState
                                            is AllColorAndSizeSuccessState) ...{
                                          DropdownButtonHideUnderline(
                                              child: SizedBox(
                                            height:
                                                KSize.getHeight(context, 50),
                                            child: DropdownButton<String>(
                                              alignment: Alignment.center,
                                              hint: const Text("Color"),
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              value: _chosenColorValue,
                                              // elevation: 5,
                                              style: const TextStyle(
                                                  color: KColor.primary),
                                              items: colorData.isEmpty
                                                  ? []
                                                  : colorData.map<
                                                      DropdownMenuItem<
                                                          String>>((e) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        alignment:
                                                            Alignment.center,
                                                        value: e.value,
                                                        child: Text(
                                                          e.value.toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: KColor
                                                                      .grey350),
                                                        ),
                                                      );
                                                    }).toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _chosenColorValue = value;
                                                });
                                              },
                                            ),
                                          ))

                                          // DropdownButtonHideUnderline(
                                          //   child: DropdownButton<String>(  isExpanded: true,
                                          //     icon: Icon(Icons.keyboard_arrow_down),
                                          //     value: _chosenColorValue,
                                          //     style: TextStyle(color: KColor.primary),
                                          //     items: colorData!.isEmpty
                                          //         ? []
                                          //         : colorData
                                          //             .map<DropdownMenuItem<String>>(
                                          //                 (e) {
                                          //             return DropdownMenuItem<String>(alignment: Alignment.center,
                                          //               value: e.value,
                                          //               child: Text(e.value!,
                                          //                   style: KTextStyle.bodyText1
                                          //                       .copyWith(
                                          //                           color: KColor
                                          //                               .grey350)),
                                          //             );
                                          //           }).toList(),
                                          //     onChanged: (String? value) {
                                          //       setState(() {
                                          //         _chosenColorValue = value;
                                          //       });
                                          //     },
                                          //   ),
                                          // ),
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: KSize.getHeight(context, 30)),

                        /// Job Type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Brand',
                                style: KTextStyle.headline6
                                    .copyWith(fontSize: 18)),
                            const Icon(Icons.more_horiz_sharp)
                          ],
                        ),
                        SizedBox(height: KSize.getHeight(context, 20)),

                        // /// all brands
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: KSize.getWidth(context, 13),
                          runSpacing: KSize.getHeight(context, 14),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                    //s: 5.0,
                                    // runSpacing: 3.0,
                                    spacing: 7,
                                    runSpacing: 4,
                                    children: List.generate(
                                        allBrandData.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (brandIdList.contains(
                                                      allBrandData[index]
                                                          .id
                                                          .toString())) {
                                                    brandIdList.removeWhere(
                                                        (element) =>
                                                            element ==
                                                            allBrandData[
                                                                    index]
                                                                .id
                                                                .toString());
                                                  } else {
                                                    brandIdList.add(
                                                        allBrandData[index]
                                                            .id
                                                            .toString());
                                                  }
                                                  brandId =
                                                      brandIdList.join(",");
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 4,
                                                        top: 5,
                                                        bottom: 5,
                                                        right: 4),
                                                margin:
                                                    const EdgeInsets.only(
                                                        top: 2.5,
                                                        bottom: 2.5,
                                                        right: 2.5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: brandIdList.contains(
                                                          allBrandData[
                                                                  index]
                                                              .id
                                                              .toString())
                                                      ? Colors.black
                                                      : KColor.white,
                                                ),
                                                child: Text(
                                                  allBrandData[index]
                                                      .name
                                                      .toString(),
                                                  style: KTextStyle
                                                      .bodyText1
                                                      .copyWith(
                                                          color:
                                                              KColor.grey,
                                                          fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                ),
                                              ),
                                            ))),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: KSize.getHeight(context, 40)),
                        KButton(
                            title: 'Apply Filters',
                            onTap: () {
                              // String brandId =brandIdList.isNotEmpty ? brandIdList.join(","): '';

                              ref
                                  .read(shopProvider.notifier)
                                  .fetchShopProductList(
                                      str: "",
                                      groupId: categoryId,
                                      categoryId: subCatId,
                                      brandId: brandId,
                                      price: priceString,
                                      color: _chosenColorValue,
                                      size: _chosenSizeValue);
                              //         ref.read(shopProvider.notifier).fetchShopProductList(groupId: categoryId,
                              // categoryId: "",
                              // str: "");
                              Navigator.pop(context);
                            }),
                        SizedBox(height: KSize.getHeight(context, 30)),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        );
      });
}
