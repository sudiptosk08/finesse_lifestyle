import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/service/navigation_service.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/checkout/components/take_address.dart';
import 'package:finesse/src/features/checkout/state/add_address.dart';
import 'package:finesse/src/features/home/controllers/menu_data_controller.dart';
import 'package:finesse/src/features/home/models/menu_data_model.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final addressProvider = StateNotifierProvider<AddAddressController, BaseState>(
    (ref) => AddAddressController(ref: ref));

class AddAddressController extends StateNotifier<BaseState> {
  final Ref? ref;
  AddAddressController({this.ref}) : super(const InitialState());

  Future AddShippingAddress(
      {required context,
      required String nameis,
      required String emailis,
      required String phoneis,
      required String addressis}) async {
    state = AddressLoadingState();
    String? cityis = ref?.read(cityProvider.notifier).cityName;
    String? cityId = ref?.read(cityProvider.notifier).cityId;

    String? zoneis = ref?.read(zoneProvider.notifier).zoneName;
    String? zoneId = ref?.read(zoneProvider.notifier).zoneId;

    String? areais = ref?.read(areaProvider.notifier).areaName;
    String? areaId = ref?.read(areaProvider.notifier).areaId;
    try {
      if (nameis.isEmpty) {
        toast('Name not Set!');
        state = AddressErrorState();
      } else if (emailis.isEmpty) {
        toast('Email not Set!');
      } else if (phoneis.isEmpty) {
        state = AddressErrorState();
        toast('phone not Set!');
      } else if (cityis == null) {
        toast('City not Set!');
        state = AddressErrorState();
      } else if (zoneis == null) {
        toast('Zone not Set!');
        state = AddressErrorState();
      } else if (areais == null) {
        toast('area not Set!');
        state = AddressErrorState();
      } else if (addressis.isEmpty) {
        toast('Address not Set!');
        state = AddressErrorState();
      } else {
        Map<String, dynamic> address = {
          'name': nameis,
          'phone': phoneis,
          'email': emailis,
          'city': cityis,
          'cityId': cityId,
          'zone': zoneis,
          'zoneId': zoneId,
          'area': areais,
          'areaId': areaId,
          'address': addressis
        };

        await setValue(shippingAddress, address);
        ref?.read(addressProvider.notifier).makeAddressNull();
        state = AddressSuccessState();
        toast('Shipping Address added');
        print("inside add shipping method : ${getJSONAsync(shippingAddress)}");
        Navigator.of(context).pop();
      }
    } catch (e) {
      state = AddressErrorState();
    }
  }

  void makeAddressNull() {
    ref!.read(zoneProvider.notifier).makeZoneNull();
    ref!.read(cityProvider.notifier).makeCityNull();
    ref!.read(areaProvider.notifier).makeAreaNull();
  }

  void setLocationNameOnce(User userData) {
    

    if (billingAddressMap.isEmpty) {
      if (userData.customer.area != null &&
          userData.customer.city != null &&
          userData.customer.zone != null) {
        setTempAddress(
            cityN: userData.customer.city,
            cityId: userData.customer.cityId.toString(),
            zoneN: userData.customer.zone,
            zoneId: userData.customer.zoneId.toString(),
            areaN: userData.customer.area,
            areaId: userData.customer.areaId.toString());
        ref!.read(zoneProvider.notifier).updateTotalDelivery(
            ifZoneNotCall: true, zoneN: userData.customer.zone);
        //          billingAddressMap['city'] = userData.customer.city;
        // billingAddressMap['cityId'] = userData.customer.cityId;
        // billingAddressMap['zone'] =userData.customer.zone;
        // billingAddressMap['zoneId'] = userData.customer.zoneId;
        // billingAddressMap['area'] = userData.customer.area;
        // billingAddressMap['areaId'] = userData.customer.areaId!;
        // ref!.read(cityProvider.notifier).cityNameSet(
        //     userData.customer.city, userData.customer.cityId.toString());
        // ref!.read(zoneProvider.notifier).zoneNameSet(
        //     userData.customer.zone, userData.customer.zoneId.toString());
        // ref!.read(areaProvider.notifier).areaNameSet(
        //     userData.customer.area, userData.customer.areaId.toString());
      }
    }
  }

