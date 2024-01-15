
// ignore_for_file: non_constant_identifier_names

import 'package:finesse/components/card/my_order_card.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/profile/components/order_details.dart';
import 'package:finesse/src/features/profile/controller/profile_controller.dart';
import 'package:finesse/src/features/profile/model/order_model.dart';
import 'package:finesse/src/features/profile/state/profile_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class SpecificOrder extends StatefulWidget {
  final String OrderStatus;
  const SpecificOrder({super.key,required this.OrderStatus });

  @override
  State<SpecificOrder> createState() => _SpecificOrderState();
}

class _SpecificOrderState extends State<SpecificOrder> {
 @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final orderState = ref.watch(orderProvider);
        //  final List<Datum>? wishlistData = wishlistProductsState is WishlistSuccessState ? wishlistProductsState.wishlistModel?.wishlist.data : [];

        final List<Datum>? orderList = orderState is FetchOrderSuccessState
            ? orderState.orderModel?.order.data
                .where((element) => (element.status == widget.OrderStatus))
                .toList()
            : [];
        print("using -----index where");
        if (orderList!.isNotEmpty) {
          print(orderList
              .where((element) => element.status == "Canceled")
              .length);
        }
        print("using index where");
        return Container(
          margin:const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: ListView(
            physics:const BouncingScrollPhysics(),
            children: [
              if (orderState is LoadingState) ...[
                const Center(
                  child: CircularProgressIndicator(
                    color: KColor.black,
                    strokeWidth: 1,
                  ),
                ),
              ],
              if (orderState is FetchOrderSuccessState) ...[
                orderList.isEmpty
                    ? const Center(child: Text("no order found"))
                    : Column(
                        children: List.generate(
                          (orderList.length),
                          (index) {
                            print(orderList[index]);
                            return Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                extentRatio: 0.85,
                                dismissible: DismissiblePane(
                                  onDismissed: () async {},
                                ),
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (index) {},
                                    backgroundColor: KColor.deleteColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_outline_outlined,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed('/orderDetails', arguments: orderList[index] );
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    OrderDetails(
                                                        orderData:
                                                            orderList[index])));
                                      },
                                      child: MyOrderCard(
                                          isChecked: true,
                                          id: orderList[index].id.toString(),
                                          date: orderList[index]
                                              .createdAt
                                              .toString(),
                                          userName:
                                              orderList[index].name.toString(),
                                          contract: orderList[index]
                                              .contact
                                              .toString(),
                                          grandTotal: orderList[index]
                                              .grandTotal
                                              .toString(),
                                          paymentType:
                                              orderList[index].paymentType,
                                          status: orderList[index].status)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 30),
              ]
            ],
          ),
        );
      },
    );
  }
}
