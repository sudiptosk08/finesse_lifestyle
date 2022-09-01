import 'package:finesse/components/card/product_card.dart';
import 'package:finesse/src/features/home/controllers/product_category_controller.dart';
import 'package:finesse/src/features/home/models/products_category_model.dart';
import 'package:finesse/src/features/home/state/product_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class NewArrivals extends StatefulWidget {
  const NewArrivals({Key? key}) : super(key: key);

  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final newArrivalState = ref.watch(productCategoryProvider);
      final List<Product>? newCategory =
          newArrivalState is ProductCategorySuccessState
              ? newArrivalState.productsCategory?.newProducts
              : [];
      final List<MiddlePromotionalCard>? promotionalBanner =
          newArrivalState is ProductCategorySuccessState
              ? newArrivalState.productsCategory?.middlePromotionalCard
              : [];

      return Column(
        children: [
          SizedBox(
            //padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            height: 222,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newCategory!.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  img: newCategory[index].productImage,
                  name: newCategory[index].productName,
                  genre: newCategory[index].allgroup.groupName,
                  offerPrice: newCategory[index].sellingPrice.toString(),
                  regularPrice: "",
                  discount: newCategory[index].discount.toString(),
                  check: true,
                  tap: (){
                    Navigator.pushNamed(
                      context,
                      '/productDetails',
                      arguments: {
                        'productName': newCategory[index].productName,
                        'productGroup': newCategory[index].allgroup.groupName,
                        'price': newCategory[index].sellingPrice.toString(),
                        'id': newCategory[index].id.toString(),
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Column(
            children: [
              SizedBox(
                height: 240,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: promotionalBanner!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Image.network(
                        promotionalBanner[index].image.toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}