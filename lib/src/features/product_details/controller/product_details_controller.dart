import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/filter/model/color_and_size_model.dart';
import 'package:finesse/src/features/product_details/model/all_branda.dart';
import 'package:finesse/src/features/product_details/model/product_details_model.dart';
import 'package:finesse/src/features/product_details/state/product_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final productDetailsProvider = StateNotifierProvider<ProductDetailsController, BaseState>(
  (ref) => ProductDetailsController(ref: ref),
);

final allBrandsProvider = StateNotifierProvider<AllBrandController, BaseState>(
  (ref) => AllBrandController(ref: ref),
);


final colorAndSizeProvider = StateNotifierProvider<ColorAndSizeController, BaseState>(
  (ref) => ColorAndSizeController(ref: ref),
);

/// Controllers
class ProductDetailsController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductDetailsController({this.ref}) : super(const InitialState());
  ProductDetailsModel? productDetailsModel;
  ColorAndSizeModel? colorAndSizeModel;

  
  updateSuccessState() {
    state = ProductDetailsSuccessState(productDetailsModel);
  }

  Future fetchProductsDetails(productId) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.productDetails(productId)),
      );
      if (responseBody != null) {
        productDetailsModel = ProductDetailsModel.fromJson(responseBody);
        state = ProductDetailsSuccessState(productDetailsModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}

class AllBrandController extends StateNotifier<BaseState> {
  final Ref? ref;

  AllBrandController({this.ref}) : super(const InitialState());
  BrandModel? brandModel;
  Future fetchAllBrands() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.allBrand),
      );
      if (responseBody != null) {
        brandModel = BrandModel.fromJson(responseBody);
        state = AllBrandsSuccessState(brandModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}


class ColorAndSizeController extends StateNotifier<BaseState>{
  final Ref? ref; 
   ColorAndSizeController({this.ref}) : super(const InitialState());
  Future fetchAllColorAndSize()async{
    ColorAndSizeModel ? colorAndSizeModel; 
    var responseBody; 
    try{
      state = LoadingState(); 
      responseBody =await Network.handleResponse(await Network.getRequest(API.colorAndSize));
      if(responseBody != null){
        colorAndSizeModel = ColorAndSizeModel.fromJson(responseBody); 
        state =  AllColorAndSizeSuccessState(colorAndSizeModel) ; 
      }else{
        state =const  ErrorState(); 
      }

    }catch(error, stack){
      print(error); 
      print(stack) ; 
      state = ErrorState();
    }
  }
}