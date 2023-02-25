import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/cart/model/area_model.dart';
import 'package:finesse/src/features/cart/model/city_model.dart';
import 'package:finesse/src/features/cart/model/zone_model.dart';
import 'package:finesse/src/features/cart/state/zone_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_controller.dart';

/// Providers
final zoneProvider = StateNotifierProvider<ZoneController, BaseState>(
  (ref) => ZoneController(ref: ref),
);
final cityProvider = StateNotifierProvider<CityController, BaseState>(
  (ref) => CityController(ref: ref),
);
final areaProvider = StateNotifierProvider<AreaController, BaseState>(
  (ref) => AreaController(ref: ref),
);

/// Controllers
class ZoneController extends StateNotifier<BaseState> {
  final Ref? ref;

  ZoneController({this.ref}) : super(const InitialState());
  ZoneModel? zoneModel;
  int deliveryFee = 0;
  int roundingFee = 0;
  int subtotal = 0;
  int totalAmount = 0;
  int countTotalFee = 0;

  Future allZone({id = ""}) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.allZone(id: id)));
      if (responseBody != null) {
        zoneModel = ZoneModel.fromJson(responseBody);
        state = ZoneSuccessState(zoneModel);
        totalDelivery();
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  void totalDelivery() {
    for (int i = 0; i < zoneModel!.zones.length; i++) {
      deliveryFee = zoneModel!.zones[i].delivery!;
      print(deliveryFee);
     
    }
    subtotal = ref?.read(cartProvider.notifier).subtotal as int;
    countTotalFee = subtotal + deliveryFee;
    print(countTotalFee);
  }
}

class CityController extends StateNotifier<BaseState> {
  final Ref? ref;

  CityController({this.ref}) : super(const InitialState());
  CityModel? cityModel;

  Future allCity() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody =
          await Network.handleResponse(await Network.getRequest(API.allCity));
      if (responseBody != null) {
        cityModel = CityModel.fromJson(responseBody);
        state = CitySuccessState(cityModel);
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

class AreaController extends StateNotifier<BaseState> {
  final Ref? ref;

  AreaController({this.ref}) : super(const InitialState());
  AreaModel? areaModel;

  Future allArea({zoneId = ""}) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.allArea(zoneId: zoneId)));
      if (responseBody != null) {
        areaModel = AreaModel.fromJson(responseBody);
        state = AreaSuccessState(areaModel);
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
