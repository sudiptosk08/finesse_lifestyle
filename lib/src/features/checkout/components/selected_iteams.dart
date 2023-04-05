import 'package:finesse/components/shimmer/k_shimmer.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/model/cart_model.dart';
import 'package:finesse/src/features/cart/state/cart_state.dart';
import 'package:finesse/src/features/wishlist/view/empty_product_page.dart';
import 'package:finesse/styles/b_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectedItems extends StatefulWidget {
  const SelectedItems({Key? key}) : super(key: key);

  @override
  State<SelectedItems> createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final cartState = ref.watch(cartProvider);
        final List<CartModel> cartData =
            cartState is CartSuccessState ? cartState.cartList : [];
        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: KColor.filterDividerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Info',
                      style:
                          KTextStyle.subtitle1.copyWith(color: KColor.blackbg),
                    ),
                    SvgPicture.asset(AssetPath.editIcon),
                  ],
                ),
                const SizedBox(height: 12),
                if (cartState is LoadingState) ...[
                  const KLoading(shimmerHeight: 123)
                ],
                if (cartState is CartSuccessState) ...[
                  cartData.isEmpty
                      ? const EmptyProductPage(message: 'Your cart is empty')
                      : ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartData.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: context.screenWidth * .50,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      '${cartData[index].vproduct!.productName!}',
                                      style: KTextStyle.bodyText1.copyWith(
                                          color:
                                              KColor.blackbg.withOpacity(0.6)),
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    '(x${cartData[index].quantity})',
                                    style: KTextStyle.bodyText1.copyWith(
                                        color: KColor.blackbg.withOpacity(0.6)),
                                  ),
                                  Text(
                                    '\৳${cartData[index].vproduct?.sellingPrice}',
                                    style: KTextStyle.bodyText1.copyWith(
                                        color: KColor.blackbg.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            );
                          }),
                ]
              ],
            ));
        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       if (cartState is LoadingState) ...[const KLoading(shimmerHeight: 123)],
        //       if (cartState is CartSuccessState) ...[
        //         cartData.isEmpty
        //             ? const EmptyProductPage(message: 'Your cart is empty')
        //             : ListView.builder(
        //                 physics: const ScrollPhysics(),
        //                 shrinkWrap: true,
        //                 itemCount: cartData.length,
        //                 itemBuilder: (ctx, index) {
        //                   return WishlistCard(
        //                     img: cartData[index].mproduct?.productImage,
        //                     productId: cartData[index].id,
        //                     isChecked: false,
        //                     productName: '${cartData[index].vproduct!.productName!}${cartData[index].vproduct?.variationformat?.values}',
        //                     price: cartData[index].vproduct?.sellingPrice,
        //                     quantity: cartData[index].quantity,
        //                     cancel: () {
        //                       setState(() {
        //                         Navigator.pop(context);
        //                       });
        //                     },
        //                     delete: () {
        //                       if (cartState is! LoadingState) {
        //                         ref.read(cartProvider.notifier).deleteCart(id: cartData[index].id.toString(),

        //                         );
        //                       }
        //                       Navigator.pop(context);
        //                     },
        //                   );
        //                 },
        //               ),
        //       ],
        //       SizedBox(height: context.screenHeight * 0.04),
        //     ],
        //   );
      },
    );
  }
}


      // ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: 2,
      //       itemBuilder: (context, index) {
      //         return Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 'Hanging Clock (x2)',
      //                 style: KTextStyle.bodyText1
      //                     .copyWith(color: KColor.blackbg.withOpacity(0.6)),
      //               ),
      //               Text(
      //                 '\$44.90',
      //                 style: KTextStyle.bodyText1
      //                     .copyWith(color: KColor.blackbg.withOpacity(0.6)),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     ),
