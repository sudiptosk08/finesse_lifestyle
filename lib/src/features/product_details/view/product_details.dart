import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/cart/controller/cart_controller.dart';
import 'package:finesse/src/features/cart/state/cart_state.dart';
import 'package:finesse/src/features/main_screen.dart';
import 'package:finesse/src/features/product_details/components/add_to_cart.dart';
import 'package:finesse/src/features/product_details/components/product_info.dart';
import 'package:finesse/src/features/product_details/components/product_preview.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/product_details/state/product_details_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../auth/login/model/user_model.dart';
import '../../cart/controller/discount_controller.dart';
import '../../cart/controller/zone_controller.dart';
import '../../checkout/controller/address_controller.dart';
import '../../home/controllers/menu_data_controller.dart';
import '../../home/state/menu_data_state.dart';

class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  List<String> items = ["Variations", "Descriptions", "Reviews"];
  int currentIndex = 0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    ref.read(cartProvider.notifier).productVariationDetails = null;
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartItemsLength =
        cartState is CartSuccessState ? cartState.cartList.length : 0;
    final menuData = ref.watch(menuDataProvider);
    User? user =
        menuData is MenuDataSuccessState ? menuData.menuList!.user : null;
    final productDetailsState = ref.watch(productDetailsProvider);
    final productDetails = productDetailsState is ProductDetailsSuccessState
        ? productDetailsState.productDetailsModel!.product
        : null;
    return Scaffold(
      backgroundColor: KColor.whiteBackground,
      appBar: AppBar(
        backgroundColor: KColor.cirColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 24, color: KColor.blackbg),
        ),
        actions: [
          InkWell(
            onTap: () {
              ref.read(discountProvider.notifier).makeDiscountNull();
              ref.read(cartProvider.notifier).cartDetails();
              ref.read(addressProvider.notifier).setLocationNameOnce(user);
              ref.read(cityProvider.notifier).allCity();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            pageIndex: 1,
                          )));
            },
            child: SizedBox(
              width: context.screenWidth * 0.2,
              child: Stack(
                children: [
                  Center(child: SvgPicture.asset(AssetPath.cartIcon)),
                  Positioned(
                    right: 18,
                    top: 8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: KColor.stickerColor,
                      child: cartState is CartSuccessState
                          ? Text(
                              cartItemsLength > 10 ? '9+' : '$cartItemsLength',
                              textAlign: TextAlign.center,
                              style: KTextStyle.caption2.copyWith(
                                  color: KColor.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : getBoolAsync(isLoggedIn) == false
                              ? Text(
                                  "0",
                                  textAlign: TextAlign.center,
                                  style: KTextStyle.caption2.copyWith(
                                      color: KColor.white,
                                      fontWeight: FontWeight.bold),
                                )
                              : const CupertinoActivityIndicator(radius: 6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ProductPreview(
              id: productDetails != null ? productDetails.id.toString() : "0"),
          ProductInfo(
              productName:
                  productDetails != null ? productDetails.productName : "",
              productGroup:
                  productDetails != null ? productDetails.subcategory : "",
              price: productDetails != null
                  ? productDetails.sellingPrice.toString()
                  : "",
              description:
                  productDetails != null ? productDetails.briefDescription : "",
              id:productDetails != null ? productDetails.id.toString() : "",
              userId: userId),
          AddToCart(
            quantity: quantity,
            add: () {
              setState(() {
                quantity++;
              });
            },
            remove: () {
              setState(() {
                quantity--;
                if (quantity < 0) {
                  quantity = 0;
                }
              });
            },
            cart: () {
              if (!getBoolAsync(isLoggedIn)) {
                toast('Please login to continue...', bgColor: KColor.red);
                Navigator.pushNamed(context, '/login');
              }
              if (cartState is! LoadingState) {
                ref.read(cartProvider.notifier).addCart(quantity: quantity);
              }
            },
          ),
        ],
      ),
    );
  }
}
