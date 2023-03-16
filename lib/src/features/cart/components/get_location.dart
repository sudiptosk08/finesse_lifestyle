import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/cart/model/area_model.dart';
import 'package:finesse/src/features/cart/model/city_model.dart';
import 'package:finesse/src/features/cart/model/zone_model.dart';
import 'package:finesse/src/features/cart/state/zone_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:finesse/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  City? city;
  String? cities = "City";
  String? zones = "Zone";
  String? areas = "Area";
  String selectedCity = "";
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
                            cities.toString(),
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
                        SizedBox(width: 5),
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
                      cities = v.name!;
                      ref.read(zoneProvider.notifier).allZone(id: v.id);
                      ref
                          .read(cityProvider.notifier)
                          .cityNameSet(cityData!, cities.toString());
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12.84,
            ),
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
                            zones.toString(),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText1.copyWith(
                              color: KColor.blackbg.withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
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
                      ref.read(areaProvider.notifier).allArea(zoneId: v.id);
                      ref
                          .read(zoneProvider.notifier)
                          .zoneNameSet(zoneData!, zones.toString());
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12.84,
            ),
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
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
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
                        SizedBox(width: 15),
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
                      ref
                          .read(areaProvider.notifier)
                          .areaNameSet(areaData!, areas.toString());
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
}
