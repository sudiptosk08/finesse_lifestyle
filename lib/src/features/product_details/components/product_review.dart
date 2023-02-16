
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/components/textfield/k_description_field.dart';
import 'package:finesse/src/features/filter/components/rating.dart';
import 'package:finesse/src/features/product_details/controller/product_details_controller.dart';
import 'package:finesse/src/features/product_details/controller/reviews_controller.dart';
import 'package:finesse/src/features/product_details/model/review_model.dart';
import 'package:finesse/src/features/product_details/state/product_details_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_size.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../constants/asset_path.dart';
import '../../../../core/base/base_state.dart';

class ProductReview extends StatefulWidget {
  String productId;
  String userId;
  ProductReview({
    required this.productId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  TextEditingController comment = TextEditingController();
  var userRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productDetailsState = ref.watch(productDetailsProvider);
      final productDetails = productDetailsState is ProductDetailsSuccessState
          ? productDetailsState.productDetailsModel
          : null;
      final reviewsState = ref.watch(reviewsProvider);
      final List<ReviewModel>? reviewsList =
          reviewsState is ReviewsSuccessState ? reviewsState.reviewModel : [];
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a Review',
                style: KTextStyle.subtitle7.copyWith(color: KColor.baseBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your Rating',
                style: KTextStyle.bodyText2
                    .copyWith(color: KColor.baseBlack.withOpacity(0.5)),
              ),
              const SizedBox(
                height: 10,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                glowRadius: 0,
                itemSize: 15,
                unratedColor: KColor.filterDividerColor,
                itemBuilder: (ctx, index) => SvgPicture.asset(
                    AssetPath.startIcon,
                    height: 30,
                    color: KColor.rattingColor),
                onRatingUpdate: (rating) {
                  userRating = rating;
                  print('$rating');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Comment",
                style: KTextStyle.bodyText2
                    .copyWith(color: KColor.baseBlack.withOpacity(0.5)),
              ),
              const SizedBox(
                height: 10,
              ),
              DescriptionTextField(
                  label: "",
                  controller: comment,
                  hintText: "Write your review here",
                  checkColor: false,
                  readOnly: false),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: KSize.getWidth(context, 100),
                child: KButton(
                    title:"Submit"  ,
                    onTap: ()  {
                      if (reviewsState is! LoadingState) {
                        ref.read(reviewsProvider.notifier).addProductReviews(
                          rating: userRating.toString(),
                          comment:comment.text,
                          productId: widget.productId,
                          userId: widget.userId,
                          );
                      }
                    }),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Ratings & Reviews ',
                      style: KTextStyle.subtitle7
                          .copyWith(color: KColor.baseBlack),
                    ),
                    TextSpan(
                      text: '(${productDetails!.product!.reviews})',
                      style: KTextStyle.subtitle7.copyWith(
                        color: KColor.baseBlack.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              // Text(
              //   'View all',
              //   style: KTextStyle.bodyText3.copyWith(
              //     color: KColor.baseBlack.withOpacity(0.3),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 26),
          reviewsState is ReviewsSuccessState
              ? reviewsList!.isEmpty
                  ? const Center(child: Text('No reviews yet!'))
                  : ListView.builder(
                      itemCount: reviewsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: reviewsList[index].user?.name,
                                        style: KTextStyle.bodyText2.copyWith(
                                            color: KColor.baseBlack
                                                .withOpacity(0.8)),
                                      ),
                                      TextSpan(
                                        text:
                                            '  ${DateFormat('d MMM y').format(DateTime.parse(reviewsList[index].createdAt))}',
                                        style: KTextStyle.bodyText1.copyWith(
                                            color: KColor.baseBlack
                                                .withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                ),
                                IgnorePointer(
                                  child: Rating(
                                      starHeight: 20,
                                      initialRating: reviewsList[index]
                                          .rating!
                                          .toDouble()),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              reviewsList[index].content ?? '',
                              style: KTextStyle.description.copyWith(
                                  color: KColor.blackbg.withOpacity(0.5)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Divider(
                                  color: KColor.dividerColor.withOpacity(0.1)),
                            ),
                          ],
                        );
                      },
                    )
              : const Center(child: CupertinoActivityIndicator()),
        ],
      );
    });
  }
}