  Future<bool> isLocationSet() async {
    String? zoneN = billingAddressMap['zone'];
    String? zoneId = billingAddressMap['zoneId'];
    String? cityN = billingAddressMap['city'];
    String? cityId = billingAddressMap['cityId'];
    String? areaN = billingAddressMap['area'];
    String? areaId = billingAddressMap['areaId'];
    if (cityN == null) {
      toast("City not set!", textColor: KColor.red12);
      return false;
    }
    if (zoneN == null) {
      toast("Zone not set!", textColor: KColor.red12);
      return false;
    }
    if (areaN == null) {
      toast("Area not set!", textColor: KColor.red12);
      return false;
    }
    setTempAddress(
        cityN: cityN,
        cityId: cityId!,
        zoneN: zoneN,
        zoneId: zoneId!,
        areaN: areaN,
        areaId: areaId!);

    return true;
  }

  void setTempAddress({
    required String cityN,
    required String cityId,
    required String zoneN,
    required String zoneId,
    required String areaN,
    required String areaId,
  }) {
    billingAddressMap.clear();
    billingAddressMap['city'] = cityN;
    billingAddressMap['cityId'] = cityId;
    billingAddressMap['zone'] = zoneN;
    billingAddressMap['zoneId'] = zoneId;
    billingAddressMap['area'] = areaN;
    billingAddressMap['areaId'] = areaId;
  }

  Future addBillingINfo(
      {required context,
      required String nameis,
      required String emailis,
      required String phoneis,
      required String addressis}) async {
    state = const LoadingState();
    String? cityis = ref?.read(cityProvider.notifier).cityName;
    String? cityId = ref?.read(cityProvider.notifier).cityId;

    String? zoneis = ref?.read(zoneProvider.notifier).zoneName;
    String? zoneId = ref?.read(zoneProvider.notifier).zoneId;

    String? areais = ref?.read(areaProvider.notifier).areaName;
    String? areaId = ref?.read(areaProvider.notifier).areaId;
    try {
      if (nameis.isEmpty) {
        toast('Name not Set!');
        state = AddressErrorState();
      } else if (emailis.isEmpty) {
        toast('Email not Set!');
      } else if (phoneis.isEmpty) {
        state = AddressErrorState();
        toast('phone not Set!');
      } else if (cityis == null) {
        toast('City not Set!');
        state = AddressErrorState();
      } else if (zoneis == null) {
        toast('Zone not Set!');
        state = AddressErrorState();
      } else if (areais == null) {
        toast('area not Set!');
        state = AddressErrorState();
      } else if (addressis.isEmpty) {
        toast('Address not Set!');
        state = AddressErrorState();
      } else {
        User user = ref!.read(menuDataProvider.notifier).menuList!.user;
        dynamic responseBody;
        var requestBody = {
          "id": user.id,
          "name": nameis,
          "email": emailis,
          "customer": {
            "id": user.customer.id,
            "userId": user.customer.userId,
            "customerName": nameis,
            "address": addressis,
            "email": emailis,
            "zone": zoneis,
            "facebook": user.customer.facebook,
            "instagram": user.customer.instagram,
            "barcode": user.customer.barcode,
            "cityId": cityId,
            "areaId": areaId,
            "zoneId": zoneId,
            "postCode": user.customer.postCode,
          }
        };
        User? userModel;
        try {
          dynamic responseBody;
          responseBody = await Network.handleResponse(
              await Network.postRequest(API.updateUser, requestBody));
          if (responseBody != null) {
            setTempAddress(
                cityN: cityis,
                cityId: cityId.toString(),
                zoneN: zoneis,
                zoneId: zoneId.toString(),
                areaN: areais,
                areaId: areaId.toString());
            ref!.read(zoneProvider.notifier).updateTotalDelivery();
            toast("Billing Information Updated");
            ref?.read(addressProvider.notifier).makeAddressNull();
            state = ShippingAddressSuccessState(userModel);
            Navigator.of(context).pop();
          }
        } catch (error, stackTrace) {
          print("fucking proble arice");
          print(error);
          print(stackTrace);
          state = const ErrorState();
        }

        state = AddressSuccessState();
        toast('Shipping Address added');
      }
    } catch (e) {
      state = AddressErrorState();
    }
  }
}
