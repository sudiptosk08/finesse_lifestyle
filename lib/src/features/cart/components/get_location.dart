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
  String? cities;
  String? zones;
  String? areas;
  final bool? checkCities;
  final bool? checkZones;

  DeliveryAddress(
      {Key? key,
      this.cities,
      this.zones,
      this.areas,
      this.checkCities,
      this.checkZones})
      : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  City? city;
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


        // print("----start city ----------");
        // print(cityData);
        // print("----start city ----------");
        // print("----start zone ----------");
        // print(zoneData);
        // print("----start zone ----------");
        // print("----start area ----------");
        // print(areaData);
        // print("----start area ----------");
        if(widget.checkCities == true){
          zoneData = []; 
          areaData = [];
        }
        
        return Container(
          height: 48,
          width: context.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: KColor.searchColor.withOpacity(0.8)),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 9),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.checkCities == true
                      ? 'City'
                      : widget.checkZones == true
                          ? 'Zone'
                          : 'Area',
                  style: KTextStyle.bodyText1
                      .copyWith(color: KColor.blackbg.withOpacity(0.4)),
                ),
                dropdownColor: KColor.appBackground,
                menuMaxHeight: context.screenHeight * 0.5,
                alignment: AlignmentDirectional.centerStart,
                value: widget.checkCities == true
                    ? widget.cities
                    : widget.checkZones == true
                        ? widget.zones
                        : widget.areas,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: KColor.blackbg),
                iconSize: 16,
                onChanged: (newValue) {
                  setState(() {
                    if (widget.checkCities == true) {
                      widget.cities = newValue;
                      
                      ref
                          .read(cityProvider.notifier)
                          .cityNameSet(cityData!, widget.cities!);
                    } else if (widget.checkZones == true) {
                      widget.zones = newValue;

                      ref
                          .read(zoneProvider.notifier)
                          .zoneNameSet(zoneData!, widget.zones!);
                    } else {
                      widget.areas = newValue;

                      ref
                          .read(areaProvider.notifier)
                          .areaNameSet(areaData!, widget.areas!);
                    }
                    if (widget.checkCities == true) widget.zones = null;

                    if (widget.checkZones == true) widget.areas = null;
                  });
                  if (widget.checkCities == true){
                    setState(() {
                  
                      zoneData = [];
                      areaData = [];
                    });
                    ref.read(zoneProvider.notifier).allZone(id: widget.cities );
                  }
                  if (widget.checkZones == true) {
                    ref
                        .read(areaProvider.notifier)
                        .allArea(zoneId: widget.zones);
                  }

                  print("city : ${widget.cities}");
                  print("zones : ${widget.zones}");
                  print("area : ${widget.areas}");
                },
                items: widget.checkCities == true
                    ? cityData?.map(
                        (location) {
                          return DropdownMenuItem(
                            value: location.id.toString(),
                            child: Text(
                              location.name.toString() ?? '',
                              style: KTextStyle.bodyText1.copyWith(
                                color: KColor.blackbg.withOpacity(0.4),
                              ),
                            ),
                          );
                        },
                      ).toList()
                    : widget.checkZones == true && widget.checkCities == false
                        ? zoneData?.map(
                            (position) {
                              return DropdownMenuItem(
                                value: position.id.toString(),
                                child: Text(
                                  position.zoneName.toString(),
                                  style: KTextStyle.bodyText1.copyWith(
                                    color: KColor.blackbg.withOpacity(0.4),
                                  ),
                                ),
                              );
                            },
                          ).toList()
                        : areaData?.map(
                            (position) {
                              return DropdownMenuItem(
                                value: position.id.toString(),
                                child: Text(
                                  position.name.toString(),
                                  style: KTextStyle.bodyText1.copyWith(
                                    color: KColor.blackbg.withOpacity(0.4),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
