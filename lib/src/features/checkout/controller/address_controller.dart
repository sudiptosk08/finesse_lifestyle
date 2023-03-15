
import 'package:finesse/constants/shared_preference_constant.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/service/navigation_service.dart';
import 'package:finesse/src/features/cart/controller/zone_controller.dart';
import 'package:finesse/src/features/checkout/components/take_address.dart';
import 'package:finesse/src/features/checkout/state/add_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final addressProvider =  StateNotifierProvider<AddAddressController,AddressState>((ref)=>AddAddressController(ref: ref));

class AddAddressController extends StateNotifier<AddressState>{
  final Ref? ref; 
  AddAddressController({this.ref}): super( AddressInitial());

  AddAddress({required String nameis,required String emailis , required String phoneis, required String addressLabel ,required String addressis})async{
    state =  AddressLoadingState(); 
   String? cityis = ref?.read(cityProvider.notifier).cityName ; 
   String? zoneis =  ref?.read(zoneProvider.notifier).zoneName ; 
   String? areais = ref?.read(areaProvider.notifier).areaName ; 
    try{
      if(nameis.isEmpty){
      toast('Name not Set!');
     }
    else if(emailis.isEmpty){
      toast('Email not Set!');
     }
     else if(phoneis.isEmpty){
      toast('phone not Set!');
     }
     else if(cityis == null){
      toast('City not Set!');
     }
     else if(zoneis == null){
      toast('Zone not Set!');
     }
     else if(addressis.isEmpty){
      toast('Address not Set!');
     }else{
     await setValue('${userNameToOrder}', nameis);
     await setValue('${addressLabel}', addressLabel);
     await setValue('${userEmailToOrder}', emailis);
     await setValue('${city}', cityis);
     await setValue('${zone}', zoneis);
     await setValue('${area}', areais);
      state =AddressSuccessState();
      toast('New Address added');
     NavigationService.navigateToReplacement(
            CupertinoPageRoute(
              builder: (context) =>  AddressPage(), 
            ),
          );
     }
    }catch(e){
      state = AddressErrorState();
    }
  }
}