import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/home/controllers/shop_pagination_controler.dart';
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
  ShopDataModel? shopDataInstance;
  List<ShopDataModel>? searchModel = [];
  int limit = 0;
  Future fetchShopProductList(
      {str,
      groupId,
      categoryId = '',
      brandId = '',
      price = '',
      color = '',
      size = ''}) async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    groupId = groupId == null ? '' : groupId;
    str = str == null ? '' : str.toString();
    categoryId = categoryId == null ? '' : categoryId.toString();
    price = price == null ? '' : price.toString();
    brandId = brandId == null ? '' : brandId.toString();
    color = color == null ? '' : color.toString();
    size = size == null ? '' : size.toString();

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.shop(
            str: str,
            groupId: groupId,
            categoryId: categoryId,
            price: price,
            brandId: brandId,
            colour: color,
            size: size)),
      );

      if (responseBody != null) {
        shopDataModel = ShopDataModel.fromJson(responseBody);
        limit = shopDataModel!.products!.length;
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

  Future fetchMoreShopProductList(
      {str, groupId, categoryId, brandId, price, color, size}) async {
    if (shopDataModel == null) state = const LoadingState();

    var responseBody;
    //for filter page value
    str = str == null ? '' : str.toString();

    groupId = groupId == null ? '' : groupId.toString();
    categoryId = categoryId == null ? '' : categoryId.toString();
    price = price == null ? '' : price.toString();
    brandId = brandId == null ? '' : brandId.toString();
    color = color == null ? '' : color.toString();
    size = size == null ? '' : size.toString();

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.shop(
            limit: limit += 20,
            str: str,
            groupId: groupId,
            categoryId: categoryId,
            price: price,
            brandId: brandId,
            colour: color,
            size: size)),
      );

      if (responseBody != null) {
        shopDataModel = ShopDataModel.fromJson(responseBody);
      
        state = ShopSuccessState(shopDataModel);
        ref!.read(shopListScrollProvider.notifier).resetState();
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }
}
