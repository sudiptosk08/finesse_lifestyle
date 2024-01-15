import 'dart:core';
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
  String? zoneName;
  String? zoneId;

  void zoneNameSet(String? zone, String? id) async {
    zoneName = zone;
    zoneId = id;
    ref!.read(areaProvider.notifier).areaNameSet(null, null);
  }

  void makeZoneNull() {
    zoneName = null;
    zoneId = null;
    zoneModel = null;
    state = EmptyState();
  }

  Future allZone(
      {id = "",
      zoneId,
      isUpdateBillingInfo = false,
      isShippingAddressPage = false}) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.allZone(id: id)));
      if (responseBody != null) {
        zoneModel = ZoneModel.fromJson(responseBody);
        state = ZoneSuccessState(zoneModel);
        if (isUpdateBillingInfo == false && isShippingAddressPage == false) {
          totalDelivery();
        }
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  // void totalDelivery() {
  //   subtotal = ref?.read(cartProvider.notifier).subtotal as int;
  //   countTotalFee = subtotal + deliveryFee;
  //   print(countTotalFee);
  // }
  // update deliveryfee if AddBillingAddress page  upadate click

  void updateTotalDelivery({ifZoneNotCall = false, zoneN}) {
    if (ifZoneNotCall) {
      if (zoneN == "Sylhet Sadar") {
        deliveryFee = 50;
      } else {
        deliveryFee = 100;
      }
    } else {
      if (zoneName == "Sylhet Sadar") {
        deliveryFee = 50;
      } else {
        for (int i = 0; i < zoneModel!.zones.length; i++) {
          deliveryFee = zoneModel!.zones[i].delivery!;
          print("the kking deliverfee:  $deliveryFee");
        }
      }
    }

    subtotal = ref?.read(cartProvider.notifier).subtotal as int;
    countTotalFee = subtotal + deliveryFee;
    print(countTotalFee);
  }

// calculation for all
  void totalDelivery() {
    if (zoneName == "Sylhet Sadar") {
      deliveryFee = 50;
    } else {
      for (int i = 0; i < zoneModel!.zones.length; i++) {
        deliveryFee = zoneModel!.zones[i].delivery!;
        print("the kking deliverfee:  $deliveryFee");
      }
    }

    subtotal = ref?.read(cartProvider.notifier).subtotal as int;
    // subtotal += deliveryFee; 
    countTotalFee = subtotal + deliveryFee;
    print(countTotalFee);
  }
}

class CityController extends StateNotifier<BaseState> {
  final Ref? ref;

  CityController({this.ref}) : super(const InitialState());
  CityModel? cityModel;
  String? cityName;
  String? cityId;
  void cityNameSet(String? name, String? id) async {
    cityName = name;
    cityId = id;
    ref!.read(zoneProvider.notifier).zoneNameSet(null, null);
    ref!.read(areaProvider.notifier).areaNameSet(null, null);
  }

  void makeCityNull() {
    cityName = null;
    cityId = null;
  }

  Future allCity({cityId}) async {
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
  String? areaName;
  String? areaId;
  void areaNameSet(String? area, String? id) async {
    areaName = area;
    areaId = id;
  }

  void makeAreaNull() {
    areaName = null;
    areaId = null;
    areaModel = null;
    state = EmptyState();
  }

  Future allArea({id = "", areaId}) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.allArea(zoneId: id)));
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
