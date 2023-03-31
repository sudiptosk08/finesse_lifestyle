import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/filter/model/color_and_size_model.dart';
import 'package:finesse/src/features/product_details/model/all_branda.dart';
import 'package:finesse/src/features/product_details/model/all_colors.dart';
import 'package:finesse/src/features/product_details/model/product_details_model.dart';
import 'package:finesse/src/features/product_details/model/review_model.dart';

class ProductDetailsSuccessState extends SuccessState {
  final ProductDetailsModel? productDetailsModel;

  const ProductDetailsSuccessState(
    this.productDetailsModel,
  );
}

class AllBrandsSuccessState extends SuccessState {
  final BrandModel? brandModel;

  const AllBrandsSuccessState(this.brandModel);
}

class AllColorAndSizeSuccessState extends SuccessState{
  final ColorAndSizeModel? colorAndSizeModel; 
  AllColorAndSizeSuccessState(this.colorAndSizeModel);
}

class ReviewsSuccessState extends SuccessState {
  final List<ReviewModel>? reviewModel;

  const ReviewsSuccessState(this.reviewModel);
}

class AddReviewSuccessState extends SuccessState {
  const AddReviewSuccessState();
}
