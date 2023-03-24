import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/login/model/user_model.dart';

abstract class  AddressState{}

class AddressInitial extends InitialState{}
class AddressLoadingState extends SuccessState{}

class AddressSuccessState extends  SuccessState{}

class ShippingAddressSuccessState extends SuccessState{
  User? userModel; 
  ShippingAddressSuccessState(this.userModel);
}
class AddressErrorState extends  ErrorState{}