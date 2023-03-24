import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/cart/model/area_model.dart';
import 'package:finesse/src/features/cart/model/city_model.dart';
import 'package:finesse/src/features/cart/model/zone_model.dart';


class ZoneSuccessState extends SuccessState {
   final ZoneModel? zoneModel;

  const ZoneSuccessState(this.zoneModel);
}
class EmptyState extends SuccessState{}


class CitySuccessState extends SuccessState {
  final CityModel? cityModel;

  const CitySuccessState(this.cityModel);
}
class AreaSuccessState extends SuccessState {
  final AreaModel? areaModel;

  const AreaSuccessState(this.areaModel);
}

