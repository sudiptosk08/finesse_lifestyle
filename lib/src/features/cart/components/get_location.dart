import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/cart/model/area_model.dart';
import 'package:finesse/src/features/cart/model/city_model.dart';
import 'package:finesse/src/features/cart/model/zone_model.dart';
import 'package:finesse/src/features/cart/state/zone_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// ignore: must_be_immutable
class DeliveryAddress extends StatefulWidget {
  bool? isCheckoutPage;
  bool isBilliingInfoPage;
  bool isShippingAddressPage;
  DeliveryAddress(
      {Key? key,
      this.isCheckoutPage = false,
      this.isBilliingInfoPage = false,
      this.isShippingAddressPage = false})
      : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  // City? city;
  String? cities = "City";
  String? zones = "Zone";
  String? areas = "Area";
  String selectedCity = "";
  String addressKey = 'null';
  @override
  void initState() {
    // cities = getStringAsync(city);
    // zones = getStringAsync(zone);
    // areas = getStringAsync(area);

    //  addressKey = tempAddressMap[tempAdrKey]![TempAdrKeyName]!;
    print("billist map in get location : $billingAddressMap");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final cityState = ref.watch(cityProvider);
        final zoneState = ref.watch(zoneProvider);
        final areaState = ref.watch(areaProvider);

        // changet final to non final
        List<City>? cityData =
            cityState is CitySuccessState ? cityState.cityModel?.cities : [];
        List<Zone>? zoneData =
            zoneState is ZoneSuccessState ? zoneState.zoneModel?.zones : [];
        List<Area>? areaData =
            areaState is AreaSuccessState ? areaState.areaModel?.areas : [];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("City"),
            SizedBox(
              height: 45,
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: KColor.searchColor.withOpacity(0.8), width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)),
                child: PopupMenuButton<City>(
                  itemBuilder: (context) {
                    return cityData!.map((str) {
                      return PopupMenuItem(
                        value: str,
                        child: Text(str.name!),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                           ( widget.isCheckoutPage! || widget.isBilliingInfoPage)  &&
                                    billingAddressMap.isNotEmpty
                                ? billingAddressMap['city'].toString()
                                : ref.read(cityProvider.notifier).cityName ??
                                    cities.toString(),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  onSelected: (v) {
                    // Tools.hideKeyboard(context);
                    setState(() {
                      if (widget.isCheckoutPage == true) {
                        billingAddressMap.clear();
                        billingAddressMap['city'] = v.name!;
                        billingAddressMap['cityId'] = v.id.toString();
                      }
                      cities = v.name!;
                      ref.read(zoneProvider.notifier).allZone(
                          id: v.id,
                          isUpdateBillingInfo: widget.isBilliingInfoPage);
                      ref
                          .read(cityProvider.notifier)
                          .cityNameSet(cities.toString(), v.id.toString());
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12.84,
            ),
            text("Zone"),
            SizedBox(
              height: 45,
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: KColor.searchColor.withOpacity(0.8), width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)),
                child: PopupMenuButton<Zone>(
                  itemBuilder: (context) {
                    return zoneData!.map((str) {
                      return PopupMenuItem(
                        value: str,
                        child: Text(str.zoneName.toString()),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                           ( widget.isCheckoutPage! || widget.isBilliingInfoPage )&&
                                    billingAddressMap.containsKey('zone')
                                ? billingAddressMap['zone'].toString()
                                : ref.read(zoneProvider.notifier).zoneName ??
                                    zones.toString(),

                            // ref.read(zoneProvider.notifier).zoneName??  zone.toString(),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  onSelected: (v) {
                    setState(() {
                      zones = v.zoneName;
                      if (widget.isCheckoutPage!) {
                        billingAddressMap['zone'] = v.zoneName!;
                        billingAddressMap['zoneId'] = v.id.toString();
                      }

                      ref.read(areaProvider.notifier).allArea(
                            id: v.id,
                          );
                      ref
                          .read(zoneProvider.notifier)
                          .zoneNameSet(v.zoneName.toString(), v.id.toString());
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12.84,
            ),
            text("Area"),
            SizedBox(
              height: 45,
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: KColor.searchColor.withOpacity(0.8), width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)),
                child: PopupMenuButton<Area>(
                  itemBuilder: (context) {
                    return areaData!.map((str) {
                      return PopupMenuItem(
                        value: str,
                        child: Text(str.name),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            //  ref.read(areaProvider.notifier).areaName??  area.toString(),
                            (widget.isCheckoutPage! || widget.isBilliingInfoPage)&& 
                                    billingAddressMap.containsKey('area')
                                ? billingAddressMap['area'].toString()
                                : ref.read(areaProvider.notifier).areaName ??
                                    areas.toString(),

                               

                            softWrap: false,
                            //textScaleFactor: textScaleFactor,
                            // style: bodyRobotoTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  onSelected: (v) {
                    setState(() {
                      areas = v.name.toString();
                      if (widget.isCheckoutPage!) {
                        billingAddressMap['area'] = v.name;
                        billingAddressMap['areaId'] = v.id.toString();
                      }

                      ref
                          .read(areaProvider.notifier)
                          .areaNameSet(v.name.toString(), v.id.toString());
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  text(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, bottom: 10),
      child: Text(
        title,
        style: KTextStyle.subtitle7.copyWith(color: KColor.blackbg),
      ),
    );
  }
}
