import 'package:cached_network_image/cached_network_image.dart';
import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_border_btn.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/constants/asset_path.dart';
import 'package:finesse/src/features/profile/model/order_model.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetails extends StatefulWidget {
  final OrderData orderData ; 
  const OrderDetails({Key? key, required this.orderData}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    print("order data is: ");
    // print(widget.orderData.createdAt);
    print("order data done: ");
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(checkTitle: true, title: 'Order Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID: #${widget.orderData.id} ",
                style: KTextStyle.headline4.copyWith(
                  color: KColor.blackbg,
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Text(
                    "Placed on : ",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  Text(
                    // "6 May", '
                    widget.orderData.createdAt.toString(),
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Information",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.orderData.name,
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    widget.orderData.contact.toString(),
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "${widget.orderData.billingAddress}, ${widget.orderData.billingArea}, ${widget.orderData.billingZone}, ${widget.orderData.billingCity}",
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping Information",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    // "Mariam Crane", 
                    widget.orderData.name, 
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    // "+97 4556 7681", 
                   widget.orderData.contact,
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                                        "${widget.orderData.billingAddress}, ${widget.orderData.billingArea}, ${widget.orderData.billingZone}, ${widget.orderData.billingCity}",

                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AssetPath.confirmIcon, height: 18),
                          const SizedBox(width: 3),
                          Text(
                            widget.orderData.paymentType.toString(),
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(AssetPath.paypalLogo, height: 24)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Status",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.orderData.paymentStatus.toString(),
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.selectColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Info",
                    style: KTextStyle.subtitle1.copyWith(
                      color: KColor.blackbg,
                    ),
                  ),
                  const SizedBox(height: 16),
                 // list of product
                 ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.orderData.orderdetails.length,
                  itemBuilder:  (context, index){
                    return    Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: KColor.appBackground,
                      boxShadow: [
                        BoxShadow(
                          color: KColor.shadowColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: const Offset(4, 4), // changes position of shadow
                        ),
                        BoxShadow(
                          color: KColor.shadowColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: const Offset(-4, -4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   // 'assets/images/watch-two.png',
                        //   widget.orderData.orderdetails[index].product.productImage.toString(), 
                        //   height: 49,
                        // ),
                        Container(  
                         child:widget.orderData.orderdetails[index].product.productImage !=null? Image.asset(
                          'assets/images/watch-two.png',
                          // widget.orderData.orderdetails[index].product.productImage.toString(), 
                          height: 49,
                        ): Icon(Icons.error), 
                        ),
                        // Text(widget.orderData.orderdetails[index].product.productImage.toString()),
                       
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container( 
                              width: context.screenWidth * .60,
                              child: Text(
                                overflow: TextOverflow.ellipsis, 
                                widget.orderData.orderdetails[index].product.productName.toString(),
                                style: KTextStyle.bodyText2.copyWith(
                                  color: KColor.blackbg,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$${widget.orderData.orderdetails[index].price.toString()}",
                                  style: KTextStyle.subtitle1.copyWith(
                                    color: KColor.blackbg,
                                  ),
                                ),
                                SizedBox(width: context.screenWidth * 0.35),
                                Text(
                                  "(x${widget.orderData.orderdetails[index].quantity})",
                                  style: KTextStyle.description.copyWith(
                                    color: KColor.baseBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                
                  },
                 ),
               
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '\$${widget.orderData.subTotal.toString()}',
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping Fee',
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                  Text(
                                        '\$${widget.orderData.shippingPrice}',

                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: KColor.dividerColor.withOpacity(0.2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                  Text(
                                        '\$${widget.orderData.grandTotal}',
                    style: KTextStyle.bodyText1.copyWith(
                      color: KColor.blackbg.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.05),
              KButton(
                title: 'Write a Review',
                onTap: () {
                  Navigator.pushNamed(context, '/writeReview');
                },
              ),
              const SizedBox(height: 16),
              KBorderButton(
                title: 'Track Order',
                onTap: () {
                  Navigator.pushNamed(context, '/trackOrder');
                },
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
