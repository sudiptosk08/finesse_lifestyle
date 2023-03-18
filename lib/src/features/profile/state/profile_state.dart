import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/profile/model/report_model.dart';
import 'package:finesse/src/features/profile/model/order_model.dart';

class ReportSuccessState extends SuccessState {
  const ReportSuccessState();
}

class OrderSuccessState extends SuccessState {
  const OrderSuccessState();
}

class FetchReportSuccessState extends SuccessState {
  ReportModel? reportModel;

  FetchReportSuccessState(this.reportModel);
}
class FetchOrderSuccessState extends SuccessState{
  OrderModel? orderModel; 
  FetchOrderSuccessState(this.orderModel);
}

class EditProfileSuccessState extends SuccessState {
  const EditProfileSuccessState();
}
