import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/home/models/menu_data_model.dart';
import 'package:finesse/src/features/home/state/menu_data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/login/model/user_model.dart';

final menuDataProvider = StateNotifierProvider<MenuDataController, BaseState>(
  (ref) => MenuDataController(ref: ref),
);

class MenuDataController extends StateNotifier<BaseState> {
  final Ref? ref;
  MenuDataController({this.ref}) : super(const InitialState());

  MenuDataModel? menuList;

  Future fetchMenuData() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.initdata),
      );
      if (responseBody != null) {
        menuList = MenuDataModel.fromJson(responseBody)
        ;

        state = MenuDataSuccessState(menuList);
      }
    } catch (error, stackTrace) {
      print('fetchMenuData() error = $error');
      print(stackTrace);
      state = const ErrorState();
    }
  }
}
