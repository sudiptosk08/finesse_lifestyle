import 'dart:convert';
import 'dart:core';
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/auth/login/state/login_state.dart';
import 'package:finesse/src/features/cart/model/area_model.dart';
import 'package:finesse/src/features/cart/model/city_model.dart';
import 'package:finesse/src/features/cart/model/zone_model.dart';
import 'package:finesse/src/features/cart/state/zone_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

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
  

  zoneNameSet(String zone, String id) async {
    if (zone != null) {
      zoneName = zone;
      // setValue('${zone}', e.zoneName.toString());
    }
  }

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

  Future<bool> isLocationSet(String addressN) async {
    String? zoneN = ref!.read(zoneProvider.notifier).zoneName;
    String? cityN = ref!.read(cityProvider.notifier).cityName;
    String? areaN = ref!.read(areaProvider.notifier).areaName;
    if (cityN == null) {
      toast("City not set!", textColor: KColor.red12);
      return false;
    }
    if (zoneN == null) {
      toast("Zone not set!", textColor: KColor.red12);
      return false;
    }
    if (areaN == null) {
      toast("area not set!", textColor: KColor.red12);
      return false;
    }

    await setValue(addressName, addressN);
    await setValue(city, cityN);
    await setValue(zone, zoneN);
    await setValue(area, areaN);
    await setValue(userNameToOrder, getStringAsync(userName));
    await setValue(userContractToOrder, getStringAsync(userContact));

    totalDelivery();
    return true;
  }

  void totalDelivery() {
    for (int i = 0; i < zoneModel!.zones.length; i++) {
      deliveryFee = zoneModel!.zones[i].delivery!;
      print("the kking deliverfee:  ${deliveryFee}");
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
  String? cityName;
  cityNameSet(String name, String id) async {
    if (name != null) {
      cityName = name;
      // setValue('${city}', e.name);
    }
  }

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
  String? areaName;
  areaNameSet(String area, String id) async {
    if (area != null) {
      areaName = area;
      // setValue('${area}', e.name);
    }
  }

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
