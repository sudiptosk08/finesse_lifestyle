import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/src/features/profile/components/tab/all_order.dart';
import 'package:finesse/src/features/profile/components/tab/specific_order.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
//     return Scaffold(
    // backgroundColor: KColor.appBackground,
    // appBar: const PreferredSize(
    //   preferredSize: Size.fromHeight(56),
    //   child: KAppBar(checkTitle: true, title: 'My Orders'),
    // ),
//       body: DefaultTabController(
//         length: 5,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 children: [
//                   Divider(
//                     color: KColor.baseBlack.withOpacity(0.1),
//                     thickness: 1,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: TabBar(
//                       indicatorColor: Colors.transparent,
//                       unselectedLabelColor: KColor.blackbg.withOpacity(0.5),
//                       labelStyle: KTextStyle.bodyText1,
//                       labelColor: KColor.blackbg,
//                       isScrollable: true,
//                       labelPadding: const EdgeInsets.only(right: 24),
//                       tabs: const [
//                         Tab(
//                           text: 'All',
//                         ),
//                         Tab(
//                           text: 'Order Placed',
//                         ),
//                         Tab(
//                           text: 'Processing',
//                         ),
//                         Tab(
//                           text: 'Shipped',
//                         ),
//                         Tab(
//                           text: 'Delivered',
//                         ),
//                       ],
//                       indicatorSize: TabBarIndicatorSize.tab,
//                     ),
//                   ),
//                   Divider(
//                     color: KColor.baseBlack.withOpacity(0.1),
//                     thickness: 1,
//                   ),
//                 ],
//               ),
//             ),
//             // SizedBox(height: context.screenHeight * 0.01),
//             const Expanded(
//               child: TabBarView(
//                 children: [
//                   AllOrder(),
//                   SpecificOrder(OrderStatus: "Order Placed"),
//                   SpecificOrder(OrderStatus: "Processing"),
//                   SpecificOrder(OrderStatus: "Shipped"),
//                   SpecificOrder(OrderStatus: "Delivered"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
    TabController _tabController = TabController(vsync: this, length: 5);
    int _activeIndex = 0;
    int loadingIndex = 1;
    int storeIndex = 0;

    @override
    void initState() {
      super.initState();

      _tabController.addListener(onTabChange);
    }

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: KColor.appBackground,
          body: NestedScrollView(
              body: TabBarView(controller: _tabController, children: [
                RefreshIndicator(
                    onRefresh: () async {
                      // context.read(myMatchLiveProvider).getMyMatchLiveList();
                    },
                    child: AllOrder()),
                RefreshIndicator(
                    onRefresh: () async {},
                    child: SpecificOrder(
                      OrderStatus: 'Order Placed',
                    )),
                RefreshIndicator(
                    onRefresh: () async {
                      // context
                      //     .read(myMatchRecentProvider)
                      //     .getMyMatchRecentList();
                    },
                    child: SpecificOrder(
                      OrderStatus: 'Processing',
                    )),
                RefreshIndicator(
                    onRefresh: () async {
                      // context
                      //     .read(myMatchRecentProvider)
                      //     .getMyMatchRecentList();
                    },
                    child: SpecificOrder(
                      OrderStatus: 'Shipped',
                    )),
                RefreshIndicator(
                    onRefresh: () async {
                      // context
                      //     .read(myMatchRecentProvider)
                      //     .getMyMatchRecentList();
                    },
                    child: SpecificOrder(
                      OrderStatus: 'Delivered',
                    )),
              ]),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    titleSpacing: 0,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: KColor.blackbg,
                      ),
                    ),
                    backgroundColor: KColor.appBackground,
                    floating: false,
                    pinned: true,
                    snap: false,
                    forceElevated: true,
                    centerTitle: true,
                    elevation: 1,
                    expandedHeight: 100.0,
                    title: Text(
                      "My Order",
                      style:
                          KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 56),
                      child: ColoredBox(
                        color: KColor.appBackground,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: KColor.grey.withOpacity(0.5),
                                      width: 1))),
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            controller: _tabController,
                            physics: BouncingScrollPhysics(),
                            indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelStyle: KTextStyle.bodyText1,
                            indicatorColor: Colors.transparent,
                            unselectedLabelColor: KColor.grey,
                            labelStyle: KTextStyle.bodyText1,
                            labelColor: KColor.blackbg,
                            isScrollable: true,
                            tabs: const [
                              Tab(
                                text: "All",
                              ),
                              Tab(text: "Order Placed"),
                              Tab(text: "Processing"),
                              Tab(text: "Shipped"),
                              Tab(text: "Delivered"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              })),
    );
  }

  void onTabChange() {
    // if (_tabController.index != _tabController.previousIndex) {
    //   // if (_tabController.indexIsChanging) {
    //   print('index = ${_tabController.index}');

    //   if (!mounted) return;
    //   setState(() {
    //     _activeIndex = _tabController.index;

    //     if (storeIndex == _tabController.index) {
    //       loadingIndex++;
    //     } else {
    //       loadingIndex = 0;
    //     }
    //   });
    //   if (loadingIndex == 0) {
    //     if (_activeIndex == 0) {
    //       // context.read(myMatchLiveProvider).getMyMatchLiveList();
    //     } else if (_activeIndex == 1) {
    //       // context.read(myMatchUpcomingProvider).getMyMatchUpcomingList();
    //     } else {
    //       // context.read(myMatchRecentProvider).getMyMatchRecentList();
    //     }
    //     storeIndex = _tabController.index;
    //   }
    // }
  }
}
