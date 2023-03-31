import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/home/models/shop_data_model.dart';
import 'package:finesse/src/features/home/state/shop_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final shopProvider = StateNotifierProvider<ShopController, BaseState>(
  (ref) => ShopController(ref: ref),
);

/// Controllers
class ShopController extends StateNotifier<BaseState> {
  final Ref? ref;

  ShopController({this.ref}) : super(const InitialState());
  ShopDataModel? shopDataModel;
  List<ShopDataModel>? searchModel = [];

  Future fetchShopProductList({str, groupId, categoryId ='', brandId='' , price='' , color='', size=''}) async {
    state = const LoadingState();
    
    dynamic responseBody;

    //for filter page value
          price = price ==null ? '':price.toString(); 
       brandId = brandId ==null ? '':brandId.toString(); 
        color = color ==null ? '':color.toString(); 
         size = size ==null ? '':size.toString(); 
    
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.shop(str: str, groupId: groupId, categoryId: categoryId , price: price, colour: color,size: size)),
      );

      if (responseBody != null) {
        shopDataModel = ShopDataModel.fromJson(responseBody);
        state = ShopSuccessState(shopDataModel);
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
