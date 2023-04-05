import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/core/network/api.dart';
import 'package:finesse/core/network/network_utils.dart';
import 'package:finesse/src/features/notification/model/notification_model.dart';
import 'package:finesse/src/features/notification/state/notification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final notificationProvider = StateNotifierProvider<NotificationController, BaseState>(
  (ref) => NotificationController(ref: ref),
);

/// Controllers
class NotificationController extends StateNotifier<BaseState> {
  final Ref? ref;

  NotificationController({this.ref}) : super(const InitialState());
  NotificationModel? notificationModel;

  Future fetchNotification() async {
    state = const LoadingState();

    dynamic responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getNotification),
      );
      if (responseBody != null) {
        notificationModel = NotificationModel.fromJson(responseBody);
        state = GetNotificationSuccessState(notificationModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future deleteNotification({required String id}) async {
    state = const LoadingState();

    dynamic responseBody;
    var requestBody = {'id': id};

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.deleteNotification, requestBody),
      );
      if (responseBody != null) {
        // state = const DeleteNotificationSuccessState();
        fetchNotification(); 
        // if (responseBody['token'] != null) {
        //   state = const DeleteNotificationSuccessState();
        //   setValue(isLoggedIn, true);
        //   setValue(token, responseBody['token']);
        //   toast(
        //     "Delete Notification Successfully",
        //     bgColor: KColor.selectColor,
        //   );
        //   fetchNotification();
        //   NavigationService.navigateToReplacement(
        //     CupertinoPageRoute(
        //       builder: (context) => const ProductInfo(),
        //     ),
        //   );
        // }
      } else {
        // state = const ErrorState();
        toast("Not deleted! Something went wrong.");
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
       toast("Not deleted! Something went wrong.");
      state = const ErrorState();
    }
  }

  Future updateNotification({required String id}) async {
    state = const LoadingState();

    dynamic responseBody;
    var requestBody = {'id': id};
    print("update notification called");
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.updateNotification, requestBody),
      );
      if (responseBody != null) {
          state = GetNotificationSuccessState(notificationModel);
          fetchNotification();
        //  state = const UpdateNotificationSuccessState();
        // if (responseBody['token'] != null) {
        //   state = const UpdateNotificationSuccessState();
        //   setValue(isLoggedIn, true);
        //   setValue(token, responseBody['token']);
        //   toast(
        //     "Update Notification Successfully",
        //     bgColor: KColor.selectColor,
        //   );
        //    print("update notification successfull");
        //   //  fetchNotification();
        //   NavigationService.navigateToReplacement(
        //     CupertinoPageRoute(
        //       builder: (context) => const ProductInfo(),
        //     ),
        //   );
        // }
      } else {
         print("update notification error");
        // state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      // state = const ErrorState();
    }
  }
}
