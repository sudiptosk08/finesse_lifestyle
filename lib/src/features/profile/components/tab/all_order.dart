// import 'package:finesse/components/card/my_order_card.dart';
// import 'package:finesse/components/shimmer/k_shimmer.dart';
// import 'package:finesse/core/base/base_state.dart';
// import 'package:finesse/src/features/profile/components/order_details.dart';
// import 'package:finesse/src/features/profile/controller/profile_controller.dart';
// import 'package:finesse/src/features/profile/model/order_model.dart';
// import 'package:finesse/src/features/profile/state/profile_state.dart';
// import 'package:finesse/styles/k_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class AllOrder extends StatefulWidget {
//   const AllOrder({Key? key}) : super(key: key);

//   @override
//   State<AllOrder> createState() => _AllOrderState();
// }

// class _AllOrderState extends State<AllOrder> {
//   @override
//   Widget build(BuildContext contzext) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final orderState = ref.watch(orderProvider);
//         //  final List<Datum>? wishlistData = wishlistProductsState is WishlistSuccessState ? wishlistProductsState.wishlistModel?.wishlist.data : [];

//         final List<OrderData>? orderList = orderState is FetchOrderSuccessState
//             ? orderState.orderModel?.order.data
//             : [];
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
//           child: ListView(
//               physics: BouncingScrollPhysics(),
//           children: [
//           if (orderState is LoadingState) ...[
//             const Center(
//               child: CircularProgressIndicator(
//                 color: KColor.black,
//                 strokeWidth: 1,
//               ),
//             )
//           ],
//           if (orderState is FetchOrderSuccessState) ...[
//             orderList!.isEmpty
//                 ? Center(child: Text("no order found"))
//                 : Column(children: List.generate(
//                     (orderList.length) ,
//                     ( index) {
//                       print(orderList[index]);
//                       return Slidable(
//                         key: UniqueKey(),
//                         endActionPane: ActionPane(
//                           extentRatio: 0.85,
//                           dismissible: DismissiblePane(
//                             onDismissed: () async {},
//                           ),
//                           motion: const StretchMotion(),
//                           children: [
//                             SlidableAction(
//                               onPressed: (index) {},
//                               backgroundColor: KColor.deleteColor,
//                               foregroundColor: Colors.white,
//                               icon: Icons.delete_outline_outlined,
//                               borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(15.0),
//                                 bottomRight: Radius.circular(15.0),
//                               ),
//                             ),
//                           ],
//                         ),
//                         child: InkWell(
//                             onTap: () {
//                               // Navigator.of(context).pushNamed('/orderDetails', arguments: orderList[index] );
//                               Navigator.of(context).push(
//                                   CupertinoPageRoute(
//                                       builder: (context) =>
//                                           OrderDetails(
//                                               orderData:
//                                                   orderList[index])));
//                             },
//                             child: MyOrderCard(
//                                 isChecked: true,
//                                 id: orderList[index].id.toString(),
//                                 date: orderList[index]
//                                     .createdAt
//                                     .toString(),
//                                 userName:
//                                     orderList[index].name.toString(),
//                                 contract:
//                                     orderList[index].contact.toString(),
//                                 grandTotal: orderList[index]
//                                     .grandTotal
//                                     .toString(),
//                                 paymentType:
//                                     orderList[index].paymentType,
//                                 status: orderList[index].status)),
//                       );
//                     },
//                   ),),
//             const SizedBox(height: 30),
//           ]
//           ],
//           ),
//         );
//       },
//     );
//   }
// }
